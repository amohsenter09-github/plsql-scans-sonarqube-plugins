CREATE TABLE VMSCMS.MIGR_TXNLOG_EXCP
(
  MTE_FILE_NAME         VARCHAR2(50 BYTE),
  MTE_RECORD_NUMBER     NUMBER(10),
  MTE_CARD_NO           VARCHAR2(20 BYTE),
  MTE_RRN               VARCHAR2(20 BYTE),
  MTE_BUSNESS_DATE      VARCHAR2(20 BYTE),
  MTE_BUSINESS_TIME     VARCHAR2(10 BYTE),
  MTE_TXN_CODE          VARCHAR2(10 BYTE),
  MTE_DELIVERY_CHANNEL  VARCHAR2(2 BYTE),
  MTE_AMOUNT            NUMBER(20),
  MTE_PROCESS_FLAG      VARCHAR2(1 BYTE),
  MTE_PROCESS_MSG       CLOB,
  MTE_INS_DATE          DATE
);