CREATE TABLE VMSCMS.CMS_GEN_TEMP
(
  CGT_PRIM_KEY   NUMBER,
  CGT_CTRL_KEY   VARCHAR2(20 BYTE),
  CGT_NUMB_VAL   NUMBER,
  CGT_CHAR_VAL   VARCHAR2(200 BYTE),
  CGT_LUPD_DATE  DATE,
  CGT_INST_CODE  NUMBER(10),
  CGT_LUPD_USER  NUMBER(10),
  CGT_INS_DATE   DATE,
  CGT_INS_USER   NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


