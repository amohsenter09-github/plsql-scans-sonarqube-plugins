CREATE INDEX VMSCMS.RESPONSIBLE_PARTIES_PK_IDX ON VMSCMS.DMRS_RESPONSIBLE_PARTIES
(RESPONSIBLE_PARTY_OVID)
NOLOGGING
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


