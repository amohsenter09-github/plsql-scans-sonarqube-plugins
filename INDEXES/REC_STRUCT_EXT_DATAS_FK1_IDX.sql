CREATE INDEX VMSCMS.REC_STRUCT_EXT_DATAS_FK1_IDX ON VMSCMS.DMRS_RECORD_STRUCT_EXT_DATAS
(RECORD_STRUCTURE_OVID)
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


