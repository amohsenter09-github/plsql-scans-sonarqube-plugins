CREATE TABLE VMSCMS.MCCODE
(
  MCCODE            VARCHAR2(4 BYTE),
  MCCODEDESC        VARCHAR2(100 BYTE)          NOT NULL,
  ACTIVATIONSTATUS  VARCHAR2(1 BYTE),
  ACT_LUPD_DATE     DATE,
  ACT_INST_CODE     NUMBER(10),
  ACT_LUPD_USER     NUMBER(10),
  ACT_INS_DATE      DATE,
  ACT_INS_USER      NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.MCCODE ADD (
  CONSTRAINT MCCODE_PK
 PRIMARY KEY
 (ACT_INST_CODE, MCCODE))
/

