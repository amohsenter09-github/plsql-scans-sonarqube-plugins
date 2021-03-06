CREATE TABLE VMSCMS.CMS_REORDER_MAST
(
  CRM_BANK_NAME       VARCHAR2(100 BYTE),
  CRM_ACCT_NO         VARCHAR2(20 BYTE),
  CRM_PAN_CODE        VARCHAR2(90 BYTE),
  CRM_PROD_CODE       VARCHAR2(6 BYTE),
  CRM_PROD_DESC       VARCHAR2(35 BYTE),
  CRM_PROD_CATG       VARCHAR2(2 BYTE),
  CRM_REORDER_AMOUNT  NUMBER(15,6),
  CRM_LUPD_DATE       DATE,
  CRM_INST_CODE       NUMBER(10),
  CRM_LUPD_USER       NUMBER(10),
  CRM_INS_DATE        DATE,
  CRM_INS_USER        NUMBER(10),
  CRM_PAN_CODE_ENCR   RAW(100)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


