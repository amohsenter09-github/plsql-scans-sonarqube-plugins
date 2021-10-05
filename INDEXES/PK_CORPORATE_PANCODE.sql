CREATE UNIQUE INDEX VMSCMS.PK_CORPORATE_PANCODE ON VMSCMS.PCMS_CORPORATE_CARDS
(PCC_INST_CODE, PCC_PAN_NO)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;

