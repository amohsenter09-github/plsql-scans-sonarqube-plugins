CREATE TABLE VMSCMS.CMS_CUSTCARD_RULE
(
  CCR_MERC_CODE    VARCHAR2(4 BYTE),
  CCR_ACTIVE_STAT  VARCHAR2(1 BYTE),
  CCR_INS_USER     NUMBER,
  CCR_INS_DATE     DATE,
  CCR_LUPD_DATE    DATE,
  CCR_RULE_ID      NUMBER,
  CCR_TRANS_STAT   VARCHAR2(1 BYTE),
  CCR_INST_CODE    NUMBER(10),
  CCR_LUPD_USER    NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


