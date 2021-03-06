CREATE TABLE VMSCMS.CMS_FEEERROR_LOG
(
  CFL_INST_CODE      NUMBER(3),
  CFL_PAN_CODE       VARCHAR2(90 BYTE),
  CFL_MBR_NUMB       VARCHAR2(3 BYTE),
  CFL_ACTIVE_DATE    DATE,
  CFL_PROD_CODE      VARCHAR2(6 BYTE),
  CFL_CARD_TYPE      NUMBER(2),
  CFL_CUST_CATG      NUMBER(2),
  CFL_ACCT_ID        NUMBER(10),
  CFL_ACCT_NO        VARCHAR2(20 BYTE),
  CFL_ERROR_MESG     VARCHAR2(500 BYTE),
  CFL_RUN_USER       NUMBER(5),
  CFL_RUN_DATE       DATE,
  CFL_PROCESS_ID     NUMBER(10),
  CFL_FREQ_KEY       VARCHAR2(2 BYTE),
  CFL_LUPD_DATE      DATE,
  CFL_LUPD_USER      NUMBER(10),
  CFL_INS_DATE       DATE,
  CFL_INS_USER       NUMBER(10),
  CFL_PAN_CODE_ENCR  RAW(100)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


