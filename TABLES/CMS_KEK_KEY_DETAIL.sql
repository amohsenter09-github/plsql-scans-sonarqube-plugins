CREATE TABLE VMSCMS.CMS_KEK_KEY_DETAIL
(
  CKK_INST_CODE      NUMBER(3)                  NOT NULL,
  CKK_KEK_INDEX      VARCHAR2(3 BYTE),
  CKK_KEK_NAME       VARCHAR2(200 BYTE)         NOT NULL,
  CKK_ENCRYPTED_KEK  VARCHAR2(200 BYTE)         NOT NULL,
  CKK_INS_USER       NUMBER(5),
  CKK_INS_DATE       DATE,
  CKK_LUPD_USER      NUMBER(5),
  CKK_LUPD_DATE      DATE
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_KEK_KEY_DETAIL ADD (
  CONSTRAINT PK_KEK_KEY_DETAIL
 PRIMARY KEY
 (CKK_KEK_INDEX),
  CONSTRAINT UK_KEK_KEY_DETAIL
 UNIQUE (CKK_INST_CODE, CKK_KEK_NAME))
/

