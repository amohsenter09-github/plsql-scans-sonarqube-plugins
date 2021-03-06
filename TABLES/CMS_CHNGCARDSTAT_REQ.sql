CREATE TABLE VMSCMS.CMS_CHNGCARDSTAT_REQ
(
  CCR_INST_CODE      NUMBER(3)                  NOT NULL,
  CCR_DEL_CHNL       VARCHAR2(2 BYTE)           NOT NULL,
  CCR_TXN_CODE       VARCHAR2(2 BYTE)           NOT NULL,
  CCR_RRN            VARCHAR2(20 BYTE)          NOT NULL,
  CCR_PAN_CODE       VARCHAR2(90 BYTE)          NOT NULL,
  CCR_PAN_CODE_ENCR  RAW(100)                   NOT NULL,
  CCR_MBR_NUMB       VARCHAR2(3 BYTE)           NOT NULL,
  CCR_ACCT_NO        VARCHAR2(20 BYTE)          NOT NULL,
  CCR_BUSINESS_DATE  VARCHAR2(8 BYTE)           NOT NULL,
  CCR_BUSINESS_TIME  VARCHAR2(10 BYTE)          NOT NULL,
  CCR_REASON_CODE    NUMBER(3),
  CCR_REMARK         VARCHAR2(800 BYTE),
  CCR_REQ_CALLID     NUMBER(27),
  CCR_IP_ADDR        VARCHAR2(15 BYTE),
  CCR_PROCESS_DATE   DATE                       NOT NULL,
  CCR_STATUS         VARCHAR2(1 BYTE)           DEFAULT 'N'                   NOT NULL,
  CCR_EMAIL_STATUS   VARCHAR2(1 BYTE)           DEFAULT 'N'                   NOT NULL,
  CCR_INS_DATE       DATE                       NOT NULL,
  CCR_INS_USER       NUMBER(5)                  NOT NULL,
  CCR_LUPD_DATE      DATE                       NOT NULL,
  CCR_LUPD_USER      NUMBER(5)                  NOT NULL,
  CCR_PROCESS_MSG    VARCHAR2(1000 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_CHNGCARDSTAT_REQ ADD (
  CONSTRAINT PK_CHNGCRDSTAT_REQ
 PRIMARY KEY
 (CCR_INST_CODE, CCR_RRN, CCR_PAN_CODE, CCR_BUSINESS_DATE, CCR_BUSINESS_TIME))
/

