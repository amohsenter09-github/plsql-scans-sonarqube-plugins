DECLARE
   v_inst_code      NUMBER (5)                         := 1;
   v_max_addrcode   VMSCMS.cms_addr_mast.cam_addr_code%TYPE;
   v_addr_seq       VMSCMS.cms_addr_mast.cam_addr_code%TYPE;
   v_loop_indx      NUMBER (10);
   v_lupd_user      NUMBER (5);
   v_dum            VMSCMS.cms_addr_mast.cam_addr_code%TYPE;
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
               'Error while checking for Migration user in user master is-'
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;

   BEGIN
      SELECT MAX (cam_addr_code)
        INTO v_max_addrcode
        FROM VMSCMS.cms_addr_mast
       WHERE cam_inst_code = v_inst_code;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_mesg :=
               'Error while checking max address code is -'  --Error message modified by Pankaj S. on 25-Sep-2013
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;
   
   DBMS_OUTPUT.put_line ('Max Address Code  : '||v_max_addrcode);

   BEGIN
      SELECT VMSCMS.seq_addr_code.NEXTVAL
        INTO v_addr_seq
        FROM DUAL;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_mesg :=
               'Error while getting current value for address code is -' --Error message modified by Pankaj S. on 25-Sep-2013
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_excp_reject;
   END;

   DBMS_OUTPUT.put_line ('Cuurent Address Code sequence number : '||v_addr_seq);
   v_dum:=
   IF v_addr_seq < v_max_addrcode
   THEN
      v_loop_indx := v_max_addrcode - v_addr_seq + 10;

      FOR i IN 1 .. v_loop_indx
      LOOP
         BEGIN
            SELECT VMSCMS.seq_addr_code.NEXTVAL
              INTO v_dum
              FROM DUAL;
         EXCEPTION
            WHEN OTHERS
            THEN
               v_err_mesg :=
                     'Error while updating sequence value for address code is-' --Error message modified by Pankaj S. on 25-Sep-2013
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE v_excp_reject;
         END;
      END LOOP;
   END IF;
   
   
   DBMS_OUTPUT.put_line ('Address code sequence number after updating : '||NVL(v_dum,v_addr_seq));

   INSERT INTO VMSCMS.migr_updt_ctrl_detl
               (muc_inst_code, muc_prod_code, muc_card_type, muc_brch_numb,
                muc_ctrl_numb, muc_ctrl_type, muc_proc_flag, muc_proc_mesg,
                muc_ins_date, muc_ins_user
               )
        VALUES (v_inst_code, NULL, NULL, NULL,
                v_dum, 'ADDRSEQ', 'S', v_err_mesg,
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
                   NULL, v_addr_seq, 'ADDRSEQ',
                   'E', v_err_mesg, SYSDATE, v_lupd_user
                  );
   WHEN OTHERS
   THEN
      v_err_mesg :=
            'Error while updating sequence value for address code is-' --Error message modified by Pankaj S. on 25-Sep-2013
         || SUBSTR (SQLERRM, 1, 200);

      INSERT INTO VMSCMS.migr_updt_ctrl_detl
                  (muc_inst_code, muc_prod_code, muc_card_type,
                   muc_brch_numb, muc_ctrl_numb, muc_ctrl_type,
                   muc_proc_flag, muc_proc_mesg, muc_ins_date, muc_ins_user
                  )
           VALUES (v_inst_code, NULL, NULL,
                   NULL, v_addr_seq, 'ADDRSEQ',
                   'E', v_err_mesg, SYSDATE, v_lupd_user
                  );
END;
/