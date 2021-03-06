CREATE TABLE VMSCMS.CMS_CHNL_MAST
(
  CCM_INST_CODE  NUMBER(3)                      NOT NULL,
  CCM_CHNL_CODE  NUMBER(3)                      NOT NULL,
  CCM_CHNL_DESC  VARCHAR2(35 BYTE)              NOT NULL,
  CCM_INS_USER   NUMBER(5)                      NOT NULL,
  CCM_INS_DATE   DATE                           NOT NULL,
  CCM_LUPD_USER  NUMBER(5)                      NOT NULL,
  CCM_LUPD_DATE  DATE                           NOT NULL
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_CHNL_MAST ADD (
  CONSTRAINT PK_CHNL_MAST
 PRIMARY KEY
 (CCM_INST_CODE, CCM_CHNL_CODE))
/

ALTER TABLE VMSCMS.CMS_CHNL_MAST ADD (
  CONSTRAINT FK_CHNLMAST_USERMAST2 
 FOREIGN KEY (CCM_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CHNLMAST_USERMAST1 
 FOREIGN KEY (CCM_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CHNLMAST_INSTMAST 
 FOREIGN KEY (CCM_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE))
/

