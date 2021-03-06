CREATE TABLE VMSCMS.CMS_GROUP_CHNGADDR_TEMP
(
  CGT_CARD_NO       VARCHAR2(90 BYTE)           NOT NULL,
  CGT_MBR_NUMB      VARCHAR2(10 BYTE),
  CGT_FILE_NAME     VARCHAR2(30 BYTE),
  CGT_REMARKS       VARCHAR2(100 BYTE),
  CGT_DISP_NAME     VARCHAR2(50 BYTE),
  CGT_ADDR1         VARCHAR2(50 BYTE),
  CGT_ADDR2         VARCHAR2(50 BYTE),
  CGT_CITY_NAME     VARCHAR2(25 BYTE),
  CGT_STATE_SWITCH  VARCHAR2(3 BYTE),
  CGT_PIN_CODE      VARCHAR2(9 BYTE),
  CGT_CNTRY_CODE    VARCHAR2(3 BYTE),
  CGT_PHONE_ONE     VARCHAR2(20 BYTE),
  CGT_PHONE_TWO     VARCHAR2(20 BYTE),
  CGT_PROCESS_FLAG  VARCHAR2(1 BYTE)            DEFAULT 'N',
  CGT_PROCESS_MSG   VARCHAR2(300 BYTE)          DEFAULT 'Not Processed',
  CGT_LUPD_DATE     DATE,
  CGT_INST_CODE     NUMBER(10),
  CGT_LUPD_USER     NUMBER(10),
  CGT_INS_DATE      DATE,
  CGT_INS_USER      NUMBER(10),
  CGT_ADDR3         VARCHAR2(50 BYTE),
  CGT_FAX           NUMBER(20),
  CGT_CUST_CODE     NUMBER(10),
  CGT_CARD_NO_ENCR  RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


