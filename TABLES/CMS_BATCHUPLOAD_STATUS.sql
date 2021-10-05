CREATE TABLE VMSCMS.CMS_BATCHUPLOAD_STATUS
(
  CBS_INST_CODE    NUMBER(3),
  CBS_STATUS_CODE  NUMBER(3),
  CBS_STATUS_DESC  VARCHAR2(100 BYTE),
  CBS_INS_USER     NUMBER(5),
  CBS_INS_DATE     DATE,
  CBS_LUPD_USER    NUMBER(5),
  CBS_LUPD_DATE    DATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


