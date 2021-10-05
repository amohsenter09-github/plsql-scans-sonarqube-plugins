CREATE UNIQUE INDEX VMSCMS.PK_SQLN_PROF_RUNS ON VMSCMS.SQLN_PROF_RUNS
(PROJ_ID, RUNID)
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


