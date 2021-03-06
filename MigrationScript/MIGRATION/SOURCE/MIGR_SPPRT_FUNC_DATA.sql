CREATE TABLE VMSCMS.MIGR_SPPRT_FUNC_DATA
(
  MSF_FILE_NAME         VARCHAR2(50 BYTE),
  MSF_RECORD_NUMB       NUMBER(20),
  MSF_CARD_NUMBER       VARCHAR2(19 BYTE),
  MSF_NEW_CARD_NUMBER   VARCHAR2(19 BYTE),
  MSF_SPPRT_KEY         VARCHAR2(20 BYTE),
  MSF_SPPRT_RSNCDE      VARCHAR2(5 BYTE),
  MSF_REMARK            VARCHAR2(100 BYTE),
  MSF_PROCESSED_DATE    VARCHAR2(20 BYTE),
  MSF_DELIVERY_CHANNEL  VARCHAR2(2 BYTE),
  MSF_TRANSACTION_CODE  VARCHAR2(15 BYTE),
  MSF_PROC_MESG         VARCHAR2(500 BYTE),
  MSF_PROC_FLAG         CHAR(1 BYTE)            DEFAULT 'N',
  MSF_ERR_CODE          VARCHAR2(50 BYTE)
);