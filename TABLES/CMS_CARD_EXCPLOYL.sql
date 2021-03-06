CREATE TABLE VMSCMS.CMS_CARD_EXCPLOYL
(
  CCE_INST_CODE      NUMBER(3)                  NOT NULL,
  CCE_LOYL_CODE      NUMBER(3)                  NOT NULL,
  CCE_PAN_CODE       VARCHAR2(90 BYTE)          NOT NULL,
  CCE_MBR_NUMB       VARCHAR2(3 BYTE)           NOT NULL,
  CCE_VALID_FROM     DATE                       NOT NULL,
  CCE_VALID_TO       DATE                       NOT NULL,
  CCE_FLOW_SOURCE    VARCHAR2(3 BYTE)           NOT NULL,
  CCE_INS_USER       NUMBER(5)                  NOT NULL,
  CCE_INS_DATE       DATE                       NOT NULL,
  CCE_LUPD_USER      NUMBER(5)                  NOT NULL,
  CCE_LUPD_DATE      DATE                       NOT NULL,
  CCE_PAN_CODE_ENCR  RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_CARD_EXCPLOYL ADD (
  CONSTRAINT FK_CARDEXCPLOYL_LOYLMAST 
 FOREIGN KEY (CCE_INST_CODE, CCE_LOYL_CODE) 
 REFERENCES VMSCMS.CMS_LOYL_MAST (CLM_INST_CODE,CLM_LOYL_CODE),
  CONSTRAINT FK_CARDEXCPLOYL_USERMAST1 
 FOREIGN KEY (CCE_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CARDEXCPLOYL_USERMAST2 
 FOREIGN KEY (CCE_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CARDEXCPLOYL_APPLPAN 
 FOREIGN KEY (CCE_PAN_CODE, CCE_MBR_NUMB) 
 REFERENCES VMSCMS.CMS_APPL_PAN (CAP_PAN_CODE,CAP_MBR_NUMB))
/

