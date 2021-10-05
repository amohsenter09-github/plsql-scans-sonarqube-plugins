CREATE TABLE VMSCMS.CMS_PBFTIP_HIST
(
  CPH_INST_CODE        NUMBER(3)                NOT NULL,
  CPH_PAN_CODE         VARCHAR2(20 BYTE),
  CPH_OLD_PBF_FNAME    VARCHAR2(20 BYTE),
  CPH_OLD_PBFGEN_DATE  DATE,
  CPH_OLD_PBFGEN_USER  NUMBER(5),
  CPH_TIPGEN_CNT       NUMBER(5),
  CPH_NEW_PBF_FNAME    VARCHAR2(20 BYTE),
  CPH_NEW_PBFGEN_DATE  DATE,
  CPH_NEW_PBFGEN_USER  NUMBER(5),
  CPH_INS_USER         NUMBER(5)                NOT NULL,
  CPH_INS_DATE         DATE                     NOT NULL
)
TABLESPACE CMS_HIST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


