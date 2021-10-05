CREATE UNIQUE INDEX VMSCMS.PK_CONST_CODE ON VMSCMS.CMS_CONST_MAST
(CCM_CONST_CODE, CCM_INST_CODE)
LOGGING
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

