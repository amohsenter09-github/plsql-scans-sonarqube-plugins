CREATE UNIQUE INDEX VMSCMS.UK_CNTRY_MAST ON VMSCMS.GEN_CNTRY_MAST
(GCM_INST_CODE, GCM_CNTRY_NAME)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


