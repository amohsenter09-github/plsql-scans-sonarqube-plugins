CREATE INDEX VMSCMS.ATTRIBUTES_CONTAINER_OVID_IDX ON VMSCMS.DMRS_ATTRIBUTES
(CONTAINER_OVID)
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


