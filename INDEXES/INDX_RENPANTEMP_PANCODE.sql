CREATE INDEX VMSCMS.INDX_RENPANTEMP_PANCODE ON VMSCMS.CMS_REN_PAN_TEMP
(CRP_PAN_CODE)
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


