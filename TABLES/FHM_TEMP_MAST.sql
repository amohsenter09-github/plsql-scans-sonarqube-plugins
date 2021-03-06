CREATE TABLE VMSCMS.FHM_TEMP_MAST
(
  FTM_TEMP_ID       NUMBER(10)                  NOT NULL,
  FTM_TEMP_DESC     VARCHAR2(32 BYTE),
  FTM_TEMP_DTLS     VARCHAR2(64 BYTE),
  FTM_NO_PRMS       NUMBER(10),
  FTM_QRY_ID        NUMBER(10),
  FTM_MSG_FLOW      CHAR(1 BYTE),
  FTM_REQ_TIME_OUT  NUMBER(10),
  FTM_MSG_TYPE      VARCHAR2(32 BYTE),
  FTM_REQ_TEMP_ID   NUMBER(10),
  FTM_TYPE_REQ_ID   NUMBER(10),
  FTM_LUPD_DATE     DATE,
  FTM_INST_CODE     NUMBER(10),
  FTM_LUPD_USER     NUMBER(10),
  FTM_INS_DATE      DATE,
  FTM_INS_USER      NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.FHM_TEMP_MAST ADD (
  CONSTRAINT FTM_MSG_FLOW_CHK
 CHECK (FTM_MSG_FLOW IN ('O',
    'I')),
  CONSTRAINT FTM_TEMP_ID_PK
 PRIMARY KEY
 (FTM_TEMP_ID))
/

