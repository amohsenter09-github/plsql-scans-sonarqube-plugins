CREATE TABLE VMSCMS.CMS_ACCTLVL_FEELIMIT
(
  CAF_ACCT_ID        NUMBER(10)                 NOT NULL,
  CAF_FEE_CODE       NUMBER(4)                  NOT NULL,
  CAF_MAX_LIMIT      NUMBER(5)                  DEFAULT 0                     NOT NULL,
  CAF_LMT_RESETDATE  DATE,
  CAF_INS_DATE       DATE                       NOT NULL,
  CAF_LUPD_DATE      DATE,
  CAF_INST_CODE      NUMBER(3)                  NOT NULL
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_ACCTLVL_FEELIMIT ADD (
  CONSTRAINT PK_ACCTLVL_FEELIMIT
 PRIMARY KEY
 (CAF_ACCT_ID, CAF_INST_CODE, CAF_FEE_CODE))
/

ALTER TABLE VMSCMS.CMS_ACCTLVL_FEELIMIT ADD (
  CONSTRAINT FK_FEELMT_ACCTID 
 FOREIGN KEY (CAF_INST_CODE, CAF_ACCT_ID) 
 REFERENCES VMSCMS.CMS_ACCT_MAST (CAM_INST_CODE,CAM_ACCT_ID),
  CONSTRAINT FK_FEELMT_FECODE 
 FOREIGN KEY (CAF_INST_CODE, CAF_FEE_CODE) 
 REFERENCES VMSCMS.CMS_FEE_MAST (CFM_INST_CODE,CFM_FEE_CODE),
  CONSTRAINT FK_FEELMT_INSTCODE 
 FOREIGN KEY (CAF_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE))
/

