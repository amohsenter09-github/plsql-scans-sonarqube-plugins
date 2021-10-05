CREATE UNIQUE INDEX VMSCMS.PK_ACCT_MAST ON VMSCMS.CMS_ACCT_MAST
(CAM_INST_CODE, CAM_ACCT_ID)
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


