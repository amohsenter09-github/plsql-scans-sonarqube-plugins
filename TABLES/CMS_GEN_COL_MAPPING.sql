CREATE TABLE VMSCMS.CMS_GEN_COL_MAPPING
(
  CGM_INST_CODE          NUMBER(5),
  CGM_TABLE_NAME         VARCHAR2(30 BYTE),
  CGM_COLUMN_NAME        VARCHAR2(30 BYTE),
  CGM_COLUMN_DATA        VARCHAR2(90 BYTE),
  CGM_COLUMN_DATATYPE    VARCHAR2(30 BYTE),
  CGM_COLUMN_DATAFORMAT  VARCHAR2(30 BYTE),
  CGM_INS_USER           NUMBER(5),
  CGM_INS_DATE           DATE,
  CGM_LUPD_USER          NUMBER(5),
  CGM_LUPD_DATE          DATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_GEN_COL_MAPPING ADD (
  CONSTRAINT PK_GEN_COL
 PRIMARY KEY
 (CGM_INST_CODE, CGM_TABLE_NAME, CGM_COLUMN_NAME))
/

