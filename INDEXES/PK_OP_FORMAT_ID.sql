CREATE UNIQUE INDEX VMSCMS.PK_OP_FORMAT_ID ON VMSCMS.CMS_OP_FORMAT_MAST
(COM_FORMAT_ID)
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


