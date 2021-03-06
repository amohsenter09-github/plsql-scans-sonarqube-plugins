CREATE TABLE VMSCMS.CMS_INST_TYPE
(
  CIT_TYPE_CODE  NUMBER(3)                      NOT NULL,
  CIT_TYPE_DESC  VARCHAR2(50 BYTE)              NOT NULL,
  CIT_INS_USER   NUMBER(5)                      NOT NULL,
  CIT_INS_DATE   DATE                           NOT NULL,
  CIT_LUPD_USER  NUMBER(5)                      NOT NULL,
  CIT_LUPD_DATE  DATE                           NOT NULL,
  CIT_INST_CODE  NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_INST_TYPE ADD (
  CONSTRAINT PK_INST_TYPE
 PRIMARY KEY
 (CIT_INST_CODE, CIT_TYPE_CODE))
/

ALTER TABLE VMSCMS.CMS_INST_TYPE ADD (
  CONSTRAINT FK_INSTTYPE_USERMAST2 
 FOREIGN KEY (CIT_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_INSTTYPE_USERMAST1 
 FOREIGN KEY (CIT_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN))
/

