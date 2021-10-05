CREATE TABLE VMSCMS.CMS_QEST_MAST
(
  CQM_INST_CODE  NUMBER(5)                      NOT NULL,
  CQM_QUST_CODE  NUMBER(2),
  CQM_QUST_DESC  VARCHAR2(100 BYTE)             NOT NULL,
  CQM_QUST_IND   NUMBER(1)                      NOT NULL,
  CQM_INS_USER   NUMBER(8)                      NOT NULL,
  CQM_INS_DATE   DATE                           NOT NULL,
  CQM_LUPD_USER  NUMBER(8),
  CQM_LUPD_DATE  DATE
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_QEST_MAST ADD (
  CONSTRAINT PK_CQM_INST_QUST
 PRIMARY KEY
 (CQM_QUST_CODE),
  CONSTRAINT UK_CQM_QUST_DESC
 UNIQUE (CQM_INST_CODE, CQM_QUST_DESC))
/

ALTER TABLE VMSCMS.CMS_QEST_MAST ADD (
  CONSTRAINT FK_CQM_PWIN_CUM_USID 
 FOREIGN KEY (CQM_INS_USER) 
 REFERENCES VMSCMS.CMS_USERDETL_MAST (CUM_USER_CODE),
  CONSTRAINT FK_CQM_PWUS_CIM_USID 
 FOREIGN KEY (CQM_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE))
/

