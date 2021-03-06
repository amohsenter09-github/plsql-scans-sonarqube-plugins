CREATE TABLE VMSCMS.CMS_EMBOSS_FILE_STATUS
(
  CFS_BATCH_ID      NUMBER,
  CFS_FILE_NAME     VARCHAR2(25 BYTE),
  CFS_FILE_PATH     VARCHAR2(100 BYTE),
  CFS_RECORD_COUNT  NUMBER,
  CFS_FILE_STATUS   NUMBER,
  CFS_INS_USER      NUMBER(5),
  CFS_INS_DATE      DATE,
  CFS_LUPD_USER     NUMBER(5),
  CFS_LUPD_DATE     DATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_EMBOSS_FILE_STATUS ADD (
  CONSTRAINT F_EBS_BATCH_ID 
 FOREIGN KEY (CFS_BATCH_ID) 
 REFERENCES VMSCMS.CMS_EMBOSS_BATCH_STATUS (EBS_BATCH_ID))
/

