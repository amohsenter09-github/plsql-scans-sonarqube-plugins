CREATE UNIQUE INDEX VMSCMS.PK_MCCID_TERMINALID ON VMSCMS.PCMS_MCC_TERMINAL
(PMT_MARC_ID, PMT_TERMINAL_ID)
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


