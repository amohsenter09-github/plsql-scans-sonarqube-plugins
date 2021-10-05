CREATE TABLE VMSCMS.PCMS_CORPORATE_MASTER
(
  PCM_ORGANIZATION_CODE  VARCHAR2(4 BYTE),
  PCM_SHORT_NAME         VARCHAR2(5 BYTE)       NOT NULL,
  PCM_ORGANIZATION_NAME  VARCHAR2(30 BYTE),
  PCM_ADDR_LINE1         VARCHAR2(30 BYTE),
  PCM_ADDR_LINE2         VARCHAR2(30 BYTE),
  PCM_ADDR_LINE3         VARCHAR2(30 BYTE),
  PCM_PIN                VARCHAR2(8 BYTE),
  PCM_CITY               VARCHAR2(15 BYTE),
  PCM_STATE              VARCHAR2(15 BYTE),
  PCM_COUNTRY            VARCHAR2(15 BYTE),
  PCM_UPD_USER           NUMBER(4),
  PCM_UPD_DATE           DATE,
  PCM_INS_USER           NUMBER(5),
  PCM_INS_DATE           DATE,
  PCM_CONTACT_PERSON     VARCHAR2(30 BYTE),
  PCM_CORP_EMAIL         VARCHAR2(30 BYTE),
  PCM_PSWD_CREATED       VARCHAR2(1 BYTE)       DEFAULT 'N',
  PCM_LUPD_DATE          DATE,
  PCM_INST_CODE          NUMBER(10),
  PCM_LUPD_USER          NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.PCMS_CORPORATE_MASTER ADD (
  CONSTRAINT PK__CORPORATE_MASTER1
 PRIMARY KEY
 (PCM_ORGANIZATION_CODE),
  CONSTRAINT UK_CORPMASTER_SHORT_NAME
 UNIQUE (PCM_SHORT_NAME))
/

