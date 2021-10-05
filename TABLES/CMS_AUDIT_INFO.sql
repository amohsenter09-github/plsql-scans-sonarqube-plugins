CREATE TABLE VMSCMS.CMS_AUDIT_INFO
(
  CAI_MODULE_NAME  NUMBER(5),
  CAI_FIELD_NAME   VARCHAR2(60 BYTE),
  CAI_OLD_VAL      VARCHAR2(100 BYTE),
  CAI_NEW_VAL      VARCHAR2(100 BYTE),
  CAI_ACTION_USER  VARCHAR2(10 BYTE),
  CAI_ACTION_TYP   VARCHAR2(20 BYTE),
  CAI_INS_DATE     DATE,
  SEQ              NUMBER,
  CAI_INST_CODE    NUMBER(3)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


