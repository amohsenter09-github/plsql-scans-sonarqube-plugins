CREATE TABLE VMSCMS.CMS_INSTRUMENT_MAST
(
  CIM_INST_CODE        NUMBER(3),
  CIM_INSTRUMENT_NO    NUMBER(2),
  CIM_INSTRUMENT_DESC  VARCHAR2(30 BYTE),
  CIM_INS_USER         NUMBER(5),
  CIM_INS_DATE         DATE,
  CIM_LUPD_USER        NUMBER(5),
  CIM_LUPD_DATE        DATE
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


