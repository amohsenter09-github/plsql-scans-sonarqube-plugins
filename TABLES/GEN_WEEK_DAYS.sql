CREATE TABLE VMSCMS.GEN_WEEK_DAYS
(
  GWD_DAY_SEQ    NUMBER(1),
  GWD_DAY_NAME   VARCHAR2(9 BYTE),
  GWD_DAY_SNAME  VARCHAR2(5 BYTE),
  GWD_LUPD_DATE  DATE,
  GWD_INST_CODE  NUMBER(10),
  GWD_LUPD_USER  NUMBER(10),
  GWD_INS_DATE   DATE,
  GWD_INS_USER   NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


