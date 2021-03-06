CREATE TABLE VMSCMS.CMS_TRANS_DISP
(
  CTD_INST_CODE      NUMBER(3)                  NOT NULL,
  CTD_INTER_CODE     VARCHAR2(2 BYTE)           NOT NULL,
  CTD_DISP_CODE      NUMBER(2)                  NOT NULL,
  CTD_PAN_CODE       VARCHAR2(90 BYTE)          NOT NULL,
  CTD_MBR_NUMB       VARCHAR2(3 BYTE)           NOT NULL,
  CTD_AUTH_CODE      VARCHAR2(6 BYTE),
  CTD_ARN_CODE       VARCHAR2(23 BYTE),
  CTD_TRANS_AMT      NUMBER(15),
  CTD_DISP_AMT       NUMBER(15,6),
  CTD_DISP_DATE      DATE,
  CTD_DISP_STAT      VARCHAR2(1 BYTE),
  CTD_TRANS_DATE     DATE,
  CTD_ID_COL         NUMBER(14),
  CTD_REASON_CODE    VARCHAR2(2 BYTE),
  CTD_INS_USER       NUMBER(5)                  NOT NULL,
  CTD_INS_DATE       DATE                       NOT NULL,
  CTD_LUPD_USER      NUMBER(5)                  NOT NULL,
  CTD_LUPD_DATE      DATE                       NOT NULL,
  CTD_PAN_CODE_ENCR  RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_TRANS_DISP ADD (
  CONSTRAINT UK_TRANS_DISP
 UNIQUE (CTD_INST_CODE, CTD_DISP_CODE, CTD_ARN_CODE),
  CONSTRAINT UK_TRANS_DISP1
 UNIQUE (CTD_ID_COL, CTD_DISP_CODE))
/

