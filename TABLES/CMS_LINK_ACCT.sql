CREATE TABLE VMSCMS.CMS_LINK_ACCT
(
  CLA_PAN_CODE         VARCHAR2(90 BYTE),
  CLA_CARD_NAME        VARCHAR2(20 BYTE),
  CLA_PRIMARY_ACCT_NO  VARCHAR2(20 BYTE),
  CLA_NEW_ACCT_NO      VARCHAR2(20 BYTE),
  CLA_DONE_FLAG        VARCHAR2(1 BYTE),
  CLA_PROCESS_DATE     DATE,
  CLA_PROCESS_RESULT   VARCHAR2(100 BYTE),
  CLA_LUPD_USER        NUMBER(5),
  CLA_INST_CODE        NUMBER(10),
  CLA_INS_DATE         DATE,
  CLA_INS_USER         NUMBER(10),
  CLA_PAN_CODE_ENCR    RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


