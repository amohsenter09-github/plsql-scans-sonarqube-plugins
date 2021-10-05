CREATE INDEX VMSCMS.IND_COE_PAN_CODE ON VMSCMS.CMS_ONLINESPPRT_ERROR
(COE_PAN_CODE)
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


