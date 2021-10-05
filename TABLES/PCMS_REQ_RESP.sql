CREATE TABLE VMSCMS.PCMS_REQ_RESP
(
  PRR_PRO_ID            VARCHAR2(4 BYTE),
  PRR_TAN_TYP           VARCHAR2(2 BYTE),
  PRR_PROD_CODE         VARCHAR2(2 BYTE),
  PRR_BRAN_NO           VARCHAR2(5 BYTE),
  PRR_REF_NO            VARCHAR2(25 BYTE),
  PRR_IN_UTR            VARCHAR2(16 BYTE),
  PRR_DR_ACCT           VARCHAR2(17 BYTE),
  PRR_CR_ACCT           VARCHAR2(17 BYTE),
  PRR_TRAN_AMT          VARCHAR2(14 BYTE),
  PRR_CURR_CODE         VARCHAR2(3 BYTE),
  PRR_STMT_NARR         VARCHAR2(50 BYTE),
  PRR_MSG_REF_NO        VARCHAR2(20 BYTE),
  PRR_GEN_UTR           VARCHAR2(16 BYTE),
  PRR_JRNL_NO           VARCHAR2(9 BYTE),
  PRR_TRAN_DAT          VARCHAR2(8 BYTE),
  PRR_STAT_CODE         VARCHAR2(2 BYTE),
  PRR_ERR_NO            VARCHAR2(4 BYTE),
  PRR_ERR_DESC          VARCHAR2(100 BYTE),
  PRR_MSG_RECON_REF_NO  VARCHAR2(20 BYTE),
  PRR_GEN_RECON_REF_NO  VARCHAR2(20 BYTE),
  PRR_REQ_RESP          CHAR(1 BYTE)            NOT NULL,
  PRR_REQ_FILE_NAME     VARCHAR2(30 BYTE),
  PRR_RESP_FILE_NAME    VARCHAR2(30 BYTE),
  PRR_LUPD_DATE         DATE,
  PRR_INST_CODE         NUMBER(10),
  PRR_LUPD_USER         NUMBER(10),
  PRR_INS_DATE          DATE,
  PRR_INS_USER          NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


