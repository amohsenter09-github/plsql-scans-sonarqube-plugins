CREATE INDEX VMSCMS.GLOSSARY_TERMS_FK_IDX ON VMSCMS.DMRS_GLOSSARY_TERMS
(GLOSSARY_OVID)
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


