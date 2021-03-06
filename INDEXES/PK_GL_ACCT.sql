CREATE UNIQUE INDEX VMSCMS.PK_GL_ACCT ON VMSCMS.CMS_GL_ACCT_MAST
(CGA_INST_CODE, CGA_GL_CODE, CGA_SUBGL_CODE, CGA_ACCT_CODE)
LOGGING
TABLESPACE INCOMM
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          256K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


