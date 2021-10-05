CREATE UNIQUE INDEX VMSCMS.UK_CQM_QUST_DESC ON VMSCMS.CMS_QEST_MAST
(CQM_INST_CODE, CQM_QUST_DESC)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

