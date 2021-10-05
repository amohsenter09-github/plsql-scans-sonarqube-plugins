CREATE TABLE VMSCMS.CMS_DUP_ACCT_NO
(
  CAP_ACCT_ID       NUMBER(10)                  NOT NULL,
  CAP_ACCT_NO       VARCHAR2(20 BYTE),
  CDA_PROCESS_FLAG  VARCHAR2(1 BYTE)            DEFAULT 'N',
  CDA_PROCESS_MSG   VARCHAR2(300 BYTE),
  CDA_INS_DATE      DATE                        DEFAULT SYSDATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

