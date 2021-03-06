CREATE TABLE VMSCMS.CMS_INTER_DISP
(
  CID_INST_CODE   NUMBER(3)                     NOT NULL,
  CID_DISP_CODE   NUMBER(2)                     NOT NULL,
  CID_INTER_CODE  VARCHAR2(2 BYTE)              NOT NULL,
  CID_INS_USER    NUMBER(5)                     NOT NULL,
  CID_INS_DATE    DATE                          NOT NULL,
  CID_LUPD_USER   NUMBER(5)                     NOT NULL,
  CID_LUPD_DATE   DATE                          NOT NULL
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_INTER_DISP ADD (
  CONSTRAINT PK_INTER_DISP
 PRIMARY KEY
 (CID_INST_CODE, CID_DISP_CODE, CID_INTER_CODE))
/

ALTER TABLE VMSCMS.CMS_INTER_DISP ADD (
  CONSTRAINT FK_INTERDISP_INTERMAST 
 FOREIGN KEY (CID_INST_CODE, CID_INTER_CODE) 
 REFERENCES VMSCMS.CMS_INTERCHANGE_MAST (CIM_INST_CODE,CIM_INTERCHANGE_CODE),
  CONSTRAINT FK_INTERDISP_USERMAST1 
 FOREIGN KEY (CID_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_INTERDISP_USERMAST2 
 FOREIGN KEY (CID_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_INTERDISP_DISPMAST 
 FOREIGN KEY (CID_INST_CODE, CID_DISP_CODE) 
 REFERENCES VMSCMS.CMS_DISP_MAST (CDM_INST_CODE,CDM_DISP_CODE))
/

