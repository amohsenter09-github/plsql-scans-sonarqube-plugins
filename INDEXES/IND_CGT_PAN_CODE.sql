CREATE INDEX VMSCMS.IND_CGT_PAN_CODE ON VMSCMS.CMS_GIFT_TRANS
(CGT_PAN_CODE)
LOGGING
TABLESPACE CMS_BIG_IDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          10M
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


