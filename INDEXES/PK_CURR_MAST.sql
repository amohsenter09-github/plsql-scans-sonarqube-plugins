CREATE UNIQUE INDEX VMSCMS.PK_CURR_MAST ON VMSCMS.GEN_CURR_MAST
(GCM_INST_CODE, GCM_CURR_CODE)
LOGGING
TABLESPACE USERS
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


