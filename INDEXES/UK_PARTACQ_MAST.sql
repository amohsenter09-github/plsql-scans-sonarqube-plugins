CREATE UNIQUE INDEX VMSCMS.UK_PARTACQ_MAST ON VMSCMS.CMS_PARTACQ_MAST
(RAM_ACQ_CODE)
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


