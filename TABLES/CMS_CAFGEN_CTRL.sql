CREATE TABLE VMSCMS.CMS_CAFGEN_CTRL
(
  CCC_INST_CODE    NUMBER(3)                    NOT NULL,
  CCC_CAFGEN_DATE  DATE                         NOT NULL,
  CCC_CAF_FNAME    VARCHAR2(12 BYTE)            NOT NULL,
  CCC_INS_USER     NUMBER(5)                    NOT NULL,
  CCC_INS_DATE     DATE                         NOT NULL,
  CCC_LUPD_USER    NUMBER(5)                    NOT NULL,
  CCC_LUPD_DATE    DATE                         NOT NULL
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_CAFGEN_CTRL ADD (
  CONSTRAINT PK_CAFGEN_CTRL
 PRIMARY KEY
 (CCC_INST_CODE, CCC_CAFGEN_DATE, CCC_CAF_FNAME))
/

ALTER TABLE VMSCMS.CMS_CAFGEN_CTRL ADD (
  CONSTRAINT FK_CAFGENCTRL_INSTMAST 
 FOREIGN KEY (CCC_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE),
  CONSTRAINT FK_CAFGENCTRL_USERMAST1 
 FOREIGN KEY (CCC_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CAFGENCTRL_USERMAST2 
 FOREIGN KEY (CCC_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN))
/

