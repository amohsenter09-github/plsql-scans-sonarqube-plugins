CREATE UNIQUE INDEX VMSCMS.PK_SQLN_PROF_ANB ON VMSCMS.SQLN_PROF_ANB
(RUNID, UNIT_NUMBER, LINE#)
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


