CREATE TABLE VMSCMS.FHM_FUNC_MAST
(
  FFM_FUNC_CODE  NUMBER(10),
  FFM_FUNC_DESC  VARCHAR2(100 BYTE),
  FFM_LUPD_DATE  DATE,
  FFM_INST_CODE  NUMBER(10),
  FFM_LUPD_USER  NUMBER(10),
  FFM_INS_DATE   DATE,
  FFM_INS_USER   NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


