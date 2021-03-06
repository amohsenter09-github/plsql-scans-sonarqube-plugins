CREATE TABLE VMSCMS.CMS_BATCH_PIN
(
  CBP_PAN_CODE       VARCHAR2(90 BYTE),
  CBP_FILE_NAME      VARCHAR2(30 BYTE),
  CBP_PIN_REGEN      VARCHAR2(1 BYTE)           DEFAULT 'N',
  CBP_FUNC_REMARK    VARCHAR2(100 BYTE)         DEFAULT 'Batch Regeneration of PIN',
  CBP_RESULT         VARCHAR2(500 BYTE)         DEFAULT 'NOT PROCESSED',
  CBP_MBR_NUMB       VARCHAR2(3 BYTE)           DEFAULT '000',
  CBP_INS_DATE       DATE,
  CBP_LUPD_DATE      DATE,
  CBP_INST_CODE      NUMBER(10),
  CBP_LUPD_USER      NUMBER(10),
  CBP_INS_USER       NUMBER(10),
  CBP_PAN_CODE_ENCR  RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_BATCH_PIN ADD (
  CONSTRAINT PK_BATCH_PIN
 PRIMARY KEY
 (CBP_FILE_NAME, CBP_PAN_CODE))
/

