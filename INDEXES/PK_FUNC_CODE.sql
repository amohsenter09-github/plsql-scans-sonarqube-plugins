CREATE UNIQUE INDEX VMSCMS.PK_FUNC_CODE ON VMSCMS.CMS_FUNC_MAST
(CFM_INST_CODE, CFM_FUNC_CODE)
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


