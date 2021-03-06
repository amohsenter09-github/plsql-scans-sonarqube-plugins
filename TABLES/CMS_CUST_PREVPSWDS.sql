CREATE TABLE VMSCMS.CMS_CUST_PREVPSWDS
(
  CCP_INST_CODE  NUMBER(3)                      NOT NULL,
  CCP_USER_PIN   NUMBER(5)                      NOT NULL,
  CCP_PREV_PSWD  VARCHAR2(100 BYTE)             NOT NULL,
  CCP_PSWD_DATE  DATE                           NOT NULL,
  CCP_LUPD_DATE  DATE,
  CCP_INS_DATE   DATE
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


