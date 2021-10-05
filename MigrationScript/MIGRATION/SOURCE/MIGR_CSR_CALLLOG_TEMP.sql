CREATE TABLE vmscms.MIGR_CSR_CALLLOG_TEMP
(
  MCC_RECORD_NUMB    NUMBER (20),
  MCC_PAN_CODE       VARCHAR2(19 BYTE),
  MCC_START_TIME     VARCHAR2(17 BYTE),
  MCC_CALL_TYPE      NUMBER(3),
  MCC_COMMENT        VARCHAR2(1000 BYTE),
  MCC_STATUS         VARCHAR2(1 BYTE),
  MCC_CALL_ENDTIME   VARCHAR2(17 BYTE),
  MCC_TRAN_CODE      VARCHAR2(1000 BYTE),
  MCC_RRN            VARCHAR2(15 BYTE),
  MCC_BUSINESS_DATE  VARCHAR2(2000 BYTE),
  MCC_BUSINESS_TIME  VARCHAR2(2000 BYTE),
  MCC_TRAN_COMMENTS  VARCHAR2(4000 BYTE),
  MCC_HASH_PAN       VARCHAR2(90 BYTE),
  MCC_MIGR_SEQNO     NUMBER(5),
  MCC_ROLL_FLAG      VARCHAR2(2 BYTE)           DEFAULT 'N',
  MCC_ERR_CODE       VARCHAR2(50 BYTE),
  MCC_PROC_FLAG      CHAR(1 BYTE)               DEFAULT 'N',
  MCC_FILE_NAME      VARCHAR2(50 BYTE),
  MCC_ERRMSG         VARCHAR2(500)
);


create index vmscms.migr_idx_calllog_temp 
on vmscms.MIGR_CSR_CALLLOG_TEMP(mcc_hash_pan,mcc_rrn); 