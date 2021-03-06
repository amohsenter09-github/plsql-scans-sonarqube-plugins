CREATE TABLE VMSCMS.CMS_LOOKUP_MAST_RB11241
(
  CLM_INST_CODE    NUMBER(5),
  CLM_RECORD_TYPE  VARCHAR2(2 BYTE),
  CLM_FILE_NAME    VARCHAR2(2 BYTE),
  CLM_FIELD_NAME   VARCHAR2(100 BYTE),
  CLM_CODE_NAME    VARCHAR2(20 BYTE),
  CLM_CODE_DESC    VARCHAR2(200 BYTE),
  CLM_LUPD_DATE    DATE,
  CLM_LUPD_USER    NUMBER(10),
  CLM_INS_DATE     DATE,
  CLM_INS_USER     NUMBER(10),
  CLM_ACTIVE_FLAG  CHAR(1 BYTE)
)
TABLESPACE CMS_BKUP
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


