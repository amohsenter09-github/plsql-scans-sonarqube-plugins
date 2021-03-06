CREATE UNIQUE INDEX VMSCMS.PK_CHNL_MAST ON VMSCMS.CMS_CHNL_MAST
(CCM_INST_CODE, CCM_CHNL_CODE)
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


