CREATE TABLE VMSCMS.CMS_MARQUEE_MSG
(
  CMM_MSG_ID     NUMBER,
  CMM_MSG_DESC   VARCHAR2(200 BYTE),
  CMM_LUPD_DATE  DATE,
  CMM_INST_CODE  NUMBER(10),
  CMM_LUPD_USER  NUMBER(10),
  CMM_INS_DATE   DATE,
  CMM_INS_USER   NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


