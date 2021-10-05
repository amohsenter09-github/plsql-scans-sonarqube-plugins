CREATE UNIQUE INDEX VMSCMS.PK_CARD_RULE ON VMSCMS.CMS_CARD_RULE
(CCR_RULE_ID, CCR_MERC_CATG_ID)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

