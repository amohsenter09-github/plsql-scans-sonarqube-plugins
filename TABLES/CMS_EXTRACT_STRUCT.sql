CREATE TABLE VMSCMS.CMS_EXTRACT_STRUCT
(
  CES_INST_CODE        NUMBER(3),
  CES_FIELD_NAME       VARCHAR2(40 BYTE),
  CES_FIELD_CAPTION    VARCHAR2(50 BYTE),
  CES_MAX_SIXE         NUMBER(30),
  CES_FROM_POSN        NUMBER(5),
  CES_TO_POSN          NUMBER(5),
  CES_INS_USER         NUMBER(5)                NOT NULL,
  CES_INS_DATE         DATE                     NOT NULL,
  CES_LUPD_USER        NUMBER(5)                NOT NULL,
  CES_LUPD_DATE        DATE                     NOT NULL,
  CES_SAMPLE_DATA      VARCHAR2(100 BYTE),
  CES_FIELD_VALIDATOR  NUMBER(2),
  CES_REC_TYPE         VARCHAR2(6 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


