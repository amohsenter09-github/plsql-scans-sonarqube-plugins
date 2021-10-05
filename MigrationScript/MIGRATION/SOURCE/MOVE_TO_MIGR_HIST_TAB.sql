DECLARE
   v_errmsg     VARCHAR2 (200);
   insert_exp   EXCEPTION;
BEGIN
   v_errmsg := 'OK';

   BEGIN
      INSERT INTO vmscms.migr_transactionlog_temp_hist
         SELECT *
           FROM vmscms.migr_transactionlog_temp;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg :=
                 'NO RECORD INSERTED IN migr_transactionlog_temp_hist TABLE.';
         RAISE insert_exp;
      END IF;
   EXCEPTION
      WHEN insert_exp
      THEN
         RAISE insert_exp;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN migr_transactionlog_temp_hist TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;

   BEGIN
      INSERT INTO vmscms.migr_caf_info_entry_hist
         SELECT *
           FROM vmscms.migr_caf_info_entry;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg := 'NO RECORD INSERTED IN migr_caf_info_entry_hist TABLE.';
         RAISE insert_exp;
      END IF;
   EXCEPTION
      WHEN insert_exp
      THEN
         RAISE insert_exp;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN migr_caf_info_entry_hist TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;

   BEGIN
      INSERT INTO vmscms.migr_acct_data_temp_hist
         SELECT *
           FROM vmscms.migr_acct_data_temp;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg := 'NO RECORD INSERTED IN migr_acct_data_temp_hist TABLE.';
         RAISE insert_exp;
      END IF;
   EXCEPTION
      WHEN insert_exp
      THEN
         RAISE insert_exp;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN migr_acct_data_temp_hist TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;

   BEGIN
      INSERT INTO vmscms.migr_acct_data_excp_hist
         SELECT *
           FROM vmscms.migr_acct_data_excp;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg := 'OK';
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN migr_acct_data_excp_hist TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;

   BEGIN
      INSERT INTO vmscms.migr_cust_data_excp_hist
         SELECT *
           FROM vmscms.migr_cust_data_excp;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg := 'OK';
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN migr_cust_data_excp_hist TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;

   BEGIN
      INSERT INTO vmscms.migr_txnlog_excp_hist
         SELECT *
           FROM vmscms.migr_txnlog_excp;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg := 'OK';
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN migr_txnlog_excp_hist TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;

   BEGIN
      INSERT INTO vmscms.migr_file_load_info_hist
         SELECT *
           FROM vmscms.migr_file_load_info;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg := 'NO RECORD INSERTED IN migr_file_load_info_hist TABLE.';
         RAISE insert_exp;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN migr_file_load_info_hist TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;

   BEGIN
      INSERT INTO vmscms.migr_file_detl_hist
         SELECT *
           FROM vmscms.migr_file_detl;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg := 'NO RECORD INSERTED IN migr_file_detl_hist TABLE.';
         RAISE insert_exp;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN migr_file_detl_hist TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;

   BEGIN
      INSERT INTO vmscms.migr_rpt_wrt_fail_hist
         SELECT *
           FROM vmscms.migr_rpt_wrt_fail;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg := 'OK';
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN MIGR_RPT_WRT_FAIL_HIST TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;

   BEGIN
      INSERT INTO vmscms.migr_rpt_wrt_succ_hist
         SELECT *
           FROM vmscms.migr_rpt_wrt_succ;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg := 'NO RECORD INSERTED IN MIGR_RPT_WRT_SUCC_HIST TABLE.';
         RAISE insert_exp;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN MIGR_RPT_WRT_SUCC_HIST TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;
   
   BEGIN
      INSERT INTO vmscms.migr_csr_calllog_temp_hist
         SELECT *
           FROM vmscms.migr_csr_calllog_temp;

      IF SQL%ROWCOUNT = 0
      THEN
         v_errmsg :=
                 'NO RECORD INSERTED IN migr_csr_calllog_temp_hist TABLE.';
         RAISE insert_exp;
      END IF;
   EXCEPTION
      WHEN insert_exp
      THEN
         RAISE insert_exp;
      WHEN OTHERS
      THEN
         v_errmsg :=
               'ERROR OCCURED WHILE INSERTION IN migr_csr_calllog_temp_hist TABLE-'
            || SUBSTR (SQLERRM, 1, 100);
         RAISE insert_exp;
   END;   

   IF v_errmsg = 'OK'
   THEN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.MIGR_RPT_WRT_SUCC';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.MIGR_RPT_WRT_FAIL';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.migr_file_detl';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.migr_file_load_info';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.migr_txnlog_excp';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.migr_cust_data_excp';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.migr_acct_data_excp';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.migr_acct_data_temp';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.migr_caf_info_entry';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.migr_transactionlog_temp';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.MIGR_RPT_WRT_SUCC';

      EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.MIGR_RPT_WRT_FAIL';
	  
	  EXECUTE IMMEDIATE 'TRUNCATE TABLE vmscms.migr_csr_calllog_temp';

      INSERT INTO vmscms.migr_histtbl_status
           VALUES (v_errmsg);
   END IF;
EXCEPTION
   WHEN insert_exp
   THEN
      ROLLBACK;

      INSERT INTO vmscms.migr_histtbl_status
           VALUES (v_errmsg);
END;
/
SHOW ERROR;