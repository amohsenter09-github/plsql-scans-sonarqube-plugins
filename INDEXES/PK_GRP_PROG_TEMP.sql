CREATE UNIQUE INDEX VMSCMS.PK_GRP_PROG_TEMP ON VMSCMS.CMS_GROUP_PROG_TEMP
(CGP_GROUP_CODE, CGP_PROG_CODE, CGP_ROW_ID)
LOGGING
TABLESPACE USERS
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          576K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


