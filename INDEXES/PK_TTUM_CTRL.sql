CREATE UNIQUE INDEX VMSCMS.PK_TTUM_CTRL ON VMSCMS.CMS_TTUM_CTRL
(CTC_INST_CODE, CTC_FILE_NAME)
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


