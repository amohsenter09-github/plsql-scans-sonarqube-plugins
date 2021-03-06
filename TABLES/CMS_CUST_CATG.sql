CREATE TABLE VMSCMS.CMS_CUST_CATG
(
  CCC_INST_CODE   NUMBER(3)                     NOT NULL,
  CCC_CATG_CODE   NUMBER(5)                     NOT NULL,
  CCC_CATG_SNAME  VARCHAR2(5 BYTE),
  CCC_CATG_DESC   VARCHAR2(25 BYTE)             NOT NULL,
  CCC_INS_USER    NUMBER(5)                     NOT NULL,
  CCC_INS_DATE    DATE                          NOT NULL,
  CCC_LUPD_USER   NUMBER(5)                     NOT NULL,
  CCC_LUPD_DATE   DATE                          NOT NULL
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_CUST_CATG ADD (
  CONSTRAINT PK_CUST_CATG
 PRIMARY KEY
 (CCC_INST_CODE, CCC_CATG_CODE),
  CONSTRAINT UK_CUST_CATG
 UNIQUE (CCC_INST_CODE, CCC_CATG_SNAME))
/

ALTER TABLE VMSCMS.CMS_CUST_CATG ADD (
  CONSTRAINT FK_CUSTCATG_USERMAST2 
 FOREIGN KEY (CCC_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CUSTCATG_USERMAST1 
 FOREIGN KEY (CCC_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CUSTCATG_INSTMAST 
 FOREIGN KEY (CCC_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE))
/

