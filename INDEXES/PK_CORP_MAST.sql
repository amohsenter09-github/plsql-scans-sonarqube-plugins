CREATE UNIQUE INDEX VMSCMS.PK_CORP_MAST ON VMSCMS.CMS_CORP_MAST
(CCM_INST_CODE, CCM_CORP_CODE)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

