CREATE INDEX VMSCMS.MAPPINGS_REL_OBJ_OVID_IDX ON VMSCMS.DMRS_MAPPINGS
(RELATIONAL_OBJECT_OVID)
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


