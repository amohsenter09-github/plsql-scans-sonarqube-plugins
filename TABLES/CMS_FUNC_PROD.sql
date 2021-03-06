CREATE TABLE VMSCMS.CMS_FUNC_PROD
(
  CFP_INST_CODE     NUMBER(5)                   NOT NULL,
  CFP_PROD_CODE     VARCHAR2(10 BYTE)           NOT NULL,
  CFP_FUNC_CODE     VARCHAR2(10 BYTE)           NOT NULL,
  CFP_DRGL_CATG     VARCHAR2(10 BYTE),
  CFP_DRGL_CODE     VARCHAR2(15 BYTE),
  CFP_DRSUBGL_CODE  VARCHAR2(15 BYTE),
  CFP_CRGL_CODE     VARCHAR2(15 BYTE),
  CFP_CRGL_CATG     VARCHAR2(10 BYTE),
  CFP_CRSUBGL_CODE  VARCHAR2(15 BYTE),
  CFP_CRACCT_NO     VARCHAR2(20 BYTE),
  CFP_DRACCT_NO     VARCHAR2(20 BYTE)           DEFAULT null,
  CFP_INST_DATE     DATE                        NOT NULL,
  CFP_LUPD_USER     NUMBER(5)                   NOT NULL,
  CFP_LUPD_DATE     DATE                        NOT NULL,
  CFP_PROD_CATTYPE  NUMBER(2),
  CFP_INS_USER      NUMBER(10)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_FUNC_PROD ADD (
  CONSTRAINT PK_GLMAPPING_FUNC
 PRIMARY KEY
 (CFP_INST_CODE, CFP_PROD_CODE, CFP_PROD_CATTYPE, CFP_FUNC_CODE))
/

ALTER TABLE VMSCMS.CMS_FUNC_PROD ADD (
  CONSTRAINT FK_FCODE_FUNCMAST 
 FOREIGN KEY (CFP_INST_CODE, CFP_FUNC_CODE) 
 REFERENCES VMSCMS.CMS_FUNC_MAST (CFM_INST_CODE,CFM_FUNC_CODE))
/

