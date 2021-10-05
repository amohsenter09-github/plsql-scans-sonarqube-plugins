DECLARE
   v_path         VARCHAR2 (100);
   v_create_dir   VARCHAR2 (400);
   v_drop_dir     VARCHAR2 (400);
   v_grant_dir    VARCHAR2 (400);
   v_err_msg      VARCHAR2 (500) := 'OK';
   v_raise        EXCEPTION;
   v_excp         EXCEPTION;
   PRAGMA EXCEPTION_INIT (v_excp, -00955);
BEGIN
 
   BEGIN
      SELECT mdp_path
        INTO v_path
        FROM vmscms.migr_dir_path;

      IF TRIM (v_path) IS NULL
      THEN
         v_err_msg := 'Directory VMS_HOME Not FOUND '; --Error message modified by Pankaj S. on 25-Sep-2013
         RAISE v_raise;
      END IF;

      v_path := TRIM (v_path);
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_msg :=
               'Error while getting the vms home path as '
            || SUBSTR (SQLERRM, 1, 200);
         RAISE v_raise;
   END;

   BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_ACCO AS '
         || ''''
         || v_path
         || '/MIGRATION/FILES/ACCO'
         || '''';
      v_grant_dir := 'GRANT READ ON DIRECTORY DIR_ACCO TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_ACCO';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING ACCO DIRECTORY IS ' || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;

   BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_CUST AS '
         || ''''
         || v_path
         || '/MIGRATION/FILES/CUST'
         || '''';
      v_grant_dir := 'GRANT READ ON DIRECTORY DIR_CUST TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_CUST';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING CUST DIRECTORY IS '
            || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;

   BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_TRAN AS '
         || ''''
         || v_path
         || '/MIGRATION/FILES/TRAN'
         || '''';
      v_grant_dir := 'GRANT READ ON DIRECTORY DIR_TRAN TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_TRAN';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING TRAN DIRECTORY IS '
            || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;



   BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_REP_ACCO AS '
         || ''''
         || v_path
         || '/MIGRATION/REPORTS/ACCO'
         || '''';
      v_grant_dir := 'GRANT WRITE ON DIRECTORY DIR_REP_ACCO TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_REP_ACCO';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING ACCO REPORT DIRECTORY' || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;

   BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_REP_CUST AS '
         || ''''
         || v_path
         || '/MIGRATION/REPORTS/CUST'
         || '''';
      v_grant_dir := 'GRANT WRITE ON DIRECTORY DIR_REP_CUST TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_REP_CUST';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING CUST REPORT DIRECTORY '
            || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;

   BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_REP_TRAN AS '
         || ''''
         || v_path
         || '/MIGRATION/REPORTS/TRAN'
         || '''';
      v_grant_dir := 'GRANT WRITE ON DIRECTORY DIR_REP_TRAN TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_REP_TRAN';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING TRAN REPORT DIRECTORY '
            || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;
   
------------------For online----------------

   BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_REP_TRAN_ONLINE AS '
         || ''''
         || v_path
         || '/MIGRATION/REPORTS/TRAN/ONLINE'
         || '''';
      v_grant_dir := 'GRANT WRITE ON DIRECTORY DIR_REP_TRAN_ONLINE TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_REP_TRAN_ONLINE';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING TRAN FILE ONLINE DIRECTORY '
            || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;
   
   
   /*BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_REP_CUST_ONLINE AS '
         || ''''
         || v_path
         || '/MIGRATION/REPORTS/CUST/ONLINE'
         || '''';
      v_grant_dir := 'GRANT WRITE ON DIRECTORY DIR_REP_CUST_ONLINE TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_REP_CUST_ONLINE';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING CUST FILE ONLINE DIRECTORY '
            || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;
   
   BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_REP_ACCO_ONLINE AS '
         || ''''
         || v_path
         || '/MIGRATION/REPORTS/ACCO/ONLINE'
         || '''';
      v_grant_dir := 'GRANT WRITE ON DIRECTORY DIR_REP_ACCO_ONLINE TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_REP_ACCO_ONLINE';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING ACCO FILE ONLINE DIRECTORY '
            || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;*/         

   ------------------SN : For CALLLOG----------------
   
   BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_REP_CALL AS '
         || ''''
         || v_path
         || '/MIGRATION/REPORTS/CALL'
         || '''';
      v_grant_dir := 'GRANT WRITE ON DIRECTORY DIR_REP_CALL TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_REP_CALL';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING CALL REPORT DIRECTORY '
            || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;
           
   BEGIN
      v_create_dir :=
            'CREATE DIRECTORY DIR_CALL AS '
         || ''''
         || v_path
         || '/MIGRATION/FILES/CALL'
         || '''';
      v_grant_dir := 'GRANT READ ON DIRECTORY DIR_CALL TO VMSCMS';

      EXECUTE IMMEDIATE v_create_dir;

      EXECUTE IMMEDIATE v_grant_dir;
   EXCEPTION
      WHEN v_excp
      THEN
         v_drop_dir := 'DROP DIRECTORY DIR_CALL';

         EXECUTE IMMEDIATE v_drop_dir;

         EXECUTE IMMEDIATE v_create_dir;

         EXECUTE IMMEDIATE v_grant_dir;
      WHEN OTHERS
      THEN
         v_err_msg :=
            'ERROR WHILE CREATING CALL DIRECTORY IS '
            || SUBSTR (SQLERRM, 1, 100);
         RAISE v_raise;
   END;   

------------------EN : For CALLLOG----------------   


   DBMS_OUTPUT.put_line (v_err_msg);
EXCEPTION
   WHEN v_raise
   THEN
      DBMS_OUTPUT.put_line (v_err_msg);
   WHEN OTHERS
   THEN
      v_err_msg :=
             'ERROR WHILE DIRECTORY CREATION AS ' || SUBSTR (SQLERRM, 1, 200);
      DBMS_OUTPUT.put_line (v_err_msg);
END;
/
SHOW ERROR;
