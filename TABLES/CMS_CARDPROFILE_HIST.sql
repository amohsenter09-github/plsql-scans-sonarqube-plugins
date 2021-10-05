CREATE TABLE VMSCMS.CMS_CARDPROFILE_HIST
(
  CCP_PAN_CODE       VARCHAR2(90 BYTE)          NOT NULL,
  CCP_INST_CODE      NUMBER(3),
  CCP_ADD_ONE        VARCHAR2(50 BYTE),
  CCP_CITY_NAME      VARCHAR2(25 BYTE),
  CCP_PIN_CODE       VARCHAR2(15 BYTE),
  CCP_PHONE_ONE      VARCHAR2(40 BYTE),
  CCP_EMAIL          VARCHAR2(40 BYTE),
  CCP_STATE_CODE     NUMBER(3),
  CCP_CNTRY_CODE     NUMBER(3),
  CCP_CUST_CODE      NUMBER(10),
  CCP_SSN            VARCHAR2(10 BYTE),
  CCP_BIRTH_DATE     DATE,
  CCP_FIRST_NAME     VARCHAR2(40 BYTE),
  CCP_MID_NAME       VARCHAR2(30 BYTE),
  CCP_LAST_NAME      VARCHAR2(30 BYTE),
  CCP_PAN_CODE_ENCR  RAW(100),
  CCP_INS_DATE       DATE,
  CCP_LUPD_DATE      DATE,
  CCP_MBR_NUMB       VARCHAR2(3 BYTE),
  CCP_AUTH_ID        VARCHAR2(6 BYTE),
  CCP_RRN            VARCHAR2(20 BYTE),
  CCP_STAN           VARCHAR2(12 BYTE),
  CCP_BUSINESS_DATE  VARCHAR2(8 BYTE),
  CCP_BUSINESS_TIME  VARCHAR2(10 BYTE),
  CCP_TERMINAL_ID    VARCHAR2(20 BYTE),
  CCP_ADD_TWO        VARCHAR2(50 BYTE),
  CCP_MOBL_ONE       VARCHAR2(40 BYTE)
)
TABLESPACE CMS_HIST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_CARDPROFILE_HIST ADD (
  CONSTRAINT FK_CRDPRFLHST_APPLPAN 
 FOREIGN KEY (CCP_PAN_CODE, CCP_MBR_NUMB) 
 REFERENCES VMSCMS.CMS_APPL_PAN (CAP_PAN_CODE,CAP_MBR_NUMB))
/

