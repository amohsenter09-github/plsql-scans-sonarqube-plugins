CREATE TABLE VMSCMS.CMS_BRAN_REFRESHGRP
(
  CBR_INST_CODE  NUMBER(3)                      NOT NULL,
  CBR_BRAN_CODE  VARCHAR2(6 BYTE),
  CBR_RFRSH_GRP  VARCHAR2(4 BYTE),
  CBR_INS_USER   NUMBER(5)                      NOT NULL,
  CBR_INS_DATE   DATE                           NOT NULL,
  CBR_LUPD_USER  NUMBER(5)                      NOT NULL,
  CBR_LUPD_DATE  DATE                           NOT NULL
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_BRAN_REFRESHGRP ADD (
  CONSTRAINT UK_BRAN_CODE
 PRIMARY KEY
 (CBR_INST_CODE, CBR_BRAN_CODE))
/

