CREATE UNIQUE INDEX VMSCMS.FTM_TEMP_ID_PK ON VMSCMS.FHM_TEMP_MAST
(FTM_TEMP_ID)
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


