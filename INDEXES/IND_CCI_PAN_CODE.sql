CREATE INDEX VMSCMS.IND_CCI_PAN_CODE ON VMSCMS.CMS_CAFGEN_DATA_TEMP
(CCI_PAN_CODE)
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

