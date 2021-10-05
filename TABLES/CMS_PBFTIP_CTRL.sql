CREATE TABLE VMSCMS.CMS_PBFTIP_CTRL
(
  CPC_INST_CODE    NUMBER(3)                    NOT NULL,
  CPC_PBFGEN_DATE  DATE                         NOT NULL,
  CPC_PBF_FNAME    VARCHAR2(20 BYTE)            NOT NULL,
  CPC_TOT_REC      NUMBER(6),
  CPC_INS_USER     NUMBER(5)                    NOT NULL,
  CPC_INS_DATE     DATE                         NOT NULL
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


