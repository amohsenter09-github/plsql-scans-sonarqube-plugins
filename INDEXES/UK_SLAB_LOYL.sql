CREATE UNIQUE INDEX VMSCMS.UK_SLAB_LOYL ON VMSCMS.CMS_SLAB_LOYL
(CSL_INST_CODE, CSL_SLAB_CODE)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


