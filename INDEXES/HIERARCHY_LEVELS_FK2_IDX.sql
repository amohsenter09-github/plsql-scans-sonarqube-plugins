CREATE INDEX VMSCMS.HIERARCHY_LEVELS_FK2_IDX ON VMSCMS.DMRS_HIERARCHY_LEVELS
(LEVEL_OVID)
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

