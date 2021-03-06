CREATE TABLE VMSCMS.CMS_PROD_LIMITS
(
  CPL_INST_CODE          NUMBER(3)              NOT NULL,
  CPL_CUST_CATG          NUMBER(4)              NOT NULL,
  CPL_PROD_CODE          VARCHAR2(6 BYTE)       NOT NULL,
  CPL_CATG_CODE          NUMBER(3),
  CPL_ATM_OFFLINE_LIMIT  NUMBER(10),
  CPL_ATM_ONLINE_LIMIT   NUMBER(10),
  CPL_POS_OFFLINE_LIMIT  NUMBER(10),
  CPL_POS_ONLINE_LIMIT   NUMBER(10),
  CPL_CARD_TYPE          NUMBER(2)              NOT NULL,
  CPL_LUPD_DATE          DATE,
  CPL_LUPD_USER          NUMBER(10),
  CPL_INS_DATE           DATE,
  CPL_INS_USER           NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_PROD_LIMITS ADD (
  CONSTRAINT PK_PROD_LIMITS
 PRIMARY KEY
 (CPL_INST_CODE, CPL_PROD_CODE, CPL_CARD_TYPE, CPL_CUST_CATG))
/

ALTER TABLE VMSCMS.CMS_PROD_LIMITS ADD (
  CONSTRAINT FK_PRODLIMITS_PRODMAST 
 FOREIGN KEY (CPL_INST_CODE, CPL_PROD_CODE) 
 REFERENCES VMSCMS.CMS_PROD_MAST (CPM_INST_CODE,CPM_PROD_CODE),
  CONSTRAINT FK_PRODLIMITS_CUSTCATG 
 FOREIGN KEY (CPL_INST_CODE, CPL_CUST_CATG) 
 REFERENCES VMSCMS.CMS_CUST_CATG (CCC_INST_CODE,CCC_CATG_CODE))
/

