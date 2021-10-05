CREATE INDEX VMSCMS.IND_AVAILTRANS_PAN ON VMSCMS.CMS_AVAIL_TRANS
(CAT_PAN_CODE)
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


