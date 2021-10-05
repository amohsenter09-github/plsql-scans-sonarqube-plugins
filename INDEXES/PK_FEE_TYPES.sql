CREATE UNIQUE INDEX VMSCMS.PK_FEE_TYPES ON VMSCMS.CMS_FEE_TYPES
(CFT_INST_CODE, CFT_FEETYPE_CODE)
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


