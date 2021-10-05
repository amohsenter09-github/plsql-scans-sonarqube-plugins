CREATE TABLE VMSCMS.CMS_SMSEMAIL_DAILY_ALTMSG_HIST
(
  CSD_INST_CODE       NUMBER(10),
  CSD_SERIAL_NO       VARCHAR2(10 BYTE)         NOT NULL,
  CSD_PAN_CODE        VARCHAR2(90 BYTE)         NOT NULL,
  CSD_PAN_CODE_ENCR   RAW(100),
  CSD_MOBILE_NUMBER   VARCHAR2(20 BYTE),
  CSD_EMAIL           VARCHAR2(50 BYTE),
  CSD_DAILYBAL_MSG    VARCHAR2(1000 BYTE),
  CSD_LOWBAL_MSG      VARCHAR2(1000 BYTE),
  CSD_INS_DATE        DATE,
  CSD_BEGIN_INTERVAL  DATE,
  CSD_END_INTERVAL    DATE,
  CSD_PROCESS_STATUS  CHAR(1 BYTE),
  CSD_PROCESS_DATE    DATE
)
TABLESPACE CMS_HIST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


