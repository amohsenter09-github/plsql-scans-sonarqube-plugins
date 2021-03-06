CREATE UNIQUE INDEX VMSCMS.PK_AUDITMAST_TABLEID ON VMSCMS.CMS_GENAUDIT_MAST
(CGM_INST_CODE, CGM_TABLE_ID)
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


