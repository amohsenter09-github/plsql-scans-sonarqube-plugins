DECLARE
   v_inst_code      NUMBER (5)                         := 1;
   v_max_custcode   VMSCMS.cms_cust_mast.ccm_cust_code%TYPE;
   v_cust_seq       VMSCMS.cms_cust_mast.ccm_cust_code%TYPE;
   v_loop_indx      NUMBER (10);
   v_lupd_user      NUMBER (5);
   v_dum            VMSCMS.cms_cust_mast.ccm_cust_code%TYPE;
   v_err_mesg       VARCHAR2 (500);
   v_excp_reject    EXCEPTION;
BEGIN
   v_err_mesg := 'OK';

   BEGIN
      SELECT cum_user_pin
        INTO v_lupd_user
        FROM VMSCMS.cms_user_mast
       WHERE cum_user_code = 'MIGR_USER' AND cum_inst_code = v_inst_code;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_err_mesg := 'Migration user not found in user master';
         RAISE v_excp_reject;
      WHEN OTHERS
      THEN
         v_err_mesg :=
               'Error while checking for Migration user in user master as '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;

   BEGIN
      SELECT MAX (ccm_cust_code)
        INTO v_max_custcode
        FROM VMSCMS.cms_cust_mast
       WHERE ccm_inst_code = v_inst_code;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_mesg :=
               'Error while checking for migrated customer count as '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;
DBMS_OUTPUT.put_line ('Max Cust Code  : ' || v_max_custcode);
   BEGIN
      SELECT VMSCMS.seq_custcode.NEXTVAL
        INTO v_cust_seq
        FROM DUAL;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_mesg :=
               'Error while checking for current value for customer code as '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;
   DBMS_OUTPUT.put_line ('Cuurent Cust Code Sequence Number : ' || v_cust_seq);
   IF v_cust_seq < v_max_custcode
   THEN
      v_loop_indx := v_max_custcode - v_cust_seq + 10;

      FOR i IN 1 .. v_loop_indx
      LOOP
         BEGIN
            SELECT VMSCMS.seq_custcode.NEXTVAL
              INTO v_dum
              FROM DUAL;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_err_mesg :=
                     'Error while updating sequence value for customer code as '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE v_excp_reject;
         END;
      END LOOP;
   END IF;
DBMS_OUTPUT.put_line (   'Cust Code Sequence Number After Updating : '
                         || NVL (v_dum, v_cust_seq)
                        );
   INSERT INTO VMSCMS.migr_updt_ctrl_detl
               (muc_inst_code, muc_prod_code, muc_card_type, muc_brch_numb,
                muc_ctrl_numb, muc_ctrl_type, muc_proc_flag, muc_proc_mesg,
                muc_ins_date, muc_ins_user
               )
        VALUES (v_inst_code, NULL, NULL, NULL,
                v_dum, 'CUSTSEQ', 'S', v_err_mesg,
                SYSDATE, v_lupd_user
               );
EXCEPTION
   WHEN v_excp_reject
   THEN
      v_err_mesg := v_err_mesg;

      INSERT INTO VMSCMS.migr_updt_ctrl_detl
                  (muc_inst_code, muc_prod_code, muc_card_type,
                   muc_brch_numb, muc_ctrl_numb, muc_ctrl_type,
                   muc_proc_flag, muc_proc_mesg, muc_ins_date, muc_ins_user
                  )
           VALUES (v_inst_code, NULL, NULL,
                   NULL, v_cust_seq, 'CUSTSEQ',
                   'E', v_err_mesg, SYSDATE, v_lupd_user
                  );
   WHEN OTHERS
   THEN
      v_err_mesg :=
            'Error while updating sequence value for customer code/id as '
         || SUBSTR (SQLERRM, 1, 200);

      INSERT INTO VMSCMS.migr_updt_ctrl_detl
                  (muc_inst_code, muc_prod_code, muc_card_type,
                   muc_brch_numb, muc_ctrl_numb, muc_ctrl_type,
                   muc_proc_flag, muc_proc_mesg, muc_ins_date, muc_ins_user
                  )
           VALUES (v_inst_code, NULL, NULL,
                   NULL, v_cust_seq, 'CUSTSEQ',
                   'E', v_err_mesg, SYSDATE, v_lupd_user
                  );
END;
/