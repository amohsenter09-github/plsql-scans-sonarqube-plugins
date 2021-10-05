PROMPT      DATA LOAD ROLLBACK STARTED   


SPOOL $VMS_HOME/MIGRATION/DATA_LOAD_ROLLBACK_LOG.log

TRUNCATE TABLE vmscms.migr_acct_data_temp;
TRUNCATE TABLE vmscms.migr_acct_data_excp;
TRUNCATE TABLE vmscms.migr_caf_info_entry;
TRUNCATE TABLE vmscms.migr_cust_data_excp;
TRUNCATE TABLE vmscms.migr_spprt_func_data;
TRUNCATE TABLE vmscms.migr_spprt_func_excp;
TRUNCATE TABLE vmscms.migr_transactionlog_temp;
TRUNCATE TABLE vmscms.migr_txnlog_excp;
TRUNCATE TABLE vmscms.migr_succ_log;
TRUNCATE TABLE vmscms.migr_error_log;
TRUNCATE TABLE vmscms.migr_file_load_info;
TRUNCATE TABLE vmscms.migr_file_detl;
DELETE FROM vmscms.cms_merinv_ordr
WHERE cmo_ordr_refrno IN (SELECT cmo_ordr_refrno
                                  FROM vmscms.cms_merinv_ordr_temp);
TRUNCATE TABLE vmscms.cms_merinv_ordr_temp;
TRUNCATE TABLE vmscms.migr_rpt_wrt_succ;
TRUNCATE TABLE vmscms.migr_rpt_wrt_fail;
TRUNCATE TABLE vmscms.migr_roll_count;
TRUNCATE TABLE vmscms.migr_callog_data_excp;
TRUNCATE TABLE vmscms.migr_csr_calllog_temp;

SPOOL OFF:


PROMPT      DATA LOAD ROLLBACK COMPLETED

