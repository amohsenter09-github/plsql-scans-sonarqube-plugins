CREATE TABLE VMSCMS.CMS_ASSO_MAST
(
  CAM_ASSO_CODE  NUMBER(3)                      NOT NULL,
  CAM_ASSO_DESC  VARCHAR2(50 BYTE)              NOT NULL,
  CAM_INS_USER   NUMBER(5)                      NOT NULL,
  CAM_INS_DATE   DATE                           NOT NULL,
  CAM_LUPD_USER  NUMBER(5)                      NOT NULL,
  CAM_LUPD_DATE  DATE                           NOT NULL,
  CAM_INST_CODE  NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_ASSO_MAST ADD (
  CONSTRAINT PK_ASSO_MAST
 PRIMARY KEY
 (CAM_INST_CODE, CAM_ASSO_CODE))
/

ALTER TABLE VMSCMS.CMS_ASSO_MAST ADD (
  CONSTRAINT FK_ASSOMAST_USERMAST2 
 FOREIGN KEY (CAM_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_ASSOMAST_USERMAST1 
 FOREIGN KEY (CAM_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN))
/

