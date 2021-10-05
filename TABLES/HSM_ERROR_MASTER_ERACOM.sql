CREATE TABLE VMSCMS.HSM_ERROR_MASTER_ERACOM
(
  HEM_HSM_NUMBER         NUMBER(5)              NOT NULL,
  HEM_COMMAND_CODE       VARCHAR2(2 BYTE)       NOT NULL,
  HEM_ERROR_NUMBER       VARCHAR2(2 BYTE)       NOT NULL,
  HEM_ERROR_CODE         VARCHAR2(15 BYTE),
  HEM_ERROR_DESCRIPTION  VARCHAR2(100 BYTE),
  HEM_USER_DESCRIPTION   VARCHAR2(100 BYTE),
  HEM_INS_DATE           DATE,
  HEM_LUPD_DATE          DATE,
  HEM_PROCESSBREAK_FLAG  CHAR(1 BYTE)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


