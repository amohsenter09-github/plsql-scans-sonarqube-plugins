DECLARE
   v_inst_code     NUMBER (5)                       := 1;
   v_max_custid    VMSCMS.cms_cust_mast.ccm_cust_id%TYPE;
   v_custid_seq    VMSCMS.cms_cust_mast.ccm_cust_id%TYPE;
   v_loop_indx     NUMBER (10);
   v_lupd_user     NUMBER (5);
   v_dum           VMSCMS.cms_cust_mast.ccm_cust_id%TYPE;
   v_err_mesg      VARCHAR2 (500);
   v_excp_reject   EXCEPTION;
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
      SELECT MAX (ccm_cust_id)
        INTO v_max_custid
        FROM VMSCMS.cms_cust_mast
       WHERE ccm_inst_code = v_inst_code;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_mesg :=
            'Error while checking max cust id as '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;

   DBMS_OUTPUT.put_line ('Max cust Id  : ' || v_max_custid);

   BEGIN
      SELECT VMSCMS.seq_cust_id.NEXTVAL
        INTO v_custid_seq
        FROM DUAL;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_mesg :=
               'Error while checking for current value for cust id as '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;

   DBMS_OUTPUT.put_line ('Cuurent cust Id sequence number : ' || v_custid_seq);

   IF v_custid_seq < v_max_custid
   THEN
      v_loop_indx := v_max_custid - v_custid_seq + 10;

      FOR i IN 1 .. v_loop_indx
      LOOP
         BEGIN
            SELECT VMSCMS.seq_cust_id.NEXTVAL
              INTO v_dum
              FROM DUAL;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_err_mesg :=
                     'Error while updating sequence value for cust id as '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE v_excp_reject;
         END;
      END LOOP;
   END IF;

   DBMS_OUTPUT.put_line (   'Cust Id sequence number after updating : '
                         || NVL (v_dum, v_custid_seq)
                        );

   INSERT INTO VMSCMS.migr_updt_ctrl_detl
               (muc_inst_code, muc_prod_code, muc_card_type, muc_brch_numb,
                muc_ctrl_numb, muc_ctrl_type, muc_proc_flag, muc_proc_mesg,
                muc_ins_date, muc_ins_user
               )
        VALUES (v_inst_code, NULL, NULL, NULL,
                v_dum, 'CUSTIDSEQ', 'S', v_err_mesg,
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
                   NULL, v_custid_seq, 'CUSTIDSEQ',
                   'E', v_err_mesg, SYSDATE, v_lupd_user
                  );
   WHEN OTHERS
   THEN
      v_err_mesg :=
            'Error while updating sequence value for cust id as '
         || SUBSTR (SQLERRM, 1, 200);

      INSERT INTO VMSCMS.migr_updt_ctrl_detl
                  (muc_inst_code, muc_prod_code, muc_card_type,
                   muc_brch_numb, muc_ctrl_numb, muc_ctrl_type,
                   muc_proc_flag, muc_proc_mesg, muc_ins_date, muc_ins_user
                  )
           VALUES (v_inst_code, NULL, NULL,
                   NULL, v_custid_seq, 'CUSTIDSEQ',
                   'E', v_err_mesg, SYSDATE, v_lupd_user
                  );
END;
/

SHOW ERRORS;