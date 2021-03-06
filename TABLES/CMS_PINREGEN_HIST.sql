CREATE TABLE VMSCMS.CMS_PINREGEN_HIST
(
  CPH_INST_CODE      NUMBER(3)                  NOT NULL,
  CPH_PAN_CODE       VARCHAR2(90 BYTE),
  CPH_MBR_NUMB       VARCHAR2(3 BYTE),
  CPH_OLD_PINOFST    VARCHAR2(10 BYTE),
  CPH_OLD_PINDATE    DATE,
  CPH_REGEN_CNT      NUMBER(5),
  CPH_NEW_PINDATE    DATE,
  CPH_INS_USER       NUMBER(5)                  NOT NULL,
  CPH_INS_DATE       DATE                       NOT NULL,
  CPH_LUPD_USER      NUMBER(5)                  NOT NULL,
  CPH_LUPD_DATE      DATE                       NOT NULL,
  CPH_PAN_CODE_ENCR  RAW(100)
)
TABLESPACE CMS_HIST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_PINREGEN_HIST ADD (
  CONSTRAINT FK_PINREGEN_USERMAST1 
 FOREIGN KEY (CPH_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_PINREGEN_USERMAST2 
 FOREIGN KEY (CPH_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_PINREGEN_APPLPAN 
 FOREIGN KEY (CPH_PAN_CODE, CPH_MBR_NUMB) 
 REFERENCES VMSCMS.CMS_APPL_PAN (CAP_PAN_CODE,CAP_MBR_NUMB),
  CONSTRAINT FK_PINREGEN_INSTMAST 
 FOREIGN KEY (CPH_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE))
/

