CREATE TABLE VMSCMS.CMS_TRANSACTION_TYPE
(
  CTT_INST_CODE      NUMBER(3),
  CTT_TRANTYPE_CODE  VARCHAR2(2 BYTE),
  CTT_TRANTYPE_DESC  VARCHAR2(50 BYTE),
  CTT_INS_USER       NUMBER(5),
  CTT_INS_DATE       DATE,
  CTT_LUPD_USER      NUMBER(5),
  CTT_LUPD_DATE      DATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


