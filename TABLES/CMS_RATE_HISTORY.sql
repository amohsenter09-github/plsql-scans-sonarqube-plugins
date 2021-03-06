CREATE TABLE VMSCMS.CMS_RATE_HISTORY
(
  CRH_INST_CODE        NUMBER(10)               NOT NULL,
  CRH_RATETABLE_ID     NUMBER(9),
  CRH_CURRENCYPAIR_ID  VARCHAR2(10 BYTE),
  CRH_EFFECTIVE_DATE   DATE,
  CRH_RATE_VALUE       NUMBER(15,2),
  CRH_LAST_USER        NUMBER(10),
  CRH_LAST_DATE        DATE,
  CRH_RATE_FILE        VARCHAR2(75 BYTE),
  CRH_LUPD_DATE        DATE,
  CRH_LUPD_USER        NUMBER(10),
  CRH_INS_DATE         DATE,
  CRH_INS_USER         NUMBER(10)
)
TABLESPACE CMS_HIST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


