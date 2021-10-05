CREATE INDEX VMSCMS.IND_CCH_PAN_CODE ON VMSCMS.CMS_CARDISSUE_STATCHANGE_HIST
(CCH_PAN_CODE)
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


