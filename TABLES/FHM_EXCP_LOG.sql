CREATE TABLE VMSCMS.FHM_EXCP_LOG
(
  FEL_EXCP_CODE     VARCHAR2(15 BYTE),
  FEL_EXCP_DESC     VARCHAR2(100 BYTE),
  FEL_EXCP_MODL     VARCHAR2(30 BYTE),
  FEL_PAN_NO        VARCHAR2(20 BYTE),
  FEL_EXCP_DATE     DATE,
  FEL_EXCP_TRACEID  VARCHAR2(10 BYTE),
  FEL_LUPD_DATE     DATE,
  FEL_INST_CODE     NUMBER(10),
  FEL_LUPD_USER     NUMBER(10),
  FEL_INS_DATE      DATE,
  FEL_INS_USER      NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


