CREATE TABLE VMSCMS.CMS_TTUM_FAILED_TEMP
(
  CTF_INST_CODE    NUMBER(3),
  CTF_FILE_NAME    VARCHAR2(18 BYTE),
  CTF_ROW_ID       VARCHAR2(10 BYTE),
  CTF_PARTI_CULAR  VARCHAR2(100 BYTE),
  CTF_TRANS_AMT    VARCHAR2(15 BYTE),
  CTF_ACCT_NO      VARCHAR2(16 BYTE),
  CTF_STATUS       CHAR(1 BYTE),
  CTF_INS_USER     NUMBER(5),
  CTF_INS_DATE     DATE,
  CTF_LUPD_USER    NUMBER(5),
  CTF_LUPD_DATE    DATE,
  CTF_FEE_TRANS    NUMBER(13)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


