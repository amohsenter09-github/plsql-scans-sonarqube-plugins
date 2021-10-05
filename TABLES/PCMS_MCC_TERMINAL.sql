CREATE TABLE VMSCMS.PCMS_MCC_TERMINAL
(
  PMT_INST_CODE    NUMBER(3),
  PMT_MARC_ID      VARCHAR2(20 BYTE)            NOT NULL,
  PMT_TERMINAL_ID  VARCHAR2(20 BYTE)            NOT NULL,
  PMT_INS_USER     NUMBER(5),
  PMT_INS_DATE     DATE                         NOT NULL,
  PMT_LUPD_USER    NUMBER(5),
  PMT_LUPD_DATE    DATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.PCMS_MCC_TERMINAL ADD (
  CONSTRAINT PK_MCCID_TERMINALID
 PRIMARY KEY
 (PMT_MARC_ID, PMT_TERMINAL_ID))
/

ALTER TABLE VMSCMS.PCMS_MCC_TERMINAL ADD (
  CONSTRAINT FK_MCCTERMINAL_TERMINALID 
 FOREIGN KEY (PMT_TERMINAL_ID) 
 REFERENCES VMSCMS.PCMS_TERMINAL_MAST (PTM_TERMINAL_ID))
/
