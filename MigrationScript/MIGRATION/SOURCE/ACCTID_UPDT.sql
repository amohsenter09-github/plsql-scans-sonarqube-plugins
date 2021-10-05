DECLARE
   v_inst_code     NUMBER (5)                       := 1;
   v_max_acctid    VMSCMS.cms_acct_mast.cam_acct_id%TYPE;
   v_acct_seq      VMSCMS.cms_acct_mast.cam_acct_id%TYPE;
   v_loop_indx     NUMBER (10);
   v_lupd_user     NUMBER (5);
   v_dum           VMSCMS.cms_acct_mast.cam_acct_id%TYPE;
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
               'Error while checking for Migration user in user master- '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;

   BEGIN
      SELECT MAX (cam_acct_id)
        INTO v_max_acctid
        FROM VMSCMS.cms_acct_mast
       WHERE cam_inst_code = v_inst_code;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_mesg :=
               'Error while checking max account id as '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;

   DBMS_OUTPUT.put_line ('Max Account Id  : '||v_max_acctid);
   
   BEGIN
      SELECT VMSCMS.seq_acct_id.NEXTVAL
        INTO v_acct_seq
        FROM DUAL;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_mesg :=
               'Error while checking for current value for account id as '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;

   DBMS_OUTPUT.put_line ('Cuurent Account Id sequence number : '||v_acct_seq);
   
   IF v_acct_seq < v_max_acctid
   THEN
      v_loop_indx := v_max_acctid - v_acct_seq + 10;

      FOR i IN 1 .. v_loop_indx
      LOOP
         BEGIN
            SELECT VMSCMS.seq_acct_id.NEXTVAL
              INTO v_dum
              FROM DUAL;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_err_mesg :=
                     'Error while updating sequence value for account id as '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE v_excp_reject;
         END;
      END LOOP;
   END IF;
   
   DBMS_OUTPUT.put_line ('Account Id sequence number after updating : '||NVL(v_dum,v_acct_seq));

   INSERT INTO VMSCMS.migr_updt_ctrl_detl
               (muc_inst_code, muc_prod_code, muc_card_type, muc_brch_numb,
                muc_ctrl_numb, muc_ctrl_type, muc_proc_flag, muc_proc_mesg,
                muc_ins_date, muc_ins_user
               )
        VALUES (v_inst_code, NULL, NULL, NULL,
                v_dum, 'ACCTSEQ', 'S', v_err_mesg,
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
                   NULL, v_acct_seq, 'ACCTSEQ',
                   'E', v_err_mesg, SYSDATE, v_lupd_user
                  );
   WHEN OTHERS
   THEN
      v_err_mesg :=
            'Error while updating sequence value for account id as '
         || SUBSTR (SQLERRM, 1, 200);

      INSERT INTO VMSCMS.migr_updt_ctrl_detl
                  (muc_inst_code, muc_prod_code, muc_card_type,
                   muc_brch_numb, muc_ctrl_numb, muc_ctrl_type,
                   muc_proc_flag, muc_proc_mesg, muc_ins_date, muc_ins_user
                  )
           VALUES (v_inst_code, NULL, NULL,
                   NULL, v_acct_seq, 'ACCTSEQ',
                   'E', v_err_mesg, SYSDATE, v_lupd_user
                  );
END;
/