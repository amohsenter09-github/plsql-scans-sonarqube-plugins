PROMPT      GENERATING DATA MIGRATION REPORTS   

EXECUTE VMSCMS.MIGR_CUST_CARD_DATA_SUMRY_REP;
EXECUTE VMSCMS.MIGR_TRAN_DATA_SUMRY_REP;
EXECUTE VMSCMS.MIGR_DETAIL_EXCP_ACCT_REP;
EXECUTE VMSCMS.MIGR_CUST_EXCP_DETL_REP;
EXECUTE VMSCMS.MIGR_TRAN_DETL_EXCP_REP;
EXECUTE VMSCMS.MIGR_ACCT_SUCC_DETL_REP;
EXECUTE VMSCMS.MIGR_CUST_SUCC_DETL_REP;
EXECUTE VMSCMS.MIGR_TRAN_SUCCESS_DETAIL_REP;

EXECUTE VMSCMS.MIGR_CALL_DATA_SUMRY_REP;
EXECUTE VMSCMS.MIGR_CALL_EXCP_DETL_REP;
EXECUTE VMSCMS.MIGR_CALL_SUCC_DETL_REP;


PROMPT      DATA MIGRATION REPORTS GENERATION COMPLETED   

--@@CUST_DATA_SUMMARY_REP.sql;
--@@TRANSACTION_DATA_SUMMARY_REP.sql;
--@@DETAIL_EXCP_ACCT_REP.sql;
--@@DETAIL_EXCP_CUST_REP.sql;
--@@DETAIL_EXCP_TRAN_REP.sql;
--@@DETAIL_SUCCESS_ACCT_REP.sql;
--@@DETAIL_SUCCESS_CUST_REP.sql;
--@@DETAIL_SUCCESS_TRAN_REP.sql;


--@@MIGR_TRAN_DETL_EXCP_REP.prc;
--@@MIGR_CUST_CARD_DATA_SUMRY_REP.prc;
--@@MIGR_TRAN_DATA_SUMRY_REP.prc;
--@@MIGR_ACCT_SUCC_DETL_REP.prc;
--@@MIGR_CUST_SUCC_DETL_REP.prc;
--@@MIGR_CUST_EXCP_DETL_REP.prc;
--MIGR_TRAN_SUCCESS_DETAIL_REP.prc

--@@MIGR_DETAIL_EXCP_ACCT_REP.prc