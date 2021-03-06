CREATE UNIQUE INDEX VMSCMS.PK_COBRAND_DETAILS ON VMSCMS.CMS_COBRAND_DETAILS
(CCD_INST_CODE, CCD_ASSO_CODE, CCD_ACQ_ID, CCD_TERM_ID)
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


