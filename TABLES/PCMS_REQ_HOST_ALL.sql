CREATE TABLE VMSCMS.PCMS_REQ_HOST_ALL
(
  PRH_REQ_ID          NUMBER(20),
  PRH_PRO_ID          VARCHAR2(4 BYTE),
  PRH_TAN_TYP         VARCHAR2(2 BYTE),
  PRH_BRAN_NO         VARCHAR2(5 BYTE),
  PRH_REF_NO          VARCHAR2(25 BYTE),
  PRH_DR_ACCT         VARCHAR2(17 BYTE),
  PRH_CR_ACCT         VARCHAR2(17 BYTE),
  PRH_TRAN_AMT        VARCHAR2(14 BYTE),
  PRH_CURR_CODE       VARCHAR2(3 BYTE),
  PRH_STMT_NARR       VARCHAR2(50 BYTE),
  PRH_MSG_REC_REF_NO  VARCHAR2(20 BYTE),
  PRH_FILE_GEN        VARCHAR2(1 BYTE),
  PRH_SENT_COUNT      NUMBER(2),
  PRH_FILE_NAME       VARCHAR2(30 BYTE),
  PRH_SOURCE_TYPE     VARCHAR2(2 BYTE),
  PRH_APPL_CODE       NUMBER(14),
  PRH_INS_USER        NUMBER(5),
  PRH_INS_DATE        DATE,
  PRH_LUPD_USER       NUMBER(5),
  PRH_LUPD_DATE       DATE,
  PRH_RESP_ID         NUMBER(20),
  PRH_PROCESS_FLAG    VARCHAR2(1 BYTE),
  PRH_INST_CODE       NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


