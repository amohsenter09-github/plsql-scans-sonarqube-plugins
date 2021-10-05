CREATE UNIQUE INDEX VMSCMS.PK_FREETXN_RESP ON VMSCMS.CMS_FREETXN_RESPONSE
(CFR_INST_CODE, CFR_DELIVERY_CHANNEL, CFR_TRAN_CODE, CFR_RESPCDE, CFR_MSG_TYPE, 
CFR_REVERSAL_CODE)
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


