CREATE TABLE VMSCMS.CMS_ACCTCLOSE_DETAIL
(
  CRD_INST_CODE     NUMBER(3),
  CRD_ACCT_NO       VARCHAR2(20 BYTE),
  CRD_FILE_NAME     VARCHAR2(30 BYTE),
  CRD_REMARKS       VARCHAR2(100 BYTE),
  CRD_MSG24_FLAG    CHAR(1 BYTE)                DEFAULT 'N',
  CRD_PROCESS_FLAG  VARCHAR2(1 BYTE),
  CRD_PROCESS_MSG   VARCHAR2(300 BYTE),
  CRD_PROCESS_MODE  VARCHAR2(1 BYTE),
  CRD_INS_USER      NUMBER(5),
  CRD_INS_DATE      DATE,
  CRD_LUPD_USER     NUMBER(5),
  CRD_LUPD_DATE     DATE,
  CRD_SINK_ACCTNO   NUMBER(11),
  CRD_SINK_BANK     VARCHAR2(30 BYTE),
  CRD_SINK_BRANCH   VARCHAR2(30 BYTE),
  CRD_SINK_IFCS     VARCHAR2(15 BYTE),
  CRD_CLOSE_AMOUNT  VARCHAR2(12 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


