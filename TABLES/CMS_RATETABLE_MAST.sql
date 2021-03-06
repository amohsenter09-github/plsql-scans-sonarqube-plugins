CREATE TABLE VMSCMS.CMS_RATETABLE_MAST
(
  CRM_INST_CODE         NUMBER(5)               NOT NULL,
  CRM_RATETABLE_ID      NUMBER(18)              NOT NULL,
  CRM_RATETABLE_NAME    VARCHAR2(100 BYTE),
  CRM_RATETABLE_DESCRP  VARCHAR2(1000 BYTE),
  CRM_LAST_USER         NUMBER(10),
  CRM_LAST_DATE         DATE,
  CRM_DEFAULT_FLAG      VARCHAR2(1 BYTE),
  CRM_LUPD_DATE         DATE,
  CRM_LUPD_USER         NUMBER(10),
  CRM_INS_DATE          DATE,
  CRM_INS_USER          NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_RATETABLE_MAST ADD (
  CONSTRAINT PK_RATETABLE_MAST1
 PRIMARY KEY
 (CRM_INST_CODE, CRM_RATETABLE_ID))
/

