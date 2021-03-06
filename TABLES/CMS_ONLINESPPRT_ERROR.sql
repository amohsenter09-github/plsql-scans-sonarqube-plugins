CREATE TABLE VMSCMS.CMS_ONLINESPPRT_ERROR
(
  COE_INST_CODE      NUMBER                     NOT NULL,
  COE_PAN_CODE       VARCHAR2(90 BYTE)          NOT NULL,
  COE_MBR_NUMB       VARCHAR2(3 BYTE)           NOT NULL,
  COE_SPPRT_KEY      VARCHAR2(6 BYTE),
  COE_SPPRT_RSNCODE  NUMBER                     NOT NULL,
  COE_SPPRT_REMARK   VARCHAR2(100 BYTE),
  COE_ERROR_DESC     VARCHAR2(500 BYTE),
  COE_INS_USER       NUMBER                     NOT NULL,
  COE_INS_DATE       DATE                       NOT NULL,
  COE_CMD_MODE       NUMBER,
  COE_LUPD_DATE      DATE,
  COE_LUPD_USER      NUMBER(10),
  COE_PAN_CODE_ENCR  RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


