CREATE INDEX VMSCMS.SPATIAL_DIMENSIONS_FK_IDX ON VMSCMS.DMRS_SPATIAL_DIMENSIONS
(DEFINITION_OVID)
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


