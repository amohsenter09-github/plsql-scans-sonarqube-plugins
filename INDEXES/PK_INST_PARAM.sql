CREATE UNIQUE INDEX VMSCMS.PK_INST_PARAM ON VMSCMS.CMS_INST_PARAM
(CIP_INST_CODE, CIP_PARAM_KEY, CIP_PARAM_VALUE)
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


