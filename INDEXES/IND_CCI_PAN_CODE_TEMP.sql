CREATE INDEX VMSCMS.IND_CCI_PAN_CODE_TEMP ON VMSCMS.CMS_CAF_INFO_CARDBASE_TEMP
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


