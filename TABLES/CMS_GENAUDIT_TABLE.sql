CREATE TABLE VMSCMS.CMS_GENAUDIT_TABLE
(
  CGT_INST_CODE        NUMBER(3),
  CGT_TABLE_ID         NUMBER(5),
  CGT_COLUMN_NAME      VARCHAR2(60 BYTE),
  CGT_COLUMN_ALIAS     VARCHAR2(60 BYTE),
  CGT_COLUMN_FLAG      CHAR(1 BYTE)             NOT NULL,
  CGT_INS_USER         NUMBER(5),
  CGT_INS_DATE         DATE,
  CGT_LUPD_USER        NUMBER(5),
  CGT_LUPD_DATE        DATE,
  CGT_MASTER_TABLE     VARCHAR2(60 BYTE),
  CGT_MASTER_COLUMN    VARCHAR2(60 BYTE),
  CGT_MASTER_COMPARE   VARCHAR2(60 BYTE),
  CGT_MASTER_COMPARE1  VARCHAR2(60 BYTE),
  CGT_MASTER_COMPARE2  VARCHAR2(60 BYTE),
  CGT_MASTER_COMPARE3  VARCHAR2(60 BYTE),
  CGT_MASTER_COMPARE4  VARCHAR2(60 BYTE)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_GENAUDIT_TABLE ADD (
  CONSTRAINT UK_COLNAME_ID
 UNIQUE (CGT_INST_CODE, CGT_TABLE_ID, CGT_COLUMN_NAME))
/

ALTER TABLE VMSCMS.CMS_GENAUDIT_TABLE ADD (
  CONSTRAINT FK_AUDITTABLE_USERMAST2 
 FOREIGN KEY (CGT_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_AUDITTABLE_USERMAST1 
 FOREIGN KEY (CGT_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_AUDITMAST_AUDITABLE 
 FOREIGN KEY (CGT_INST_CODE, CGT_TABLE_ID) 
 REFERENCES VMSCMS.CMS_GENAUDIT_MAST (CGM_INST_CODE,CGM_TABLE_ID))
/

