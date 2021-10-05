CREATE TABLE VMSCMS.PCMS_CARD_EXCP_RULEGROUP
(
  PCER_INST_CODE      NUMBER(3)                 NOT NULL,
  PCER_RULEGROUP_ID   VARCHAR2(4 BYTE)          NOT NULL,
  PCER_PAN_CODE       VARCHAR2(90 BYTE)         NOT NULL,
  PCER_MBR_NUMB       VARCHAR2(3 BYTE)          NOT NULL,
  PCER_VALID_FROM     DATE                      NOT NULL,
  PCER_VALID_TO       DATE                      NOT NULL,
  PCER_FLOW_SOURCE    VARCHAR2(3 BYTE)          NOT NULL,
  PCER_INS_USER       NUMBER(5)                 NOT NULL,
  PCER_INS_DATE       DATE                      NOT NULL,
  PCER_LUPD_USER      NUMBER(5)                 NOT NULL,
  PCER_LUPD_DATE      DATE                      NOT NULL,
  PCER_DELETE_FLG     VARCHAR2(3 BYTE),
  PCER_PAN_CODE_ENCR  RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.PCMS_CARD_EXCP_RULEGROUP ADD (
  CONSTRAINT FK_PCMS_CARD_EXCP_RULEGROUP 
 FOREIGN KEY (PCER_RULEGROUP_ID) 
 REFERENCES VMSCMS.RULEGROUPING (RULEGROUPID))
/

