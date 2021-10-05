CREATE TABLE VMSCMS.DRP_PRXY_SHFL
(
  DPS_GPR_PAN         VARCHAR2(90 BYTE),
  DPS_GPROLD_PROXY    VARCHAR2(19 BYTE),
  DPS_GPRNEW_PROXY    VARCHAR2(19 BYTE),
  DPS_STATR_PAN       VARCHAR2(90 BYTE),
  DPS_STATROLD_PROXY  VARCHAR2(19 BYTE),
  DPS_STATRNEW_PROXY  VARCHAR2(19 BYTE),
  DPS_MSG             VARCHAR2(500 BYTE),
  DPS_FLAG            CHAR(1 BYTE)
)
TABLESPACE CMS_BKUP
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


