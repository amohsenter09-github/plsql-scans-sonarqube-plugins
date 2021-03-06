CREATE UNIQUE INDEX VMSCMS.PK_PCMS_RISK_PRODUCT ON VMSCMS.PCMS_RISK_PRODUCT
(PRT_PROD_CODE, PRT_CARD_TYPE, PRT_RISK_ID, PRT_INST_CODE)
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


