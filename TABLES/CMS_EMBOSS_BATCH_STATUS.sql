CREATE TABLE VMSCMS.CMS_EMBOSS_BATCH_STATUS
(
  EBS_BATCH_ID           NUMBER,
  EBS_TOTAL_RECORDS      NUMBER,
  EBS_START_TIME         DATE,
  EBS_END_TIME           DATE,
  EBS_INS_USER           NUMBER(5),
  EBS_INS_DATE           DATE,
  EBS_LUPD_USER          NUMBER(5),
  EBS_LUPD_DATE          DATE,
  EBS_PROCESSED_RECORDS  NUMBER,
  EBS_BATCH_STATUS       NUMBER(2)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_EMBOSS_BATCH_STATUS ADD (
  CONSTRAINT P_BATCH_ID
 PRIMARY KEY
 (EBS_BATCH_ID))
/

