CREATE TABLE VMSCMS.CMS_PROD_LOYL
(
  CPL_INST_CODE   NUMBER(3)                     NOT NULL,
  CPL_PROD_CODE   VARCHAR2(6 BYTE)              NOT NULL,
  CPL_LOYL_CODE   NUMBER(3)                     NOT NULL,
  CPL_VALID_FROM  DATE                          NOT NULL,
  CPL_VALID_TO    DATE                          NOT NULL,
  CPL_INS_USER    NUMBER(5)                     NOT NULL,
  CPL_INS_DATE    DATE                          NOT NULL,
  CPL_LUPD_USER   NUMBER(5)                     NOT NULL,
  CPL_LUPD_DATE   DATE                          NOT NULL
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_PROD_LOYL ADD (
  CONSTRAINT FK_PRODLOYL_LOYLMAST 
 FOREIGN KEY (CPL_INST_CODE, CPL_LOYL_CODE) 
 REFERENCES VMSCMS.CMS_LOYL_MAST (CLM_INST_CODE,CLM_LOYL_CODE),
  CONSTRAINT FK_PRODLOYL_USERMAST1 
 FOREIGN KEY (CPL_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_PRODLOYL_USERMAST2 
 FOREIGN KEY (CPL_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_PRODLOYL_PRODMAST 
 FOREIGN KEY (CPL_INST_CODE, CPL_PROD_CODE) 
 REFERENCES VMSCMS.CMS_PROD_MAST (CPM_INST_CODE,CPM_PROD_CODE))
/

