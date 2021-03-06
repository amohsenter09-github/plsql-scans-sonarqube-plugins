CREATE TABLE VMSCMS.PCMS_CALLCENTER_LOG
(
  PCL_INST_CODE     NUMBER(5),
  PCL_CARD_NO       VARCHAR2(20 BYTE),
  PCL_SERV_REQID    VARCHAR2(20 BYTE),
  PCL_USER_PIN      NUMBER(5),
  PCL_LOG_STATUS    VARCHAR2(1 BYTE),
  PCL_VERIFIED_DTL  VARCHAR2(150 BYTE),
  PCL_LOG_MESSAGE   VARCHAR2(500 BYTE)          DEFAULT 'NOT PROCESSED',
  PCL_INS_USER      NUMBER(5),
  PCL_INS_DATE      DATE,
  PCL_LUPD_USER     NUMBER(5),
  PCL_LUPD_DATE     DATE,
  PCL_LOG_REQUEST   VARCHAR2(100 BYTE)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


