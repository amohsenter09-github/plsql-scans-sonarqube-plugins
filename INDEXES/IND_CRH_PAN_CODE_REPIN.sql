CREATE INDEX VMSCMS.IND_CRH_PAN_CODE_REPIN ON VMSCMS.CMS_REPIN_HIST
(CRH_PAN_CODE)
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


