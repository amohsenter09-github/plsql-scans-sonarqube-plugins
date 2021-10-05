CREATE OR REPLACE PROCEDURE VMSCMS.sp_migr_rollback (
   p_migr_seq   IN       NUMBER,
   p_migruser   IN       NUMBER,
   p_errmsg     OUT      VARCHAR2
)
AS
   v_migr_seqno            NUMBER (5);
   v_check_otherset_card   VARCHAR2 (2)    := 'N';
   v_check_online_card     VARCHAR2 (2)    := 'N';
   v_online_txn            VARCHAR2 (2)    := 'N';
   v_chk_acct              NUMBER (5);
   v_check_card            NUMBER (5);
   v_txn_check             NUMBER (5);
   v_chk_roll              NUMBER (5);
   v_validate_flag         VARCHAR2 (2);
   v_instcode              NUMBER (5)      := 1;
   v_indx                  NUMBER (5);
   v_errmsg                VARCHAR2 (500);
   v_reason                VARCHAR2 (500);
   v_temp_pan              VARCHAR2 (20);
   v_temp_acct             VARCHAR2 (20);
   v_acct_file_cnt         NUMBER (5);
   v_card_file_cnt         NUMBER (5);
   v_tran_file_cnt         NUMBER (5);
   v_chk_invalid_seqno     NUMBER (5);
   v_chk_txn               NUMBER (5);

   CURSOR cur_file
   IS
      SELECT   mfi_file_name, mfi_process_date
          FROM migr_file_load_info
         WHERE mfi_migr_seqno = p_migr_seq
           AND mfi_process_status = 'OK'
           AND mfi_file_name LIKE '%ACCO%'
      ORDER BY mfi_file_name,mfi_migr_seqno;

   TYPE array_card_data IS TABLE OF VARCHAR2 (100)
      INDEX BY PLS_INTEGER;

   v_array_card_data       array_card_data;

   PROCEDURE lp_migr_rollback_data (
      l_inst_code       IN       NUMBER,
      l_file_name       IN       VARCHAR2,
      l_migr_seqno      IN       NUMBER,
      l_acct_no         IN       VARCHAR2,
      l_acct_type       IN       VARCHAR2,
      l_card_data       IN       array_card_data,
      l_migr_user       IN       NUMBER,
      l_errmsg          OUT      VARCHAR2
   )
   AS
      v_sel_cnt         NUMBER (20)                              := 0;
      v_del_cnt         NUMBER (20)                              := 0;
      v_acct_id         cms_acct_mast.cam_acct_id%TYPE;
      v_merinv_ordr     cms_merinv_merpan.cmm_ordr_refrno%TYPE;
      v_cap_appl_code   cms_appl_pan.cap_appl_code%TYPE;
      v_cap_cust_code   cms_appl_pan.cap_cust_code%TYPE;
      v_cap_acct_no     cms_appl_pan.cap_acct_no%TYPE;
      v_cap_prod_code   cms_appl_pan.cap_prod_code%TYPE;
      v_cap_card_type   cms_appl_pan.cap_card_type%TYPE;
      v_cap_cust_catg   cms_appl_pan.cap_cust_catg%TYPE;
      v_cap_acct_id     cms_appl_pan.cap_acct_id%TYPE;
      excp_exit_proc    EXCEPTION;
      v_cust_file       migr_caf_info_entry.mci_file_name%TYPE;
      v_tran_cnt        number(10);
      v_spend_saving_acct varchar2(50);
      v_spending_acct     varchar2(20);
      v_saving_acct       varchar2(20);
      v_chk_accts         number(5);
      v_gethash           CMS_APPL_PAN.CAP_PAN_CODE%TYPE;





   BEGIN
      l_errmsg := 'OK';

      --SN: Rollback Saving Account data in file
      IF l_acct_type = 2 AND l_card_data IS NULL
      THEN
         BEGIN
            SELECT cam_acct_id
              INTO v_acct_id
              FROM cms_acct_mast
             WHERE cam_inst_code = l_inst_code
               AND cam_acct_no = l_acct_no;
               --AND cam_ins_user = l_migr_user;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_errmsg :=
                     'ERROR WHILE SELECTING SAVING ACCOUNT DTLS- '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_exit_proc;
         END;


         BEGIN
            v_sel_cnt := 0;
            v_del_cnt := 0;

            SELECT 1
              INTO v_sel_cnt
              FROM cms_cust_acct
             WHERE cca_inst_code = l_inst_code
               AND cca_acct_id = v_acct_id
               and rownum = 1;

            IF v_sel_cnt > 0
            THEN
               DELETE FROM cms_cust_acct
                     WHERE cca_inst_code = l_inst_code
                       AND cca_acct_id = v_acct_id;
                       --AND cca_ins_user = l_migr_user;

               v_del_cnt := SQL%ROWCOUNT;
               v_sel_cnt := SQL%ROWCOUNT;

               migr_file_roll_info (l_migr_seqno,
                                    'CMS_CUST_ACCT',
                                    v_sel_cnt,
                                    v_del_cnt
                                   );
            END IF;
         EXCEPTION when no_data_found
         then
           null;
            WHEN OTHERS
            THEN
               l_errmsg :=
                     'ERROR WHILE CMS_CUST_ACCT DATA ROLLBACK- '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_exit_proc;
         END;

         BEGIN
            v_sel_cnt := 0;
            v_del_cnt := 0;

            SELECT 1
              INTO v_sel_cnt
              FROM cms_acct_mast
             WHERE cam_inst_code = l_inst_code
               AND cam_acct_no = l_acct_no
               and rownum = 1;

            IF v_sel_cnt > 0
            THEN
               DELETE FROM cms_acct_mast
                     WHERE cam_inst_code = l_inst_code
                       AND cam_acct_no = l_acct_no;
                       --AND cam_ins_user = l_migr_user;

               v_del_cnt := SQL%ROWCOUNT;
               v_sel_cnt := v_del_cnt;

               migr_file_roll_info (l_migr_seqno,
                                    'CMS_ACCT_MAST',
                                    v_sel_cnt,
                                    v_del_cnt
                                   );
            END IF;
         EXCEPTION  when no_data_found
         then
           null;

            WHEN OTHERS
            THEN
               l_errmsg :=
                     'ERROR WHILE CMS_ACCT_MAST DATA ROLLBACK- '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_exit_proc;
         END;

         BEGIN
            UPDATE migr_acct_data_temp
               SET mad_roll_flag = 'Y'
             WHERE mad_migr_seqno = p_migr_seq
               AND mad_roll_flag = 'N'
               AND mad_acct_numb = l_acct_no;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_errmsg :=
                     'Error while updationg rollback flag for saving acct- '
                  || SUBSTR (SQLERRM, 1, 100);
               RAISE excp_exit_proc;
         END;
      --EN: Rollback Saving Account data in file
      ELSE
         FOR t IN 1 .. l_card_data.COUNT ()
         LOOP

              BEGIN

                v_gethash := gethash(l_card_data (t));

              EXCEPTION WHEN OTHERS
              THEN
                  l_errmsg :=
                     'Error while converting into hash value for PAN '||l_card_data (t) ||'-'  --Error message modified by Pankaj S. on 25-Sep-2013
                  || SUBSTR (SQLERRM, 1, 100);
               RAISE excp_exit_proc;

              END;


               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_statements_log
                   WHERE csl_inst_code = l_inst_code
                     AND csl_pan_no = v_gethash
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_statements_log
                           WHERE csl_inst_code = l_inst_code
                           AND csl_pan_no = v_gethash;


                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_STATEMENTS_LOG',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION  when no_data_found
               then
                   null;

                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_STATEMENTS_LOG DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_transaction_log_dtl
                   WHERE ctd_inst_code = l_inst_code
                     AND ctd_customer_card_no = v_gethash
                     AND ROWNUM = 1;


                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_transaction_log_dtl
                           WHERE ctd_inst_code = l_inst_code
                             AND ctd_customer_card_no = v_gethash;


                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;
                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_TRANSACTION_LOG_DTL',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION  when no_data_found
               then
                   null;

                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_TRANSACTION_LOG_DTL DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM transactionlog
                   WHERE instcode = l_inst_code
                     AND customer_card_no = v_gethash
                     AND ROWNUM = 1;


                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM transactionlog
                           WHERE instcode = l_inst_code
                             AND customer_card_no = v_gethash;


                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'TRANSACTIONLOG',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION  when no_data_found
               then
                   null;

                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE TRANSACTIONLOG DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_manual_adjustment
                   WHERE cma_inst_code = l_inst_code
                     AND cma_pan_code = v_gethash
                     AND ROWNUM = 1;


                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_manual_adjustment
                           WHERE cma_inst_code = l_inst_code
                             AND cma_pan_code = v_gethash;


                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_MANUAL_ADJUSTMENT',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION  when no_data_found
               then
                   null;

                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_MANUAL_ADJUSTMENT DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_dispute_txns
                   WHERE cdt_inst_code = l_inst_code
                     AND cdt_pan_code = v_gethash
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_dispute_txns
                           WHERE cdt_inst_code = l_inst_code
                             AND cdt_pan_code = v_gethash;


                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_DISPUTE_TXNS',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION  when no_data_found
               then
                   null;

                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_DISPUTE_TXNS DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_htlst_reisu
                   WHERE chr_inst_code = l_inst_code
                     AND chr_pan_code = v_gethash
                     AND ROWNUM = 1;


                  IF v_sel_cnt > 0
                  THEN

                     DELETE FROM cms_htlst_reisu
                           WHERE chr_inst_code = l_inst_code
                             AND chr_pan_code = v_gethash;


                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_HTLST_REISU',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION  when no_data_found
               then
                   null;

                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_HTLST_REISU DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_pan_spprt
                   WHERE cps_inst_code = l_inst_code
                     AND cps_pan_code = v_gethash
                     AND ROWNUM = 1;


                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_pan_spprt
                           WHERE cps_inst_code = l_inst_code
                             AND cps_pan_code = v_gethash;


                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_PAN_SPPRT',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION  when no_data_found
               then
                   null;

                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_PAN_SPPRT DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_preauth_transaction
                   WHERE cpt_inst_code = l_inst_code
                     AND cpt_card_no = v_gethash
                      AND ROWNUM = 1;


                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_preauth_transaction
                           WHERE cpt_inst_code = l_inst_code
                             AND cpt_card_no = v_gethash;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_PREAUTH_TRANSACTION',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION  when no_data_found
               then
                   null;

                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_PREAUTH_TRANSACTION DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_preauth_trans_hist
                   WHERE cph_inst_code = l_inst_code
                     AND cph_card_no = v_gethash
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_preauth_trans_hist
                           WHERE cph_inst_code = l_inst_code
                             AND cph_card_no = v_gethash;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_PREAUTH_TRANS_HIST',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;

               EXCEPTION  when no_data_found
               then
                   null;

                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_PREAUTH_TRANS_HIST DATA ROLLBACK- ' --Error message modified by Pankaj S. on 25-Sep-2013
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_c2ctxfr_transaction
                   WHERE cct_inst_code = l_inst_code
                     AND cct_from_card = v_gethash
                     AND ROWNUM = 1;


                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_c2ctxfr_transaction
                           WHERE cct_inst_code = l_inst_code
                             AND cct_from_card = v_gethash;


                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_C2CTXFR_TRANSACTION',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION when no_data_found
               then
                   null;

               WHEN OTHERS
               THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_C2CTXFR_TRANSACTION DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN

                   select 1
                   into   v_tran_cnt
                   from migr_transactionlog_temp
                   where mtt_card_no = l_card_data (t)
                   AND MTT_FLAG ='S'
                   AND  ROWNUM = 1;

                   if v_tran_cnt > 0
                   then

                       BEGIN
                          UPDATE migr_transactionlog_temp
                             SET mtt_roll_flag = 'Y'
                           WHERE mtt_migr_seqno = p_migr_seq
                             AND mtt_roll_flag = 'N'
                             AND MTT_FLAG ='S'
                             AND mtt_card_no = l_card_data (t);
                       EXCEPTION
                          WHEN OTHERS
                          THEN
                             l_errmsg :=
                                   'Error while updationg rollback flag for transaction- '
                                || SUBSTR (SQLERRM, 1, 100);
                            RAISE excp_exit_proc;
                       END;

                   end if;

               EXCEPTION when no_data_found
               then
                   null;

               WHEN excp_exit_proc
               THEN RAISE;

               WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE FETCHING COUNT FOR PAN '||l_card_data (t) ||'-' --Error message modified by Pankaj S. on 25-Sep-2013
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

         END LOOP;

         FOR t IN 1 .. l_card_data.COUNT ()
         LOOP
         
              BEGIN

                    v_gethash := gethash(l_card_data (t));

              EXCEPTION WHEN OTHERS
              THEN
                  l_errmsg :=
                     'Error while converying into hash value for PAN '||l_card_data (t) ||'-' --Error message modified by Pankaj S. on 25-Sep-2013
                  || SUBSTR (SQLERRM, 1, 100);
               RAISE excp_exit_proc;

              END;

            BEGIN
               SELECT cap_appl_code, cap_cust_code, cap_acct_no,
                      cap_prod_code, cap_card_type, cap_cust_catg,
                      cap_acct_id
                 INTO v_cap_appl_code, v_cap_cust_code, v_cap_acct_no,
                      v_cap_prod_code, v_cap_card_type, v_cap_cust_catg,
                      v_cap_acct_id
                 FROM cms_appl_pan
                WHERE cap_inst_code = l_inst_code
                  AND cap_pan_code = v_gethash;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
               WHEN OTHERS
               THEN
                  l_errmsg :=
                        'ERROR WHILE SELECTING PAN DETAILS- '
                     || SUBSTR (SQLERRM, 1, 200);
                  RAISE excp_exit_proc;
            END;


               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_smsandemail_alert
                   WHERE csa_inst_code = l_inst_code
                     AND csa_pan_code =  v_gethash
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_smsandemail_alert
                           WHERE csa_inst_code = l_inst_code
                             AND csa_pan_code =  v_gethash;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (
                                          l_migr_seqno,
                                          'CMS_SMSANDEMAIL_ALERT',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION when no_data_found
               then
                   null;
               
                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_SMSANDEMAIL_ALERT DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_cardissuance_status
                   WHERE ccs_inst_code = l_inst_code
                     AND ccs_pan_code =  v_gethash
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN

                     DELETE FROM cms_cardissuance_status
                           WHERE ccs_inst_code = l_inst_code
                             AND ccs_pan_code =  v_gethash;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (
                                          l_migr_seqno,
                                          'CMS_CARDISSUANCE_STATUS',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION when no_data_found
               then
                   null;
                  
                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_CARDISSUANCE_STATUS DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_translimit_check
                   WHERE ctc_inst_code = l_inst_code
                     AND ctc_pan_code =  v_gethash
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_translimit_check
                           WHERE ctc_inst_code = l_inst_code
                             AND ctc_pan_code =  v_gethash;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (
                                          l_migr_seqno,
                                          'CMS_TRANSLIMIT_CHECK',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION when no_data_found
               then
                   null;
               
                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_TRANSLIMIT_CHECK DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT cmm_ordr_refrno
                    INTO v_merinv_ordr
                    FROM cms_merinv_merpan
                   WHERE cmm_inst_code = l_inst_code
                     AND cmm_pan_code =  v_gethash;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_merinv_merpan
                   WHERE cmm_inst_code = l_inst_code
                     AND cmm_pan_code =  v_gethash
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_merinv_merpan
                           WHERE cmm_inst_code = l_inst_code
                             AND cmm_pan_code =  v_gethash;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (
                                          l_migr_seqno,
                                          'CMS_MERINV_MERPAN',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_MERINV_MERPAN DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_pan_acct
                   WHERE cpa_inst_code = l_inst_code
                     ---AND cpa_pan_code =  v_gethash
                    and cpa_cust_code      = v_cap_cust_code
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_pan_acct
                           WHERE cpa_inst_code = l_inst_code
                             --AND cpa_pan_code =  v_gethash;
                             and cpa_cust_code      = v_cap_cust_code;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (
                                          l_migr_seqno,
                                          'CMS_PAN_ACCT',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
                  
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
               
                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_PAN_ACCT DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_appl_pan
                   WHERE cap_inst_code = l_inst_code
                     --AND cap_pan_code =  v_gethash
                     and cap_cust_code = v_cap_cust_code
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_appl_pan
                           WHERE cap_inst_code = l_inst_code
                             --AND cap_pan_code =  v_gethash;
                             and cap_cust_code = v_cap_cust_code;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (
                                          l_migr_seqno,
                                          'CMS_APPL_PAN',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;                  
                     
               WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_APPL_PAN DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_appl_det
                   WHERE cad_inst_code = l_inst_code
                     AND cad_appl_code in(select cam_appl_code from cms_appl_mast where cam_cust_code=v_cap_cust_code)
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_appl_det
                           WHERE cad_inst_code = l_inst_code
                             AND cad_appl_code in(select cam_appl_code from cms_appl_mast where cam_cust_code=v_cap_cust_code);

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (
                                          l_migr_seqno,
                                          'CMS_APPL_DET',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
               
                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_APPL_DET DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_appl_mast
                   WHERE cam_inst_code = l_inst_code
                     --AND cam_appl_code = v_cap_appl_code
                     and  cam_cust_code = v_cap_cust_code
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_appl_mast
                           WHERE cam_inst_code = l_inst_code
                             --AND cam_appl_code = v_cap_appl_code;
                             and  cam_cust_code = v_cap_cust_code;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (
                                          l_migr_seqno,
                                          'CMS_APPL_MAST',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
                  
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
                     
               WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_APPL_MAST DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_caf_info_entry
                   WHERE cci_inst_code = l_inst_code
                     AND cci_appl_code = v_cap_appl_code
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_caf_info_entry
                           WHERE cci_inst_code = l_inst_code
                             AND cci_appl_code = v_cap_appl_code;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (
                                          l_migr_seqno,
                                          'CMS_CAF_INFO_ENTRY',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
                  
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_CAF_INFO_ENTRY DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               IF v_merinv_ordr IS NOT NULL
               THEN
                  BEGIN
                     v_sel_cnt := 0;
                     v_del_cnt := 0;

                     SELECT 1
                       INTO v_sel_cnt
                       FROM cms_merinv_ordr
                      WHERE cmo_inst_code = l_inst_code
                        AND cmo_ordr_refrno = v_merinv_ordr
                        AND ROWNUM = 1;

                     IF v_sel_cnt > 0
                     THEN
                        DELETE FROM cms_merinv_ordr
                              WHERE cmo_inst_code = l_inst_code
                                AND cmo_ordr_refrno = v_merinv_ordr;

                        v_del_cnt := SQL%ROWCOUNT;
                        v_sel_cnt := v_del_cnt;

                        migr_file_roll_info (
                                             l_migr_seqno,
                                             'CMS_MERINV_ORDR',
                                             v_sel_cnt,
                                             v_del_cnt
                                            );
                     END IF;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        l_errmsg :=
                              'ERROR WHILE CMS_MERINV_ORDR DATA ROLLBACK- '
                           || SUBSTR (SQLERRM, 1, 200);
                        RAISE excp_exit_proc;
                  END;
               END IF;

                BEGIN
                   SELECT mci_file_name
                     INTO v_cust_file
                     FROM migr_caf_info_entry
                    WHERE mci_pan_code =  l_card_data (t)
                      AND mci_inst_code = l_inst_code
                      AND ROWNUM = 1;
                      --AND mci_migr_seqno = l_migr_seqno;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      NULL;
                      v_cust_file := NULL;
                   WHEN OTHERS
                   THEN
                      l_errmsg :=
                            'ERROR WHILE SELECTING CUST FILE NAME- '
                         || SUBSTR (SQLERRM, 1, 200);
                      RAISE excp_exit_proc;
                END;

                IF v_cust_file IS NOT NULL
                THEN

                   BEGIN
                      UPDATE migr_caf_info_entry
                         SET mci_roll_flag = 'Y'
                       WHERE mci_migr_seqno = p_migr_seq
                         AND mci_roll_flag = 'N'
                         AND mci_pan_code =  l_card_data (t);
                   EXCEPTION
                      WHEN OTHERS
                      THEN
                          l_errmsg :=
                               'Error while updating rollback flag for cust- '
                            || SUBSTR (SQLERRM, 1, 100);
                            RAISE excp_exit_proc;
                   END;

                END IF;



               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  Begin

                    SELECT COUNT(1)
                    INTO v_chk_accts
                    FROM cms_cust_acct
                    WHERE cca_inst_code = l_inst_code
                    AND cca_cust_code = v_cap_cust_code;

                     if v_chk_accts > 1
                     then

                        SELECT wm_concat(cca_acct_id)    --getting both spending and saving accounts ,
                        INTO v_spend_saving_acct         --if customer migrated with only spending account and saving acct created online after migration then
                        FROM cms_cust_acct               -- to  delete both accounts this logic added
                        WHERE cca_inst_code = l_inst_code
                        AND cca_cust_code = v_cap_cust_code;

                        V_SPENDING_ACCT :=  SUBSTR(v_spend_saving_acct,1,INSTR(v_spend_saving_acct,',')-1);
                        V_SAVING_ACCT   :=  SUBSTR(v_spend_saving_acct,INSTR(v_spend_saving_acct,',')+1,100);

                     else

                        V_SPENDING_ACCT := v_cap_acct_id;

                     end if;

                  exception when no_data_found
                  then
                      null;
                  when others
                  then

                    l_errmsg :=
                           'ERROR WHILE FETCHING SAVING AND SPENDING ACCT FOR CUST CODE '
                        || v_cap_cust_code ||'-'  --Error message modified by Pankaj S. on 25-Sep-2013
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;

                  end;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_cust_acct
                   WHERE cca_inst_code = l_inst_code
                     AND cca_cust_code = v_cap_cust_code
                     --AND cca_acct_id = v_cap_acct_id    deleting based on cust code because after migration if any saving account is created then that will also get delete
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_cust_acct
                           WHERE cca_inst_code = l_inst_code
                             AND cca_cust_code = v_cap_cust_code;
                             --AND cca_acct_id = v_cap_acct_id;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;
                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_CUST_ACCT',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               exception when no_data_found
                  then
                      null;                  
               WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_CUST_ACCT DATA ROLLBACK- '
                        || v_cap_acct_id
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_acct_mast
                   WHERE cam_inst_code = l_inst_code
                     AND ( cam_acct_id = V_SPENDING_ACCT OR cam_acct_id = nvl(V_SAVING_ACCT,0))
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_acct_mast
                           WHERE cam_inst_code = l_inst_code
                             AND ( cam_acct_id = V_SPENDING_ACCT OR cam_acct_id = nvl(V_SAVING_ACCT,0));

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_ACCT_MAST',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;

               EXCEPTION when no_data_found
               then
                     null;   
                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_ACCT_MAST DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_addr_mast
                   WHERE cam_inst_code = l_inst_code
                     AND cam_cust_code = v_cap_cust_code
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_addr_mast
                           WHERE cam_inst_code = l_inst_code
                             AND cam_cust_code = v_cap_cust_code;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_ADDR_MAST',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION when no_data_found
               then
                     null;                     
               WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_ADDR_MAST DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_security_questions
                   WHERE csq_cust_id IN (
                            SELECT ccm_cust_id
                              FROM cms_cust_mast
                             WHERE ccm_inst_code = l_inst_code
                               AND ccm_cust_code = v_cap_cust_code
                               )
                   AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_security_questions
                           WHERE csq_cust_id IN (
                                    SELECT ccm_cust_id
                                      FROM cms_cust_mast
                                     WHERE ccm_inst_code = l_inst_code
                                       AND ccm_cust_code = v_cap_cust_code
                                       );

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_SECURITY_QUESTIONS',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;

               EXCEPTION when no_data_found
               then
                     null; 
               WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_SECURITY_QUESTIONS DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN
                  v_sel_cnt := 0;
                  v_del_cnt := 0;

                  SELECT 1
                    INTO v_sel_cnt
                    FROM cms_cust_mast
                   WHERE ccm_inst_code = l_inst_code
                     AND ccm_cust_code = v_cap_cust_code
                     AND ROWNUM = 1;

                  IF v_sel_cnt > 0
                  THEN
                     DELETE FROM cms_cust_mast
                           WHERE ccm_inst_code = l_inst_code
                             AND ccm_cust_code = v_cap_cust_code;

                     v_del_cnt := SQL%ROWCOUNT;
                     v_sel_cnt := v_del_cnt;

                     migr_file_roll_info (l_migr_seqno,
                                          'CMS_CUST_MAST',
                                          v_sel_cnt,
                                          v_del_cnt
                                         );
                  END IF;
               EXCEPTION when no_data_found
               then
                     null;                     
                     
               WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'ERROR WHILE CMS_CUST_MAST DATA ROLLBACK- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_exit_proc;
               END;

               BEGIN

                  UPDATE migr_acct_data_temp
                     SET mad_roll_flag = 'Y'
                   WHERE mad_migr_seqno = p_migr_seq
                     AND mad_roll_flag = 'N'
                     AND mad_acct_numb = v_cap_acct_no;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     l_errmsg :=
                           'Error while updating rollback flag for acct '||v_cap_acct_no||'-' 
                        || SUBSTR (SQLERRM, 1, 100);
               END;
         END LOOP;
      END IF;
   EXCEPTION
      WHEN excp_exit_proc
      THEN
         ROLLBACK;
      WHEN OTHERS
      THEN
         ROLLBACK;
         l_errmsg := 'Main excp-' || SUBSTR (SQLERRM, 1, 100);
   END;
BEGIN
   p_errmsg := 'OK';


   BEGIN

      SELECT 1
        INTO v_chk_invalid_seqno
        FROM migr_file_load_info
       WHERE mfi_migr_seqno = p_migr_seq AND ROWNUM < 2;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         p_errmsg := 'Invalid sequence number for rollback';
         RETURN;
   END;



   FOR i IN cur_file
   LOOP

     FOR j IN (SELECT mad_acct_numb, mad_acct_type, mad_record_numb
                 FROM migr_acct_data_temp
                WHERE mad_file_name = i.mfi_file_name
                  AND mad_roll_flag = 'N')
     LOOP
        v_indx := 1;

        FOR k IN (SELECT FN_DMAPS_MAIN(cap_pan_code_encr) cap_pan_code
                    FROM cms_appl_pan
                   WHERE cap_inst_code = v_instcode
                   and   cap_acct_no = j.mad_acct_numb
                 )
        LOOP
              v_array_card_data (v_indx) := k.cap_pan_code;
             v_indx := v_indx + 1;
        END LOOP;

       lp_migr_rollback_data (v_instcode,
                              i.mfi_file_name,
                              p_migr_seq,
                              j.mad_acct_numb,
                              j.mad_acct_type,
                              v_array_card_data,
                              p_migruser,
                              v_errmsg
                             );

       IF v_errmsg <> 'OK'
       THEN
          ROLLBACK;
          p_errmsg := 'Error while deleting data: ' || v_errmsg;

           INSERT INTO migr_det_roll_excp
                       (mdr_file_name, mdr_migr_seqno, mdr_acct_no,
                        mdr_reason
                       )
                VALUES (i.mfi_file_name, p_migr_seq, j.mad_acct_numb,
                        p_errmsg
                       );


              RETURN;
       END IF;

        FOR t IN 1 .. v_array_card_data.COUNT ()
        LOOP
           v_array_card_data.DELETE;
        END LOOP;

     END LOOP;

   END LOOP;


EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;
      p_errmsg := 'Main Excp-' || SQLERRM;
END;
/
show error;