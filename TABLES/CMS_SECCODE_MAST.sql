CREATE TABLE VMSCMS.CMS_SECCODE_MAST
(
  CSM_INST_CODE  NUMBER(5),
  CSM_SEC_CODE   VARCHAR2(3 BYTE),
  CSM_INS_DATE   DATE,
  CSM_INS_USER   NUMBER(5),
  CSM_LUPD_DATE  DATE,
  CSM_LUPD_USER  NUMBER(5)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


