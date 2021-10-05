DECLARE
   v_num             NUMBER (10);
   v_inst_code       NUMBER (5)                            := 1;
   v_lupd_user       NUMBER (5);
   v_tmp_pan         VARCHAR2 (20);
   v_errmsg          VARCHAR2 (500);
   v_tmp_acct        VARCHAR2 (16);
   v_cac_length      NUMBER;
   v_ctrlnumb        NUMBER (30);
   v_ctrl_numb       NUMBER (30);
   v_total           NUMBER (30)                           := 0;
   v_total1          NUMBER (30)                           := 0;
   v_max_serl        VMSCMS.cms_pan_ctrl.cpc_max_serial_no%TYPE;
   excp_reject_rec   EXCEPTION;
   v_savepnt         NUMBER (10)                           := 0;
BEGIN
   v_errmsg := 'OK';

   BEGIN
      SELECT cum_user_pin
        INTO v_lupd_user
        FROM VMSCMS.cms_user_mast
       WHERE cum_user_code = 'MIGR_USER' AND cum_inst_code = v_inst_code;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_lupd_user := 1;
   END;

   FOR i IN (SELECT   mci_prod_code, mci_card_type, mci_fiid, COUNT (*) cnt
                 FROM VMSCMS.migr_caf_info_entry
                WHERE mci_proc_flag = 'S'
             GROUP BY mci_prod_code, mci_card_type, mci_fiid)
   LOOP
      BEGIN
         v_errmsg := 'OK';
         v_savepnt := v_savepnt + 1;
         SAVEPOINT v_savepnt;
         VMSCMS.sp_acct_tmpno (v_inst_code,
                        i.mci_fiid,
                        i.mci_prod_code,
                        i.mci_card_type,
                        v_tmp_acct,
                        v_cac_length,
                        v_errmsg
                       );

         IF v_errmsg <> 'OK'
         THEN
            v_errmsg := 'Error while selecting temp acctno(prefix)-' || v_errmsg;  --Error message modified by Pankaj S. on 25-Sep-2013
            RAISE excp_reject_rec;
         END IF;

         BEGIN
            SELECT     NVL (cac_ctrl_numb, 1)
                  INTO v_ctrlnumb
                  FROM VMSCMS.cms_acct_ctrl
                 WHERE cac_bran_code = v_tmp_acct
                   AND cac_inst_code = v_inst_code
            FOR UPDATE WAIT 1;

            DBMS_OUTPUT.put_line (   'Account Control Number -- '
                                  || ' Old  Control Number For Product '
                                  || i.mci_prod_code
                                  || '  And Product Catagoty Is '
                                  || i.mci_card_type
                                  || ' --'
                                  || v_ctrlnumb
                                 );

            IF v_ctrlnumb + i.cnt < LPAD ('9', v_cac_length, 9)
            THEN
               UPDATE VMSCMS.cms_acct_ctrl
                  SET cac_ctrl_numb = v_ctrlnumb + i.cnt
                WHERE cac_bran_code = v_tmp_acct
                  AND cac_inst_code = v_inst_code;

               IF SQL%ROWCOUNT = 0
               THEN
                  v_errmsg := 'Serial no is not updated for temp acct '||v_tmp_acct;   --Error message modified by Pankaj S. on 25-Sep-2013
                  RAISE excp_reject_rec;
               END IF;
            ELSE
               v_errmsg := 'Maximum serial number reached';
               RAISE excp_reject_rec;
            END IF;

            v_total := v_ctrlnumb + i.cnt;
         --COMMIT;
         EXCEPTION
            WHEN excp_reject_rec
            THEN
               RAISE;
            WHEN NO_DATA_FOUND
            THEN
               v_ctrlnumb := i.cnt + 1;

               BEGIN
                  INSERT INTO VMSCMS.cms_acct_ctrl
                              (cac_inst_code, cac_bran_code, cac_ctrl_numb,
                               cac_max_serial_no, cac_ins_user
                              )
                       VALUES (v_inst_code, v_tmp_acct, v_ctrlnumb,
                               LPAD ('9', v_cac_length, 9), v_lupd_user
                              );

                  --COMMIT;
                  DBMS_OUTPUT.put_line (   'Account Control Number -- '
                                        || ' Old  Control Number For Product '
                                        || i.mci_prod_code
                                        || '  And Product Catagoty Is '
                                        || i.mci_card_type
                                        || ' --'
                                        || '1'
                                       );
                  v_total := v_ctrlnumb;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_errmsg :=
                           'While Inserting into CMS_ACCT_CTRL  -- '
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_reject_rec;
               END;
            WHEN OTHERS
            THEN
               v_errmsg :=
                     'Error while adujust acct cntrl number- -- '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_reject_rec;
         END;

         DBMS_OUTPUT.put_line ('Number Of Migrated Accounts --' || i.cnt);
         DBMS_OUTPUT.put_line (   'Account Control Number -- '
                               || 'New Control Number For Product '
                               || i.mci_prod_code
                               || '  And Product Catagoty Is '
                               || i.mci_card_type
                               || ' --'
                               || v_total
                              );
         VMSCMS.migr_find_binprefix (v_inst_code,
                              i.mci_prod_code,
                              i.mci_card_type,
                              i.mci_fiid,
                              --    v_lupd_user,
                              v_tmp_pan,
                              v_max_serl,
                              v_errmsg
                             );

         IF v_errmsg <> 'OK'
         THEN
            v_errmsg := 'Error while selecting bin prefix-' || v_errmsg;  --Error message modified by Pankaj S. on 25-Sep-2013
            RAISE excp_reject_rec;
         END IF;

         BEGIN
            SELECT     NVL (cpc_ctrl_numb, 1)
                  INTO v_ctrl_numb
                  FROM VMSCMS.cms_pan_ctrl
                 WHERE cpc_inst_code = v_inst_code
                   AND cpc_pan_prefix = v_tmp_pan
            FOR UPDATE WAIT 1;

            DBMS_OUTPUT.put_line (   'Pan Control Number -- '
                                  || ' Old Control Number For Product '
                                  || i.mci_prod_code
                                  || '  And Product Catagoty Is '
                                  || i.mci_card_type
                                  || ' --'
                                  || v_ctrl_numb
                                 );

            IF v_ctrl_numb + i.cnt < LPAD ('9', v_max_serl, 9)
            THEN
               UPDATE VMSCMS.cms_pan_ctrl
                  SET cpc_ctrl_numb = v_ctrl_numb + i.cnt
                WHERE cpc_inst_code = v_inst_code
                  AND cpc_pan_prefix = v_tmp_pan;

               IF SQL%ROWCOUNT = 0
               THEN
                  v_errmsg :=
                        'Control number not updated for product code '
                     || i.mci_prod_code;
                  RAISE excp_reject_rec;
               END IF;
            ELSE
               v_errmsg :=
                     'MAXIMUM SERIAL NUMBER REACHED for product code '
                  || i.mci_prod_code;
               RAISE excp_reject_rec;
            END IF;

            v_total1 := v_ctrl_numb + i.cnt;
         EXCEPTION
            WHEN excp_reject_rec
            THEN
               RAISE;
            WHEN NO_DATA_FOUND
            THEN
               v_ctrl_numb := i.cnt + 1;

               INSERT INTO VMSCMS.cms_pan_ctrl
                           (cpc_inst_code, cpc_pan_prefix, cpc_ctrl_numb,
                            cpc_max_serial_no, cpc_lupd_date, cpc_ins_user
                           )
                    VALUES (1, v_tmp_pan, v_ctrl_numb,
                            LPAD ('9', v_max_serl, 9), SYSDATE, v_lupd_user
                           );

               DBMS_OUTPUT.put_line (   'Pan Control Number -- '
                                     || ' Old Control Number For Product '
                                     || i.mci_prod_code
                                     || '  And Product Catagoty Is '
                                     || i.mci_card_type
                                     || ' --'
                                     || '1'
                                    );
               v_total1 := v_ctrl_numb;
            WHEN OTHERS
            THEN
               v_errmsg :=
                     'Erorr while updating control number for product code '
                  || i.mci_prod_code
                  || ' as '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_reject_rec;
         END;

         IF v_errmsg = 'OK'
         THEN
            INSERT INTO VMSCMS.migr_updt_ctrl_detl
                        (muc_inst_code, muc_prod_code, muc_card_type,
                         muc_brch_numb, muc_ctrl_numb, muc_ctrl_type,
                         muc_proc_flag, muc_proc_mesg, muc_ins_date,
                         muc_ins_user
                        )
                 VALUES (v_inst_code, i.mci_prod_code, i.mci_card_type,
                         i.mci_fiid, v_ctrl_numb, 'PAN',
                         'S', v_errmsg, SYSDATE,
                         v_lupd_user
                        );
         END IF;

         DBMS_OUTPUT.put_line ('Number Of Migrated Accounts ' || i.cnt);
         DBMS_OUTPUT.put_line (   'PAN Control Number -- '
                               || 'New Control Number For Product '
                               || i.mci_prod_code
                               || '  And Product Catagoty Is '
                               || i.mci_card_type
                               || ' --'
                               || v_total1
                              );
      EXCEPTION
         WHEN excp_reject_rec
         THEN
            ROLLBACK TO v_savepnt;

            INSERT INTO VMSCMS.migr_updt_ctrl_detl
                        (muc_inst_code, muc_prod_code, muc_card_type,
                         muc_brch_numb, muc_ctrl_numb, muc_ctrl_type,
                         muc_proc_flag, muc_proc_mesg, muc_ins_date,
                         muc_ins_user
                        )
                 VALUES (v_inst_code, i.mci_prod_code, i.mci_card_type,
                         i.mci_fiid, v_ctrl_numb, 'PAN',
                         'E', v_errmsg, SYSDATE,
                         v_lupd_user
                        );
         WHEN OTHERS
         THEN
            ROLLBACK TO v_savepnt;
            v_errmsg :=
                  'Erorr while updating control number for product code '
               || i.mci_prod_code
               || ' as '
               || SUBSTR (SQLERRM, 1, 200);

            INSERT INTO VMSCMS.migr_updt_ctrl_detl
                        (muc_inst_code, muc_prod_code, muc_card_type,
                         muc_brch_numb, muc_ctrl_numb, muc_ctrl_type,
                         muc_proc_flag, muc_proc_mesg, muc_ins_date,
                         muc_ins_user
                        )
                 VALUES (v_inst_code, i.mci_prod_code, i.mci_card_type,
                         i.mci_fiid, v_ctrl_numb, 'PAN',
                         'E', v_errmsg, SYSDATE,
                         v_lupd_user
                        );
      END;
   END LOOP;
END;
/
SHOW ERROR ;
