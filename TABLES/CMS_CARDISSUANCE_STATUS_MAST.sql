CREATE TABLE VMSCMS.CMS_CARDISSUANCE_STATUS_MAST
(
  CCM_INST_CODE    NUMBER(3),
  CCM_STATUS_CODE  VARCHAR2(2 BYTE),
  CCM_STATUS_DESC  VARCHAR2(90 BYTE),
  CCM_INS_USER     NUMBER(5),
  CCM_INS_DATE     DATE,
  CCM_LUPD_USER    NUMBER(5),
  CCM_LUPD_DATE    DATE
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_CARDISSUANCE_STATUS_MAST ADD (
  CONSTRAINT PK_CARDSTATUS_MAST
 PRIMARY KEY
 (CCM_STATUS_CODE))
/

