CREATE TABLE VMSCMS.CMS_PASSIVECARD_DETAILS
(
  CPD_INST_CODE       NUMBER(3),
  CPD_PAN_CODE        VARCHAR2(90 BYTE),
  CPD_PAN_CODE_ENCR   RAW(100),
  CPD_INS_USER        NUMBER(5),
  CPD_INS_DATE        DATE,
  CPD_LUPD_USER       NUMBER(5),
  CPD_LUPD_DATE       DATE,
  CPD_LAST_TRANDATE   VARCHAR2(8 BYTE),
  CPD_LAST_TRANTIME   VARCHAR2(8 BYTE),
  CPD_CURRTRAN_DATE   VARCHAR2(8 BYTE),
  CPD_CURRTRAN_TIME   VARCHAR2(8 BYTE),
  CPD_PASSIVE_PERIOD  NUMBER(5),
  CPD_PROCESS_FLAG    VARCHAR2(1 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


