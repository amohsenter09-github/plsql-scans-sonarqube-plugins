PROMPT      DROPPING OF MIGRATIOIN OBJECTS STARTED   

SET TRIMSPOOL ON
SET ECHO ON
SPOO $VMS_HOME/MIGRATION/MIGR_OBJECTS_DROP.log

DROP SEQUENCE vmscms.SEQ_MERINV_ORDR_REFRNO;
DROP TABLE VMSCMS.MIGR_DIR_LIST;
DROP TABLE VMSCMS.MIGR_FILE_LOAD_INFO;
DROP TABLE VMSCMS.MIGR_CUST_ACCT_ERR;
DROP TABLE VMSCMS.MIGR_ACCT_DATA_EXCP;
DROP TABLE VMSCMS.MIGR_ACCT_DATA_TEMP;
DROP TABLE VMSCMS.MIGR_CAF_INFO_ENTRY;
DROP TABLE VMSCMS.MIGR_CTRL_TABLE;
DROP TABLE VMSCMS.MIGR_CUST_DATA_EXCP;
DROP TABLE VMSCMS.MIGR_ERROR_LOG;
DROP TABLE VMSCMS.MIGR_FILE_DETL;
DROP TABLE VMSCMS.MIGR_SPPRT_FUNC_DATA;
DROP TABLE VMSCMS.MIGR_SPPRT_FUNC_EXCP;
DROP TABLE VMSCMS.MIGR_SUCC_LOG;
DROP TABLE VMSCMS.MIGR_TRANSACTIONLOG_TEMP;
DROP TABLE VMSCMS.CMS_MERINV_ORDR_TEMP;
DROP TABLE VMSCMS.MIGR_TXNLOG_EXCP;
DROP SEQUENCE VMSCMS.SEQ_MIGR_CALL_ID;
DROP PROCEDURE VMSCMS.SP_MIGR_FILE_DETL;
DROP PROCEDURE VMSCMS.SP_GET_DIR_LIST;
DROP PROCEDURE VMSCMS.SP_MIGR_FILE_LOAD_INFO;
DROP PROCEDURE VMSCMS.SP_MIGR_LOG_EXCP_ACCOUNTDATA;
DROP PROCEDURE VMSCMS.SP_MIGR_LOG_EXCP_CUSTDATA;
DROP PROCEDURE VMSCMS.SP_MIGR_LOG_EXCP_SPPRTFUNC;
DROP PROCEDURE VMSCMS.SP_MIGR_LOG_EXCP_TXNS;
DROP PACKAGE VMSCMS.MIGR_ENTRY_NEWCAF_PKG;
DROP PROCEDURE VMSCMS.MIGR_ACCT_DATA_LOAD;
DROP PROCEDURE VMSCMS.MIGR_CUST_DATA_LOAD;
DROP PROCEDURE VMSCMS.MIGR_SPPRT_FUNC_DATA_LOAD;
DROP PROCEDURE VMSCMS.MIGR_TXNLOG_DATA_LOAD;
DROP PROCEDURE VMSCMS.SP_MERINV_ORDER_CHECK;
DROP PROCEDURE VMSCMS.MIGR_GEN_DATA_LOAD;
DROP TABLE VMSCMS.MIGR_ROLL_COUNT;
DROP TABLE VMSCMS.MIGR_SHRINK_SEGMENTS_LOG;
DROP PROCEDURE VMSCMS.MIGR_SHRINK_SEGMENTS;
DROP PROCEDURE VMSCMS.MIGR_BULK_SHRINK_SEGMENT;
--DROP PROCEDURE VMSCMS.MIGR_ROLLBACK_PROC;
DROP TABLE VMSCMS.MIGR_UPDT_CTRL_DETL;
DROP PROCEDURE VMSCMS.SP_ACCT_TMPNO;
DROP PROCEDURE VMSCMS.MIGR_FIND_BINPREFIX;
DROP PROCEDURE VMSCMS.SP_PANACCT_CTRL_UPDT;
DROP TABLE VMSCMS.MIGR_TRANSACTIONLOG_TEMP_HIST;
DROP TABLE VMSCMS.MIGR_CAF_INFO_ENTRY_HIST;
DROP TABLE VMSCMS.MIGR_ACCT_DATA_TEMP_HIST;
DROP TABLE VMSCMS.MIGR_ACCT_DATA_EXCP_HIST;
DROP TABLE VMSCMS.MIGR_CUST_DATA_EXCP_HIST;
DROP TABLE VMSCMS.MIGR_TXNLOG_EXCP_HIST;
DROP TABLE VMSCMS.MIGR_FILE_LOAD_INFO_HIST;
DROP TABLE VMSCMS.MIGR_FILE_DETL_HIST;
DROP TABLE VMSCMS.MIGR_DIR_PATH;
-- 12-JUL-2013
DROP TABLE VMSCMS.MIGR_DET_ROLL_EXCP;
--11-Aug-2013
drop table vmscms.MIGR_ONLINE_TXNLOG;
drop table vmscms.MIGR_ONLINE_CARDLOG;
--11-OCT-2013
DROP TABLE VMSCMS.MIGR_CALLOG_DATA_EXCP;
DROP TABLE VMSCMS.MIGR_CSR_CALLLOG_TEMP;
DROP TABLE VMSCMS.MIGR_CSR_CALLLOG_TEMP_HIST;

