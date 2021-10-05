DECLARE
   v_inst_code      NUMBER (5)                         := 1;
   v_applcode_cnt   VMSCMS.cms_appl_mast.cam_appl_code%TYPE;
   v_appl_seq       VMSCMS.cms_appl_mast.cam_appl_code%TYPE;
   v_loop_indx      NUMBER (10);
   v_lupd_user      NUMBER (5);
   v_dum            VMSCMS.cms_appl_mast.cam_appl_code%TYPE;
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
      SELECT mct_ctrl_numb
        INTO v_applcode_cnt
        FROM VMSCMS.migr_ctrl_table
       WHERE mct_ctrl_code = v_inst_code
         AND mct_ctrl_key = 'APPLCODE'
         AND mct_inst_code = v_inst_code;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_mesg :=
               'Error while checking appl code count as '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;

   DBMS_OUTPUT.put_line ('Number of application code created during migration  : '||v_applcode_cnt);
   
   BEGIN
      SELECT VMSCMS.seq_appl_code.NEXTVAL
        INTO v_appl_seq
        FROM DUAL;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_mesg :=
               'Error while checking for current value for appl code as '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;

   DBMS_OUTPUT.put_line ('Cuurent Application Code sequence number : '||v_appl_seq);
   
   IF v_applcode_cnt > v_appl_seq
   THEN
      v_loop_indx := v_applcode_cnt - v_appl_seq + 10;

      FOR i IN 1 .. v_loop_indx
      LOOP
         BEGIN
            SELECT VMSCMS.seq_appl_code.NEXTVAL
              INTO v_dum
              FROM DUAL;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_err_mesg :=
                     'Error while updating sequence value for appl code as '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE v_excp_reject;
         END;
      END LOOP;		 
   END IF;
   
   DBMS_OUTPUT.put_line ('Application code sequence number after updating : '||NVL(v_dum,v_appl_seq));    	 
   
   DELETE VMSCMS.migr_ctrl_table
   WHERE mct_ctrl_code = v_inst_code
         AND mct_ctrl_key = 'APPLCODE'
         AND mct_inst_code = v_inst_code;
		 
   DBMS_OUTPUT.put_line ('Application code cureent sequence updated in migr_ctrl_table table');	
   
   INSERT INTO VMSCMS.migr_updt_ctrl_detl
               (muc_inst_code, muc_prod_code, muc_card_type, muc_brch_numb,
                muc_ctrl_numb, muc_ctrl_type, muc_proc_flag, muc_proc_mesg,
                muc_ins_date, muc_ins_user
               )
        VALUES (v_inst_code, NULL, NULL, NULL,
                v_applcode_cnt, 'APPLSEQ', 'S', v_err_mesg,
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
                   NULL, v_appl_seq, 'APPLSEQ',
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
                   NULL, v_appl_seq, 'APPLSEQ',
                   'E', v_err_mesg, SYSDATE, v_lupd_user
                  );
END;
/