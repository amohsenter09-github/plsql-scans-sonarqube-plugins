CREATE TABLE VMSCMS.CMS_FEE_FREQ
(
  CFF_FREQ_KEY   VARCHAR2(2 BYTE)               NOT NULL,
  CFF_FREQ_DESC  VARCHAR2(50 BYTE)              NOT NULL,
  CFF_INS_USER   NUMBER(5),
  CFF_LUPD_USER  NUMBER(5),
  CFF_INS_DATE   DATE,
  CFF_LUPD_DATE  DATE,
  CFF_FEE_FREQ   NUMBER(3),
  CFF_INST_CODE  NUMBER(10)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_FEE_FREQ ADD (
  CONSTRAINT PK_FEE_FREQ
 PRIMARY KEY
 (CFF_FREQ_KEY))
/

