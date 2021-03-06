CREATE UNIQUE INDEX VMSCMS.PK_UPLOAD_CTRL ON VMSCMS.CMS_UPLOAD_CTRL
(CUC_INST_CODE, CUC_FILE_NAME)
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


