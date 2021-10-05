CREATE TABLE VMSCMS.CMS_DAYWISE_GL
(
  CDG_GL_DATE    DATE,
  CDG_GL_FLAG    VARCHAR2(1 BYTE),
  CDG_LUPD_DATE  DATE,
  CDG_INST_CODE  NUMBER(10),
  CDG_LUPD_USER  NUMBER(10),
  CDG_INS_DATE   DATE,
  CDG_INS_USER   NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

