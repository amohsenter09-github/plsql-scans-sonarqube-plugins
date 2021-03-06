CREATE TABLE VMSCMS.CMS_INTERFACE_MAST
(
  CIM_INTERFACE_CODE  VARCHAR2(5 BYTE),
  CIM_INTERFACE_NAME  VARCHAR2(20 BYTE),
  CIM_INS_DATE        DATE,
  CIM_LUPD_DATE       DATE,
  CIM_INST_CODE       NUMBER(3),
  CIM_KEY_SCHEME      VARCHAR2(1 BYTE),
  CIM_FROM_SRCAPP     VARCHAR2(20),
  CIM_TO_SRCAPP       VARCHAR2(20)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_INTERFACE_MAST ADD (
  CONSTRAINT PK_INTERFACE_MAST1
 PRIMARY KEY
 (CIM_INTERFACE_CODE))
/

