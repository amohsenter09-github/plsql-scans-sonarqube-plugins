CREATE TABLE VMSCMS.CMS_FUNC_MAST
(
  CFM_INST_CODE            NUMBER(5)            NOT NULL,
  CFM_FUNC_CODE            VARCHAR2(10 BYTE),
  CFM_FUNC_DESC            VARCHAR2(50 BYTE)    NOT NULL,
  CFM_INST_DATE            DATE                 NOT NULL,
  CFM_LUPD_USER            NUMBER(5)            NOT NULL,
  CFM_LUPD_DATE            DATE                 NOT NULL,
  CFM_SCREEN_CODE          VARCHAR2(5 BYTE),
  CFM_ONLINE_OFFLINE_FLAG  VARCHAR2(1 BYTE),
  CFM_TXN_CODE             VARCHAR2(2 BYTE),
  CFM_TXN_MODE             VARCHAR2(1 BYTE),
  CFM_DELIVERY_CHANNEL     VARCHAR2(2 BYTE),
  CFM_TXN_TYPE             VARCHAR2(1 BYTE),
  CFM_INS_USER             NUMBER(5)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_FUNC_MAST ADD (
  CONSTRAINT PK_FUNC_CODE
 PRIMARY KEY
 (CFM_INST_CODE, CFM_FUNC_CODE),
  CONSTRAINT UN_CFM_TTD
 UNIQUE (CFM_INST_CODE, CFM_TXN_CODE, CFM_TXN_MODE, CFM_DELIVERY_CHANNEL))
/

