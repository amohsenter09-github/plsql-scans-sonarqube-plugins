CREATE INDEX VMSCMS.IND_CUSTOMER_CARD_NO_REP ON VMSCMS.TRANSACTIONLOG_ACHTXNDATE_REP
(CUSTOMER_CARD_NO)
LOGGING
TABLESPACE CMS_BIG_IDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          10M
            NEXT             10M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