DROP PROCEDURE VMSCMS.MIGR_TRAN_DETL_EXCP_REP;
DROP PROCEDURE VMSCMS.MIGR_DETAIL_EXCP_TRAN_LOAD_REP;
DROP PROCEDURE VMSCMS.MIGR_TRAN_FILEWISE_LOAD_SUMRY;
DROP PROCEDURE VMSCMS.MIGR_TRAN_FILE_LOAD_EXCP;
DROP PROCEDURE VMSCMS.MIGR_TRAN_FILE_LOAD_SUCC;
DROP PROCEDURE VMSCMS.MIGR_CUST_FILE_LOAD_SUCC;
DROP PROCEDURE VMSCMS.MIGR_CUST_FILE_LOAD_EXCP;
DROP PROCEDURE VMSCMS.MIGR_CUST_FILEWISE_LOAD_SUMRY;
DROP PROCEDURE VMSCMS.MIGR_DETAIL_EXCP_CUST_LOAD_REP;
DROP PROCEDURE VMSCMS.MIGR_CUST_CARD_DATA_SUMRY_REP;
DROP PROCEDURE VMSCMS.MIGR_TRAN_DATA_SUMRY_REP;
DROP PROCEDURE VMSCMS.MIGR_ACCT_SUCC_DETL_REP;
DROP PROCEDURE VMSCMS.MIGR_CUST_SUCC_DETL_REP;
DROP PROCEDURE VMSCMS.MIGR_CUST_EXCP_DETL_REP;
DROP PROCEDURE VMSCMS.MIGR_TRAN_SUCCESS_DETAIL_REP;
DROP PROCEDURE VMSCMS.MIGR_ACCO_FILE_LOAD_EXCP;
DROP PROCEDURE VMSCMS.MIGR_ACCO_FILE_LOAD_SUCC;
DROP PROCEDURE VMSCMS.MIGR_ACCO_FILEWISE_LOAD_SUMRY;
DROP PROCEDURE VMSCMS.MIGR_DETAIL_EXCP_ACCT_LOAD_REP;
DROP PROCEDURE VMSCMS.MIGR_DETAIL_EXCP_ACCT_REP;

DROP TABLE VMSCMS.MIGR_RPT_WRT_FAIL ;
DROP TABLE VMSCMS.MIGR_RPT_WRT_SUCC ;
DROP TABLE VMSCMS.MIGR_RPT_WRT_SUCC_HIST;
DROP TABLE VMSCMS.MIGR_RPT_WRT_FAIL_HIST;
DROP TABLE VMSCMS.MIGR_HISTTBL_STATUS;
-- 12-JUL-2013
DROP SEQUENCE VMSCMS.MIG_SEQ_NO; 
DROP PROCEDURE VMSCMS.SP_MIGR_ROLLBACK;
DROP PROCEDURE VMSCMS.MIGR_FILE_ROLL_INFO;
--11-Aug-2013
DROP PROCEDURE VMSCMS.MIGR_ONLINE_TXNDATA_FILE;
DROP PROCEDURE VMSCMS.MIGR_ONLINE_TXNDATA_AFTMIG;
DROP PROCEDURE VMSCMS.MIGR_ONLINE_CARDDATA_FILE;
DROP PROCEDURE VMSCMS.MIGR_ONLINE_CARDDATA_AFTMIG;
DROP PROCEDURE VMSCMS.MIGR_ONLINE_ACCTDATA_FILE;
DROP PROCEDURE VMSCMS.MIGR_ROLL_CARD_DATA_SUMRY_REP;
DROP PROCEDURE VMSCMS.MIGR_ROLL_TRAN_DATA_SUMRY_REP;
DROP PROCEDURE VMSCMS.MIGR_ROLL_ACCT_DATA_SUMRY_REP;	
DROP PROCEDURE VMSCMS.MIGR_ROLL_DETL_EXCP_REP;
--11-OCT-2013
DROP PROCEDURE VMSCMS.MIGR_CALLLOG_DATA_LOAD;
DROP PROCEDURE VMSCMS.SP_MIGR_LOG_EXCP_CALLOGDATA;
DROP PROCEDURE VMSCMS.MIGR_CALL_DATA_SUMRY_REP;
DROP PROCEDURE VMSCMS.MIGR_CALL_EXCP_DETL_REP;
DROP PROCEDURE VMSCMS.MIGR_CALL_FILE_LOAD_EXCP;
DROP PROCEDURE VMSCMS.MIGR_CALL_FILE_LOAD_SUCC;
DROP PROCEDURE VMSCMS.MIGR_CALL_FILEWISE_LOAD_SUMRY;
DROP PROCEDURE VMSCMS.MIGR_CALL_SUCC_DETL_REP;
DROP PROCEDURE VMSCMS.MIGR_DETAIL_EXCP_CALL_LOAD_REP;
DROP PROCEDURE VMSCMS.MIGR_ROLL_CALL_DATA_SUMRY_REP;



DROP DIRECTORY DIR_ACCO;
DROP DIRECTORY DIR_CUST;
DROP DIRECTORY DIR_TRAN;
DROP DIRECTORY DIR_REP_ACCO;
DROP DIRECTORY DIR_REP_TRAN;
DROP DIRECTORY DIR_REP_CUST; 
DROP DIRECTORY DIR_REP_TRAN_ONLINE;
DROP DIRECTORY DIR_REP_CUST_ONLINE;
DROP DIRECTORY DIR_REP_ACCO_ONLINE;

	  
COMMIT;
SET ECHO OFF

SPOO OFF;


PROMPT      DROPPING OF MIGRATIOIN OBJECTS COMPLETED   