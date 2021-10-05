CREATE INDEX VMSCMS.MAPPING_TARGET_SOURCES_FK1_IDX ON VMSCMS.DMRS_MAPPING_TARGET_SOURCES
(OBJECT_OVID)
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


