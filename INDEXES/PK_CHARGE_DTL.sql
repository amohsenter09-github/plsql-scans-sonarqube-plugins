CREATE UNIQUE INDEX VMSCMS.PK_CHARGE_DTL ON VMSCMS.CMS_CHARGE_DTL
(CCD_FEE_TRANS)
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

