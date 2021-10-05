PROMPT      MIGRATION PROCESS STARTED   

SPOOL $VMS_HOME/MIGRATION/MIGR_EXEC.log
SET ECHO ON

SET ECHO OFF
-------------------------------------------------------------
--                  EXECUT NIGRATION PROCESS               --
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
   
--------------------------------------------------------------------------------
--              START OF CUSTOMER AND ACCT DATA MIGRATION PROCESS             --
--------------------------------------------------------------------------------

   BEGIN
      t1 := DBMS_UTILITY.get_time;
      VMSCMS.migr_entry_newcaf_pkg.migr_start_process (v_inst_code,
                                                v_lupd_user,
                                                v_errmsg
                                               );
      t2 := DBMS_UTILITY.get_time;
      t3 := ROUND (((t2 - t1) / 100), 2);
      DBMS_OUTPUT.put_line ('CUST AND ACCT DATA MIGR :' || t3);
   END;

   IF v_errmsg <> 'OK'
   THEN
      v_errmsg := 'Excp : Account and Customer - Card Migr- ' || v_errmsg;
      RAISE excp_break_proc;
   END IF;


--------------------------------------------------------------------------------
--              START OF SUPPORT FUNCTION DATA MIGRATION PROCESS              --
--------------------------------------------------------------------------------
 /*  BEGIN
      t1 := DBMS_UTILITY.get_time;
      VMSCMS.migr_entry_newcaf_pkg.migr_spprt_func_pkg (v_inst_code,
                                                 v_lupd_user,
                                                 v_errmsg
                                                );
      t2 := DBMS_UTILITY.get_time;
      t3 := ROUND (((t2 - t1) / 100), 2);
      DBMS_OUTPUT.put_line ('SUPPORT FUNC MIGR :' || t3);
   END;

   IF v_errmsg <> 'OK'
   THEN
      v_errmsg := 'Excp : Support Function Migr ' || v_errmsg;
      RAISE excp_break_proc;
   END IF;
*/
--------------------------------------------------------------------------------
--                   START OF TRANSACTION  DATA MIGRATION PROCESS             --
--------------------------------------------------------------------------------

   BEGIN
      t1 := DBMS_UTILITY.get_time;
      VMSCMS.migr_entry_newcaf_pkg.migr_transaction_pkg (v_inst_code,
                                                  v_ins_date,
                                                  v_lupd_user,
                                                  v_errmsg
                                                 );
      t2 := DBMS_UTILITY.get_time;
      t3 := ROUND (((t2 - t1) / 100), 2);
      DBMS_OUTPUT.put_line ('TRAN DATA MIGR :' || t3);
   END;

   IF v_errmsg <> 'OK'
   THEN
      v_errmsg := 'Excp : Support Function Migr- ' || v_errmsg;
      RAISE excp_break_proc;
   END IF;

--------------------------------------------------------------------------------
--                   START OF CALL DATA MIGRATION PROCESS             --
--------------------------------------------------------------------------------

   BEGIN
      t1 := DBMS_UTILITY.get_time;
      VMSCMS.migr_entry_newcaf_pkg.MIGR_CALLLOG_PKG (v_inst_code,
                                                  v_ins_date,
                                                  v_lupd_user,
                                                  v_errmsg
                                                 );
      t2 := DBMS_UTILITY.get_time;
      t3 := ROUND (((t2 - t1) / 100), 2);
      DBMS_OUTPUT.put_line ('CALL DATA MIGR :' || t3);
   END;

   IF v_errmsg <> 'OK'
   THEN
      v_errmsg := 'Excp : Call Data Migr- ' || v_errmsg;
      RAISE excp_break_proc;
   END IF;

   IF v_errmsg = 'OK'
   THEN
      DBMS_OUTPUT.put_line
                         ('CMS Data Migration Process successfully completed');
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

SPOOL OFF;


PROMPT      MIGRATION PROCESS COMPLETED


SET ECHO ON
SET ECHO OFF
-------------------------------------------------------------
--                  CREATE REPORTS                         --
-------------------------------------------------------------

@$VMS_HOME/MIGRATION/SOURCE/DATA_MIGR_REPORTS.sql;

commit;

