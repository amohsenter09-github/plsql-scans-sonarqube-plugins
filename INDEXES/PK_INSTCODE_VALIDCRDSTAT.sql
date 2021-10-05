CREATE UNIQUE INDEX VMSCMS.PK_INSTCODE_VALIDCRDSTAT ON VMSCMS.CMS_REISSUE_VALIDSTAT
(CRV_INST_CODE, CRV_VALID_CRDSTAT)
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


