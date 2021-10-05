CREATE TABLE VMSCMS.CMS_ACCT_TYPE
(
  CAT_INST_CODE    NUMBER(3)                    NOT NULL,
  CAT_TYPE_CODE    NUMBER(3)                    NOT NULL,
  CAT_TYPE_DESC    VARCHAR2(50 BYTE)            NOT NULL,
  CAT_SWITCH_TYPE  VARCHAR2(2 BYTE),
  CAT_INS_USER     NUMBER(5)                    NOT NULL,
  CAT_INS_DATE     DATE                         NOT NULL,
  CAT_LUPD_USER    NUMBER(5)                    NOT NULL,
  CAT_LUPD_DATE    DATE                         NOT NULL
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_ACCT_TYPE ADD (
  CONSTRAINT PK_ACCT_TYPE
 PRIMARY KEY
 (CAT_INST_CODE, CAT_TYPE_CODE))
/

ALTER TABLE VMSCMS.CMS_ACCT_TYPE ADD (
  CONSTRAINT FK_ACCTTYPE_USERMAST1 
 FOREIGN KEY (CAT_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_ACCTTYPE_USERMAST2 
 FOREIGN KEY (CAT_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_ACCTTYPE_INSTMAST 
 FOREIGN KEY (CAT_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE))
/

