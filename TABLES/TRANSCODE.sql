CREATE TABLE VMSCMS.TRANSCODE
(
  TRANSCODE             VARCHAR2(4 BYTE),
  DELIVERY_CHNNEL       VARCHAR2(2 BYTE),
  TRANSTYPE             VARCHAR2(2 BYTE),
  TRANSCODEDESC         VARCHAR2(50 BYTE),
  ONUSFREETRANS         VARCHAR2(12 BYTE),
  REMOTEONUSFREETRANS   VARCHAR2(12 BYTE),
  REMOTEONUSTRANSFEE    VARCHAR2(12 BYTE),
  ONUSTIPS              VARCHAR2(12 BYTE),
  ONUSTIPSAMOUNT        VARCHAR2(12 BYTE),
  REMOTEONUSTIPS        VARCHAR2(12 BYTE),
  REMOTEONUSTIPSAMOUNT  VARCHAR2(12 BYTE),
  AMOUNTPERIOD          VARCHAR2(12 BYTE),
  MAXTRANSAMOUNTLIMIT   VARCHAR2(12 BYTE),
  ONUSPERIOD            VARCHAR2(2 BYTE),
  REMOTEONUSPERIOD      VARCHAR2(2 BYTE),
  ONUSTRANSFEE          VARCHAR2(12 BYTE),
  ACTIVATIONSTATUS      VARCHAR2(1 BYTE),
  ACT_LUPD_DATE         DATE,
  ACT_INST_CODE         NUMBER(10),
  ACT_LUPD_USER         NUMBER(10),
  ACT_INS_DATE          DATE,
  ACT_INS_USER          NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.TRANSCODE ADD (
  CONSTRAINT TRANSCODE_PK
 PRIMARY KEY
 (TRANSCODE, DELIVERY_CHNNEL, ACT_INST_CODE))
/

