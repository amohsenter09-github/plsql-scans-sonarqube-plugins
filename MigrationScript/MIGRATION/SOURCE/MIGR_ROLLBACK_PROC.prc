CREATE OR REPLACE PROCEDURE VMSCMS.migr_rollback_proc (
   p_inst_code         NUMBER,
   p_migruser          NUMBER,
   p_errmsg      OUT   VARCHAR2
)
IS
   v_sel_cnt        NUMBER (20) := 0;
   v_del_cnt        NUMBER (20) := 0;
   excp_exit_proc   EXCEPTION;
BEGIN
   p_errmsg := 'OK';

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_statements_log
       WHERE csl_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_statements_log
               WHERE csl_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_STATEMENTS_LOG', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_STATEMENTS_LOG DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_transaction_log_dtl
       WHERE ctd_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_transaction_log_dtl
               WHERE ctd_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_TRANSACTION_LOG_DTL', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_TRANSACTION_LOG_DTL DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM transactionlog
       WHERE add_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM transactionlog
               WHERE add_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('TRANSACTIONLOG', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE TRANSACTIONLOG DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_manual_adjustment
       WHERE cma_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_manual_adjustment
               WHERE cma_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_MANUAL_ADJUSTMENT', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_MANUAL_ADJUSTMENT DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_dispute_txns
       WHERE cdt_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_dispute_txns
               WHERE cdt_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_DISPUTE_TXNS', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_DISPUTE_TXNS DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_htlst_reisu
       WHERE chr_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_htlst_reisu
               WHERE chr_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_HTLST_REISU', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_HTLST_REISU DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_pan_spprt
       WHERE cps_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_pan_spprt
               WHERE cps_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_PAN_SPPRT', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_PAN_SPPRT DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_smsandemail_alert
       WHERE csa_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_smsandemail_alert
               WHERE csa_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_SMSANDEMAIL_ALERT', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_SMSANDEMAIL_ALERT DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_cardissuance_status
       WHERE ccs_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_cardissuance_status
               WHERE ccs_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_CARDISSUANCE_STATUS', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_CARDISSUANCE_STATUS DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_pan_acct
       WHERE cpa_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_pan_acct
               WHERE cpa_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_PAN_ACCT', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_PAN_ACCT DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_translimit_check
       WHERE ctc_pan_code IN (SELECT cap_pan_code
                                FROM cms_appl_pan
                               WHERE cap_ins_user = p_migruser);

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_translimit_check
               WHERE ctc_pan_code IN (SELECT cap_pan_code
                                        FROM cms_appl_pan
                                       WHERE cap_ins_user = p_migruser);

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_TRANSLIMIT_CHECK', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_TRANSLIMIT_CHECK DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_merinv_merpan
       WHERE cmm_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_merinv_merpan
               WHERE cmm_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_MERINV_MERPAN', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_MERINV_MERPAN DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_preauth_transaction
       WHERE cpt_card_no IN (SELECT cap_pan_code
                               FROM cms_appl_pan
                              WHERE cap_ins_user = p_migruser);

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_preauth_transaction
               WHERE cpt_card_no IN (SELECT cap_pan_code
                                       FROM cms_appl_pan
                                      WHERE cap_ins_user = p_migruser);

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_PREAUTH_TRANSACTION', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_PREAUTH_TRANSACTION DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_preauth_trans_hist
       WHERE cph_card_no IN (SELECT cap_pan_code
                               FROM cms_appl_pan
                              WHERE cap_ins_user = p_migruser);

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_preauth_trans_hist
               WHERE cph_card_no IN (SELECT cap_pan_code
                                       FROM cms_appl_pan
                                      WHERE cap_ins_user = p_migruser);

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_PREAUTH_TRANS_HIST', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_PREAUTH_TRANSACTION DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_c2ctxfr_transaction
       WHERE cct_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_c2ctxfr_transaction
               WHERE cct_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_C2CTXFR_TRANSACTION', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_C2CTXFR_TRANSACTION DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_appl_pan
       WHERE cap_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_appl_pan
               WHERE cap_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_APPL_PAN', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_APPL_PAN DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_appl_det
       WHERE cad_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_appl_det
               WHERE cad_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_APPL_DET', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_APPL_DET DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_appl_mast
       WHERE cam_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_appl_mast
               WHERE cam_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_APPL_MAST', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_APPL_MAST DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_cust_acct
       WHERE cca_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_cust_acct
               WHERE cca_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_CUST_ACCT', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_CUST_ACCT DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_acct_mast
       WHERE cam_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_acct_mast
               WHERE cam_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_ACCT_MAST', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_ACCT_MAST DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_addr_mast
       WHERE cam_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_addr_mast
               WHERE cam_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_ADDR_MAST', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_ADDR_MAST DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_security_questions
       WHERE csq_cust_id IN (SELECT ccm_cust_id
                               FROM cms_cust_mast
                              WHERE ccm_ins_user = p_migruser);

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_security_questions
               WHERE csq_cust_id IN (SELECT ccm_cust_id
                                       FROM cms_cust_mast
                                      WHERE ccm_ins_user = p_migruser);

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_SECURITY_QUESTIONS', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_SECURITY_QUESTIONS DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_cust_mast
       WHERE ccm_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_cust_mast
               WHERE ccm_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_CUST_MAST', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_CUST_MAST DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_prod_ccc
       WHERE cpc_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_prod_ccc
               WHERE cpc_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_PROD_CCC', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_PROD_CCC DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_caf_info_entry
       WHERE cci_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_caf_info_entry
               WHERE cci_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_CAF_INFO_ENTRY', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_CAF_INFO_ENTRY DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_cust_group
       WHERE ccg_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_cust_group
               WHERE ccg_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_CUST_GROUP', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_CUST_GROUP DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM cms_merinv_ordr
       WHERE cmo_ins_user = p_migruser;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM cms_merinv_ordr
               WHERE cmo_ins_user = p_migruser;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('CMS_MERINV_ORDR', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE CMS_MERINV_ORDR DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM migr_error_log;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM migr_error_log;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('MIGR_ERROR_LOG', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE MIGR_ERROR_LOG DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;

   BEGIN
      v_sel_cnt := 0;
      v_del_cnt := 0;

      SELECT COUNT (*)
        INTO v_sel_cnt
        FROM migr_succ_log;

      IF v_sel_cnt > 0
      THEN
         DELETE FROM migr_succ_log;

         v_del_cnt := SQL%ROWCOUNT;
      END IF;

      INSERT INTO migr_roll_count
                  (mrc_table_name, mrc_sel_cnt, mrc_del_cnt, mrc_ins_user
                  )
           VALUES ('MIGR_SUCC_LOG', v_sel_cnt, v_del_cnt, p_migruser
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         p_errmsg :=
               'ERROR WHILE MIGR_SUCC_LOG DATA ROLLBACK '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE excp_exit_proc;
   END;

   IF p_errmsg = 'OK'
   THEN
      COMMIT;
   END IF;
EXCEPTION
   WHEN excp_exit_proc
   THEN
      ROLLBACK;
      p_errmsg := p_errmsg;
   WHEN OTHERS
   THEN
      ROLLBACK;
      p_errmsg :=
         'ERROR WHILE MIGRATION ROLLBACK PROCESS '
         || SUBSTR (SQLERRM, 1, 200);
END;
/

SHOW ERRORS;