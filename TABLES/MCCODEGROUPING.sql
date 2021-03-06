CREATE TABLE VMSCMS.MCCODEGROUPING
(
  MCCODEGROUPID     VARCHAR2(4 BYTE),
  MCCODEGROUPDESC   VARCHAR2(50 BYTE)           NOT NULL,
  ACTIVATIONSTATUS  VARCHAR2(1 BYTE),
  ACT_LUPD_DATE     DATE,
  ACT_INST_CODE     NUMBER(10),
  ACT_LUPD_USER     NUMBER(10),
  ACT_INS_DATE      DATE,
  ACT_INS_USER      NUMBER(10),
  PERMRULE_FLAG     VARCHAR2(1 BYTE)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.MCCODEGROUPING ADD (
  CONSTRAINT PK_MCCODEGROUPING
 PRIMARY KEY
 (MCCODEGROUPID))
/

