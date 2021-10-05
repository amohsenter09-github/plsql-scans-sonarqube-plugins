CREATE TABLE vmscms.migr_transactionlog_temp_hist
AS 
SELECT * FROM vmscms.migr_transactionlog_temp
WHERE 1 = 2;

CREATE TABLE vmscms.migr_caf_info_entry_hist
AS 
SELECT * FROM vmscms.migr_caf_info_entry
WHERE 1 = 2;

CREATE TABLE vmscms.migr_acct_data_temp_hist
AS
SELECT * FROM vmscms.migr_acct_data_temp
WHERE 1 = 2;

CREATE TABLE vmscms.migr_acct_data_excp_hist
AS
SELECT * FROM vmscms.migr_acct_data_excp
WHERE 1 = 2;

CREATE TABLE vmscms.migr_cust_data_excp_hist
AS
SELECT * FROM vmscms.migr_cust_data_excp
WHERE 1 = 2;

CREATE TABLE vmscms.migr_txnlog_excp_hist
AS
SELECT * FROM vmscms.migr_txnlog_excp
WHERE 1 = 2;

CREATE TABLE vmscms.migr_file_load_info_hist
AS
SELECT * FROM  vmscms.migr_file_load_info
WHERE 1 = 2;

CREATE TABLE vmscms.migr_file_detl_hist
AS
SELECT * FROM  vmscms.migr_file_detl
WHERE 1 = 2;

CREATE TABLE vmscms.migr_csr_calllog_temp_hist
AS
SELECT * FROM  vmscms.MIGR_CSR_CALLLOG_TEMP
WHERE 1 = 2;