CREATE UNIQUE INDEX VMSCMS.UK_TRANS_DISP1 ON VMSCMS.CMS_TRANS_DISP
(CTD_ID_COL, CTD_DISP_CODE)
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


