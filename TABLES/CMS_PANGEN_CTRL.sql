CREATE TABLE VMSCMS.CMS_PANGEN_CTRL
(
  CPC_INST_CODE  NUMBER(3)                      NOT NULL,
  CPC_CTRL_PROD  VARCHAR2(10 BYTE),
  CPC_CTRL_BIN   VARCHAR2(10 BYTE)              NOT NULL,
  CPC_CTRL_BRAN  VARCHAR2(6 BYTE)               NOT NULL,
  CPC_CTRL_CATG  VARCHAR2(10 BYTE)              NOT NULL,
  CPC_CTRL_NUMB  VARCHAR2(10 BYTE)              NOT NULL,
  CPC_INS_USER   NUMBER(5)                      NOT NULL,
  CPC_INS_DATE   DATE                           NOT NULL,
  CPC_LUPD_USER  NUMBER(5)                      NOT NULL,
  CPC_LUPD_DATE  DATE                           NOT NULL
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_PANGEN_CTRL ADD (
  CONSTRAINT PK_PANGEN_CTRL
 PRIMARY KEY
 (CPC_INST_CODE, CPC_CTRL_BIN, CPC_CTRL_PROD))
/

