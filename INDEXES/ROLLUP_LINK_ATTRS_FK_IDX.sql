CREATE INDEX VMSCMS.ROLLUP_LINK_ATTRS_FK_IDX ON VMSCMS.DMRS_ROLLUP_LINK_ATTRS
(ROLLUP_LINK_OVID)
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


