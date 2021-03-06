CREATE TABLE VMSCMS.CMS_SAVACCT_STAT_HIST
(
  CSH_INST_CODE      NUMBER(3)                  NOT NULL,
  CSH_ACCT_NO        VARCHAR2(20 BYTE)          NOT NULL,
  CSH_ACCT_ID        NUMBER(10)                 NOT NULL,
  CSH_OLD_STAT_CODE  NUMBER(3)                  NOT NULL,
  CSH_NEW_STAT_CODE  NUMBER(3)                  NOT NULL,
  CSH_INS_USER       NUMBER(5)                  NOT NULL,
  CSH_INS_DATE       DATE                       NOT NULL,
  CSH_LUPD_USER      NUMBER(5)                  NOT NULL,
  CSH_LUPD_DATE      DATE                       NOT NULL
)
TABLESPACE CMS_HIST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_SAVACCT_STAT_HIST ADD (
  CONSTRAINT FK_CSH_LUPD_USER 
 FOREIGN KEY (CSH_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_CSH_INS_USER 
 FOREIGN KEY (CSH_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_SAVACCT_ACCTID 
 FOREIGN KEY (CSH_INST_CODE, CSH_ACCT_ID) 
 REFERENCES VMSCMS.CMS_ACCT_MAST (CAM_INST_CODE,CAM_ACCT_ID))
/

