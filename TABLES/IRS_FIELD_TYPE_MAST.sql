CREATE TABLE VMSCMS.IRS_FIELD_TYPE_MAST
(
  IFT_FIELD_TYPE  VARCHAR2(20 BYTE),
  IFT_INS_USER    NUMBER(5),
  IFT_INS_DATE    DATE,
  IFT_LUPD_USER   NUMBER(5),
  IFT_LUPD_DATE   DATE,
  IFT_INST_CODE   NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


