CREATE TABLE VMSCMS.CMS_BRANCH_TRANSFER
(
  CBT_INST_CODE          NUMBER(3),
  CBT_REQUEST_ID         VARCHAR2(7 BYTE),
  CBT_FROM_BRANCH        VARCHAR2(5 BYTE),
  CBT_TO_BRANCH          VARCHAR2(5 BYTE),
  CBT_ENV_FROMREFNO      NUMBER,
  CBT_ENV_TOREFNO        NUMBER,
  CBT_CARD_QUANTITY      NUMBER,
  CBT_ENTERED_BY         VARCHAR2(20 BYTE),
  CBT_ENTERED_DATE       VARCHAR2(10 BYTE),
  CBT_AUTHORISED_BY      VARCHAR2(20 BYTE),
  CBT_AUTHORISED_DATE    VARCHAR2(10 BYTE),
  CBT_BATCH_STATUS       VARCHAR2(1 BYTE),
  CBT_PRODUCT_CODE       VARCHAR2(6 BYTE),
  CBT_CARD_TYPE          NUMBER(2),
  CBT_CARD_DENOMINATION  VARCHAR2(10 BYTE),
  CBT_INS_USER           NUMBER,
  CBT_INS_DATE           DATE,
  CBT_LUPD_USER          NUMBER,
  CBT_LUPD_DATE          DATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


