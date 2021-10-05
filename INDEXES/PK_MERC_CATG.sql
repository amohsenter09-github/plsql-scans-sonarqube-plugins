CREATE UNIQUE INDEX VMSCMS.PK_MERC_CATG ON VMSCMS.CMS_MERC_CATG
(CMC_INST_CODE, CMC_CATG_CODE)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


