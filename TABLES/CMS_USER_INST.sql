CREATE TABLE VMSCMS.CMS_USER_INST
(
  CUI_INST_CODE  NUMBER(5),
  CUI_USER_CODE  NUMBER(8),
  CUI_DFLT_INST  NUMBER(1)                      NOT NULL,
  CUI_USIN_STUS  NUMBER(1)                      NOT NULL,
  CUI_INS_USER   NUMBER(8)                      NOT NULL,
  CUI_INS_DATE   DATE                           NOT NULL,
  CUI_LUPD_USER  NUMBER(8),
  CUI_LUPD_DATE  DATE
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_USER_INST ADD (
  CONSTRAINT PK_CUI_INST_USER_CODE
 PRIMARY KEY
 (CUI_INST_CODE, CUI_USER_CODE))
/

ALTER TABLE VMSCMS.CMS_USER_INST ADD (
  CONSTRAINT FK_CUI_USER_CUM_USID 
 FOREIGN KEY (CUI_USER_CODE) 
 REFERENCES VMSCMS.CMS_USERDETL_MAST (CUM_USER_CODE),
  CONSTRAINT FK_CUI_INS_CUM_USID 
 FOREIGN KEY (CUI_INS_USER) 
 REFERENCES VMSCMS.CMS_USERDETL_MAST (CUM_USER_CODE),
  CONSTRAINT FK_CUI_INST_CIM_INST 
 FOREIGN KEY (CUI_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE))
/

