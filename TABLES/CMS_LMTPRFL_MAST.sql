CREATE TABLE VMSCMS.CMS_LMTPRFL_MAST
(
  CLM_INST_CODE     NUMBER(10),
  CLM_LMTPRFL_ID    VARCHAR2(10 BYTE)           NOT NULL,
  CLM_LMTPRFL_NAME  VARCHAR2(50 BYTE)           NOT NULL,
  CLM_ACTIVE_FLAG   CHAR(1 BYTE)                NOT NULL,
  CLM_LUPD_DATE     DATE                        NOT NULL,
  CLM_LUPD_USER     NUMBER(10)                  NOT NULL,
  CLM_INS_DATE      DATE                        NOT NULL,
  CLM_INS_USER      NUMBER(10)                  NOT NULL
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_LMTPRFL_MAST ADD (
  CONSTRAINT PK_CMS_LMTPRFL_MAST
 PRIMARY KEY
 (CLM_INST_CODE, CLM_LMTPRFL_ID),
  CONSTRAINT UK_CMS_LMTPRFL_MAST
 UNIQUE (CLM_LMTPRFL_NAME))
/

