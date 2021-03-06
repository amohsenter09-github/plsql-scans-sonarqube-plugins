CREATE UNIQUE INDEX VMSCMS.PK_SPPRT_CATG ON VMSCMS.CMS_SPPRT_CATG
(CSC_INST_CODE, CSC_PROD_CATG, CSC_SPPRT_KEY)
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


