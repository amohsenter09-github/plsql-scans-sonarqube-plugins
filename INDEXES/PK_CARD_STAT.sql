CREATE UNIQUE INDEX VMSCMS.PK_CARD_STAT ON VMSCMS.CMS_GPR_CARDSTAT
(CGS_STAT_CODE, CGS_INST_CODE)
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


