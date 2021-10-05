CREATE TABLE VMSCMS.CMS_HOTLIST_DETAIL
(
  CHD_INST_CODE     NUMBER(3),
  CHD_CARD_NO       VARCHAR2(90 BYTE),
  CHD_FILE_NAME     VARCHAR2(30 BYTE),
  CHD_REMARKS       VARCHAR2(100 BYTE),
  CHD_MSG24_FLAG    CHAR(1 BYTE)                DEFAULT 'N',
  CHD_PROCESS_FLAG  VARCHAR2(1 BYTE),
  CHD_PROCESS_MSG   VARCHAR2(300 BYTE),
  CHD_PROCESS_MODE  VARCHAR2(1 BYTE),
  CHD_INS_USER      NUMBER(5),
  CHD_INS_DATE      DATE,
  CHD_LUPD_USER     NUMBER(5),
  CHD_LUPD_DATE     DATE,
  CHD_CARD_NO_ENCR  RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


