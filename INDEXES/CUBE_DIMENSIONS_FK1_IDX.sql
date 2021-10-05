CREATE INDEX VMSCMS.CUBE_DIMENSIONS_FK1_IDX ON VMSCMS.DMRS_CUBE_DIMENSIONS
(CUBE_OVID)
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


