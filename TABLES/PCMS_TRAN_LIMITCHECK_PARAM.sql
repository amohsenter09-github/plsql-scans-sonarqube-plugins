CREATE TABLE VMSCMS.PCMS_TRAN_LIMITCHECK_PARAM
(
  PTLP_INST_CODE                NUMBER,
  PTLP_TRAN_CODE                VARCHAR2(2 BYTE),
  PTLP_TRAN_MODE                VARCHAR2(1 BYTE),
  PTLP_DELIVERY_CHANNEL         VARCHAR2(2 BYTE),
  PTLP_LIMICHECK_FLAG           VARCHAR2(1 BYTE),
  PTLP_ONLINELIMIT_ATMPOS_FLAG  VARCHAR2(1 BYTE),
  PTL_LUPD_DATE                 DATE,
  PTL_LUPD_USER                 NUMBER(10),
  PTL_INS_DATE                  DATE,
  PTL_INS_USER                  NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


