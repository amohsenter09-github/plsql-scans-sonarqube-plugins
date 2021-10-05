PROMPT     DATA LOAD PROCESS STARTED


SPOOL $VMS_HOME/MIGRATION/DATA_LOAD.log

-------------------------------------------------------------
--                  CREATE MIGRATION USER                  --
-------------------------------------------------------------


@$VMS_HOME/MIGRATION/SOURCE/MIGR_CREATE_USER.sql;


exec UTL_FILE.FCLOSE_ALL;


-------------------------------------------------------------
--           MIGRATION DATA LOAD - START                   --
-------------------------------------------------------------



DECLARE
   v_inst_code       NUMBER (5)     := 1;
   v_lupd_user       NUMBER (5);
   v_errmsg          VARCHAR2 (300);
   v_ins_date        DATE           := SYSDATE;
   excp_break_proc   EXCEPTION;
   t1                NUMBER (10);
   t2                NUMBER (10);
   t3                NUMBER (10);
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
         v_errmsg := 'Migration User not Created ';
         RAISE excp_break_proc;
   END;

-------------------------------------------------------------
--                LOAD DATA IN THE TEMP TABLES             --
-------------------------------------------------------------
   BEGIN
      t1 := DBMS_UTILITY.get_time;
      VMSCMS.migr_gen_data_load (v_inst_code, v_lupd_user,v_errmsg);
      t2 := DBMS_UTILITY.get_time;
      t3 := ROUND (((t2 - t1) / 100), 2);
      DBMS_OUTPUT.put_line ('DATA LOAD :' || t3);
   END;

   IF v_errmsg <> 'OK'
   THEN
      v_errmsg := 'Excp : Data Load ' || v_errmsg;
      RAISE excp_break_proc;
   END IF;
EXCEPTION
   WHEN excp_break_proc
   THEN
      DBMS_OUTPUT.put_line (v_errmsg);
      RETURN;
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line ('Excp Migr : ' || SUBSTR (SQLERRM, 1, 200));
      RETURN;
END;
/

-------------------------------------------------------------
--           MIGRATION DATA LOAD - END                     --
-------------------------------------------------------------

exec UTL_FILE.FCLOSE_ALL;

SPOOL OFF:


PROMPT     DATA LOAD PROCESS COMPLETED


@@DATA_LOAD_REPORTS.sql;
