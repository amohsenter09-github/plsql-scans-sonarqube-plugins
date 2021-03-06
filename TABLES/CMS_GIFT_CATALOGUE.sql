CREATE TABLE VMSCMS.CMS_GIFT_CATALOGUE
(
  CGC_INST_CODE  NUMBER(3),
  CGC_PLAN_ID    VARCHAR2(5 BYTE),
  CGC_ITEM_ID    VARCHAR2(6 BYTE),
  CGC_REL_STAT   CHAR(1 BYTE)                   DEFAULT 'Y',
  CGC_INS_USER   NUMBER(5)                      NOT NULL,
  CGC_INS_DATE   DATE                           NOT NULL,
  CGC_LUPD_USER  NUMBER(5)                      NOT NULL,
  CGC_LUPD_DATE  DATE                           NOT NULL
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_GIFT_CATALOGUE ADD (
  CONSTRAINT PK_GIFT_CATALOGUE
 PRIMARY KEY
 (CGC_INST_CODE, CGC_PLAN_ID, CGC_ITEM_ID))
/

ALTER TABLE VMSCMS.CMS_GIFT_CATALOGUE ADD (
  CONSTRAINT FK_GIFTCAT_GIFTPLAN 
 FOREIGN KEY (CGC_INST_CODE, CGC_PLAN_ID) 
 REFERENCES VMSCMS.CMS_GIFT_PLAN (CGP_INST_CODE,CGP_PLAN_ID))
/

