CREATE INDEX VMSCMS.LEVELS_FK_IDX ON VMSCMS.DMRS_LEVELS
(MODEL_OVID)
NOLOGGING
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


