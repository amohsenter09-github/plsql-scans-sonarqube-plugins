CREATE UNIQUE INDEX VMSCMS.PK_CBF_BRAN ON VMSCMS.CMS_BRAN_FIID
(CBF_INST_CODE, CBF_BRAN_CODE)
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


