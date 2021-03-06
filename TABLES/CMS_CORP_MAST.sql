CREATE TABLE VMSCMS.CMS_CORP_MAST
(
  CCM_INST_CODE   NUMBER(3)                     NOT NULL,
  CCM_CORP_CODE   NUMBER(3)                     NOT NULL,
  CCM_CORP_NAME   VARCHAR2(50 BYTE)             NOT NULL,
  CCM_CORP_STAT   CHAR(1 BYTE)                  NOT NULL,
  CCM_ADDR_ONE    VARCHAR2(50 BYTE)             NOT NULL,
  CCM_ADDR_TWO    VARCHAR2(50 BYTE),
  CCM_ADDR_THREE  VARCHAR2(50 BYTE),
  CCM_PIN_CODE    NUMBER(6)                     NOT NULL,
  CCM_STATE_CODE  NUMBER(3)                     NOT NULL,
  CCM_CNTRY_CODE  NUMBER(3)                     NOT NULL,
  CCM_PHON_ONE    NUMBER(10)                    NOT NULL,
  CCM_PHON_TWO    NUMBER(10),
  CCM_PHON_THREE  NUMBER(10),
  CCM_CONT_PRSN   VARCHAR2(50 BYTE)             NOT NULL,
  CCM_FAX_NO      NUMBER(10),
  CCM_EMAIL_ID    VARCHAR2(50 BYTE),
  CCM_INS_USER    NUMBER(5)                     NOT NULL,
  CCM_INS_DATE    DATE                          NOT NULL,
  CCM_LUPD_USER   NUMBER(5)                     NOT NULL,
  CCM_LUPD_DATE   DATE                          NOT NULL
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_CORP_MAST ADD (
  CONSTRAINT PK_CORP_MAST
 PRIMARY KEY
 (CCM_INST_CODE, CCM_CORP_CODE))
/

ALTER TABLE VMSCMS.CMS_CORP_MAST ADD (
  CONSTRAINT FK_CORPMAST_INSTMAST 
 FOREIGN KEY (CCM_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE),
  CONSTRAINT FK_CORPMAST_USERMAST1 
 FOREIGN KEY (CCM_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CORPMAST_USERMAST2 
 FOREIGN KEY (CCM_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN))
/

