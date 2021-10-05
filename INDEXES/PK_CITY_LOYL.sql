CREATE UNIQUE INDEX VMSCMS.PK_CITY_LOYL ON VMSCMS.CMS_CITY_LOYL
(CCL_INST_CODE, CCL_LOYL_CODE)
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


