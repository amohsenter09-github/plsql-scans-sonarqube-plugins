CREATE INDEX VMSCMS.DMRS_LARGE_TEXT_PK_IDX ON VMSCMS.DMRS_LARGE_TEXT
(OVID)
NOLOGGING
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


