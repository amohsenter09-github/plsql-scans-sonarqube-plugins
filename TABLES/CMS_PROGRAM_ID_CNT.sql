CREATE TABLE VMSCMS.CMS_PROGRAM_ID_CNT
(
  CPI_INST_CODE    NUMBER(3),
  CPI_PROGRAM_ID   VARCHAR2(4 BYTE),
  CPI_SEQUENCE_NO  NUMBER(10),
  CPI_INS_USER     NUMBER(5),
  CPI_INS_DATE     DATE,
  CPI_LUPD_USER    NUMBER(5),
  CPI_LUPD_DATE    DATE
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


