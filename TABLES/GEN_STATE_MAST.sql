CREATE TABLE VMSCMS.GEN_STATE_MAST
(
  GSM_CNTRY_CODE         NUMBER(3)              NOT NULL,
  GSM_STATE_CODE         NUMBER(3)              NOT NULL,
  GSM_STATE_NAME         VARCHAR2(50 BYTE)      NOT NULL,
  GSM_LUPD_USER          NUMBER(5)              NOT NULL,
  GSM_LUPD_DATE          DATE                   NOT NULL,
  GSM_INST_CODE          NUMBER(10),
  GSM_INS_DATE           DATE,
  GSM_INS_USER           NUMBER(10),
  GSM_SWITCH_STATE_CODE  VARCHAR2(3 BYTE)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.GEN_STATE_MAST ADD (
  CONSTRAINT PK_STATE_MAST
 PRIMARY KEY
 (GSM_INST_CODE, GSM_CNTRY_CODE, GSM_STATE_CODE),
  CONSTRAINT UK_SWITCH_CODE
 UNIQUE (GSM_INST_CODE, GSM_CNTRY_CODE, GSM_SWITCH_STATE_CODE))
/

ALTER TABLE VMSCMS.GEN_STATE_MAST ADD (
  CONSTRAINT FK_STATEMAST_CNTRYMAST 
 FOREIGN KEY (GSM_INST_CODE, GSM_CNTRY_CODE) 
 REFERENCES VMSCMS.GEN_CNTRY_MAST (GCM_INST_CODE,GCM_CNTRY_CODE),
  CONSTRAINT FK_STATEMAST_USERMAST 
 FOREIGN KEY (GSM_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN))
/

