CREATE TABLE VMSCMS.CMS_ERRMSG_KEY
(
  CEK_ERROR_CODE  VARCHAR2(25 BYTE),
  CEK_ERROR_KEY   VARCHAR2(100 BYTE),
  CEK_LUPD_DATE   DATE,
  CEK_INST_CODE   NUMBER(10),
  CEK_LUPD_USER   NUMBER(10),
  CEK_INS_DATE    DATE,
  CEK_INS_USER    NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


