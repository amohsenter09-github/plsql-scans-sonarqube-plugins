CREATE UNIQUE INDEX VMSCMS.PK_CAFGEN_CTRL ON VMSCMS.CMS_CAFGEN_CTRL
(CCC_INST_CODE, CCC_CAFGEN_DATE, CCC_CAF_FNAME)
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


