CREATE TABLE VMSCMS.CMS_PAY_TRANSFER
(
  CPT_TRANSFER_NO         NUMBER(10),
  CPT_PAYER_NO            VARCHAR2(20 BYTE),
  CPT_PAYEE_NO            VARCHAR2(20 BYTE),
  CPT_TRANSFER_AMT        NUMBER(20,3),
  CPT_TRANSFER_DATE       DATE,
  CPT_TRANSFER_NARRATION  VARCHAR2(50 BYTE),
  CPT_LUPD_DATE           DATE,
  CPT_INST_CODE           NUMBER(10),
  CPT_LUPD_USER           NUMBER(10),
  CPT_INS_DATE            DATE,
  CPT_INS_USER            NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_PAY_TRANSFER ADD (
  CONSTRAINT PK_TRN_NO
 PRIMARY KEY
 (CPT_TRANSFER_NO))
/

