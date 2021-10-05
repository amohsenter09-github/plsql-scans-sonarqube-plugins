CREATE TABLE VMSCMS.CMS_AUTH_PROCESS
(
  CAP_INST_CODE      NUMBER(3),
  CAP_PROCESS_KEY    VARCHAR2(20 BYTE),
  CAP_CLASS_PROCESS  VARCHAR2(100 BYTE),
  CAP_INS_DATE       DATE
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


