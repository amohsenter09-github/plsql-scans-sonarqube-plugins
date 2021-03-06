CREATE TABLE VMSCMS.CMS_STORE_ID
(
  CSI_INST_CODE   NUMBER(3)                     NOT NULL,
  CSI_STORE_ID    VARCHAR2(10 BYTE)             NOT NULL,
  CSI_STORE_NAME  VARCHAR2(50 BYTE)             NOT NULL,
  CSI_ADDR_ONE    VARCHAR2(50 BYTE)             NOT NULL,
  CSI_ADDR_TWO    VARCHAR2(50 BYTE),
  CSI_CITY        VARCHAR2(50 BYTE)             NOT NULL,
  CSI_ZIP_CODE    VARCHAR2(50 BYTE)             NOT NULL,
  CSI_STATE       VARCHAR2(50 BYTE)             NOT NULL,
  CSI_INS_USER    NUMBER(5)                     NOT NULL,
  CSI_INS_DATE    DATE                          NOT NULL,
  CSI_LUPD_USER   NUMBER(5)                     NOT NULL,
  CSI_LUPD_DATE   DATE                          NOT NULL
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_STORE_ID ADD (
  CONSTRAINT STORE_ID_PK
 PRIMARY KEY
 (CSI_STORE_ID))
/

