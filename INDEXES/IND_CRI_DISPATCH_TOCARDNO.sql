CREATE INDEX VMSCMS.IND_CRI_DISPATCH_TOCARDNO ON VMSCMS.CMS_REQUEST_INVENTORY
(CRI_DISPATCH_TOCARDNO)
LOGGING
TABLESPACE CMS_BIG_IDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          10M
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

