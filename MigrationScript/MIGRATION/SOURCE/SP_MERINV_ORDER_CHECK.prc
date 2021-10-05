CREATE OR REPLACE PROCEDURE VMSCMS.sp_merinv_order_check (
   p_instcode   IN       NUMBER,
   p_lupduser   IN       NUMBER,
   p_errmsg     OUT      VARCHAR2
)
IS
   v_merprodcat_id     cms_merinv_prodcat.cmp_merprodcat_id%TYPE;
   v_ordr_refrno       cms_merinv_ordr.cmo_ordr_refrno%TYPE;
   v_errmsg            VARCHAR2 (400);
   excp_merinv_raise   EXCEPTION;
BEGIN
   v_errmsg := 'OK';
   p_errmsg := 'OK';

   FOR i IN (SELECT   mci_prod_code, mci_card_type, mci_merc_id,
                      mci_store_id, COUNT (*) no_cards_order
                 FROM migr_caf_info_entry
                WHERE mci_proc_flag = 'N' AND mci_inv_flag = 'Y'
             GROUP BY mci_prod_code, mci_card_type, mci_merc_id,
                      mci_store_id)
   LOOP
      BEGIN
         v_errmsg := 'OK';
         p_errmsg := 'OK';

         BEGIN
            SELECT cmp_merprodcat_id
              INTO v_merprodcat_id
              FROM cms_merinv_prodcat
             WHERE cmp_inst_code = p_instcode
               AND cmp_mer_id = i.mci_merc_id
               AND cmp_prod_code = i.mci_prod_code
               AND cmp_prod_cattype = i.mci_card_type;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               v_errmsg :=
                  'Merchant prod catg not found for mer id ' || i.mci_merc_id;
               RAISE excp_merinv_raise;
            WHEN OTHERS
            THEN
               v_errmsg :=
                     'Error while getting merchant prodcatg as '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_merinv_raise;
         END;

         BEGIN
            SELECT 'M' || seq_merinv_ordr_refrno.NEXTVAL
              INTO v_ordr_refrno
              FROM DUAL;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_errmsg :=
                     'Error while getting order reference no value as '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_merinv_raise;
         END;

         BEGIN
            INSERT INTO cms_merinv_ordr_temp
                        (cmo_inst_code, cmo_merprodcat_id, cmo_location_id,
                         cmo_nocards_ordr, cmo_authorize_flag,
                         cmo_authorize_date, cmo_authorize_user,
                         cmo_process_flag, cmo_reject_reason,
                         cmo_process_date, cmo_process_user, cmo_lupd_date,
                         cmo_lupd_user, cmo_ins_date, cmo_ins_user,
                         cmo_ordr_refrno, cmo_success_records,
                         cmo_error_records, cmo_raise_flag
                        )
                 VALUES (p_instcode, v_merprodcat_id, i.mci_store_id,
                         i.no_cards_order, 'A',
                         SYSDATE, p_lupduser,
                         'Y', NULL,
                         SYSDATE, p_lupduser, SYSDATE,
                         p_lupduser, SYSDATE, p_lupduser,
                         v_ordr_refrno, 0,
                         0, 'M'
                        );

            INSERT INTO cms_merinv_ordr
                        (cmo_inst_code, cmo_merprodcat_id, cmo_location_id,
                         cmo_nocards_ordr, cmo_authorize_flag,
                         cmo_authorize_date, cmo_authorize_user,
                         cmo_process_flag, cmo_reject_reason,
                         cmo_process_date, cmo_process_user, cmo_lupd_date,
                         cmo_lupd_user, cmo_ins_date, cmo_ins_user,
                         cmo_ordr_refrno, cmo_success_records,
                         cmo_error_records, cmo_raise_flag
                        )
                 VALUES (p_instcode, v_merprodcat_id, i.mci_store_id,
                         i.no_cards_order, 'A',
                         SYSDATE, p_lupduser,
                         'Y', NULL,
                         SYSDATE, p_lupduser, SYSDATE,
                         p_lupduser, SYSDATE, p_lupduser,
                         v_ordr_refrno, 0,
                         0, 'M'
                        );
         EXCEPTION
            WHEN OTHERS
            THEN
               v_errmsg :=
                     'Error while inserting record in merinv order for mer id '
                  || i.mci_merc_id
                  || ' as '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_merinv_raise;
         END;
      EXCEPTION
         WHEN excp_merinv_raise
         THEN
            p_errmsg := v_errmsg;

            UPDATE migr_caf_info_entry
               SET mci_proc_flag = 'E',
                   mci_process_msg = p_errmsg
             WHERE mci_merc_id = i.mci_merc_id AND mci_inv_flag = 'Y';

            INSERT INTO migr_cust_data_excp
                        (mce_file_name, mce_record_number, mce_card_number,
                         mce_process_flag, mce_process_msg, mce_ins_date)
               SELECT mci_file_name, mci_rec_num, mci_pan_code, 'E', p_errmsg,
                      SYSDATE
                 FROM migr_caf_info_entry
                WHERE mci_merc_id = i.mci_merc_id AND mci_inv_flag = 'Y';
         WHEN OTHERS
         THEN
            p_errmsg :=
                  'Error while configuring mer inv order details as '
               || SUBSTR (SQLERRM, 1, 200);

            UPDATE migr_caf_info_entry
               SET mci_proc_flag = 'E',
                   mci_process_msg = p_errmsg
             WHERE mci_merc_id = i.mci_merc_id AND mci_inv_flag = 'Y';

            INSERT INTO migr_cust_data_excp
                        (mce_file_name, mce_record_number, mce_card_number,
                         mce_process_flag, mce_process_msg, mce_ins_date)
               SELECT mci_file_name, mci_rec_num, mci_pan_code, 'E', p_errmsg,
                      SYSDATE
                 FROM migr_caf_info_entry
                WHERE mci_merc_id = i.mci_merc_id AND mci_inv_flag = 'Y';
      END;
   END LOOP;

   p_errmsg := 'OK';
EXCEPTION
   WHEN OTHERS
   THEN
      p_errmsg :=
            'Error while configuring mer inv order details as '
         || SUBSTR (SQLERRM, 1, 200);
END;
/
SHOW ERRORS;
