CREATE TABLE VMSCMS.CMS_CARD_RULE
(
  CCR_RULE_ID            NUMBER,
  CCR_CARD_NO            VARCHAR2(16 BYTE),
  CCR_LUPD_DATE          DATE,
  CCR_INST_CODE          NUMBER(10),
  CCR_LUPD_USER          NUMBER(10),
  CCR_INS_DATE           DATE,
  CCR_INS_USER           NUMBER(10),
  CCR_MERC_CATG_ID       NUMBER(10),
  CCR_ACTIVATION_STATUS  VARCHAR2(1 BYTE),
  CCR_SUB_ACCTNO         VARCHAR2(20 BYTE),
  CCR_DECLINE_FLAG       VARCHAR2(1 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_CARD_RULE ADD (
  CONSTRAINT PK_CARD_RULE
 PRIMARY KEY
 (CCR_RULE_ID, CCR_MERC_CATG_ID))
/

