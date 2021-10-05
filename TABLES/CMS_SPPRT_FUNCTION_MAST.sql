CREATE TABLE VMSCMS.CMS_SPPRT_FUNCTION_MAST
(
  DELIVERY_CHANNEL  VARCHAR2(2 BYTE),
  TXN_CODE          VARCHAR2(3 BYTE),
  FUNCTION_DESC     VARCHAR2(50 BYTE),
  STATUS            VARCHAR2(1 BYTE),
  INS_DATE          DATE,
  INS_USER          VARCHAR2(10 BYTE),
  LUPD_DATE         DATE,
  LUPD_USER         VARCHAR2(10 BYTE)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


