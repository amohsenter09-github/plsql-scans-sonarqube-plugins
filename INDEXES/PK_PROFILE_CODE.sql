CREATE UNIQUE INDEX VMSCMS.PK_PROFILE_CODE ON VMSCMS.CMS_PROFILE_MAST
(CPM_PROFILE_CODE)
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


