CREATE TABLE VMSCMS.PREPAID_TABLE_TABLESPACE
(
  PTT_TABLE_NAME       VARCHAR2(50 BYTE),
  PTT_TABLESPACE_NAME  VARCHAR2(25 BYTE),
  PTT_INST_CODE        NUMBER(10),
  PTT_INS_DATE         DATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


