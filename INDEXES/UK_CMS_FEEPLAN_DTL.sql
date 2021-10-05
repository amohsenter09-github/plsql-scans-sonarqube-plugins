CREATE UNIQUE INDEX VMSCMS.UK_CMS_FEEPLAN_DTL ON VMSCMS.CMS_FEEPLAN_DTL
(CFD_INST_CODE, CFD_PLAN_CODE, CFD_FEE_CODE)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


