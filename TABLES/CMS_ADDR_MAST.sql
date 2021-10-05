CREATE TABLE VMSCMS.CMS_ADDR_MAST
(
  CAM_INST_CODE         NUMBER(3)               NOT NULL,
  CAM_CUST_CODE         NUMBER(10),
  CAM_ADDR_CODE         NUMBER(10)              NOT NULL,
  CAM_ADD_ONE           VARCHAR2(50 BYTE)       NOT NULL,
  CAM_ADD_TWO           VARCHAR2(50 BYTE),
  CAM_ADD_THREE         VARCHAR2(50 BYTE),
  CAM_PIN_CODE          VARCHAR2(15 BYTE),
  CAM_PHONE_ONE         VARCHAR2(40 BYTE),
  CAM_PHONE_TWO         VARCHAR2(40 BYTE),
  CAM_CNTRY_CODE        NUMBER(3)               NOT NULL,
  CAM_CITY_NAME         VARCHAR2(40 BYTE)       NOT NULL,
  CAM_FAX_ONE           VARCHAR2(20 BYTE),
  CAM_ADDR_FLAG         CHAR(1 BYTE),
  CAM_STATE_SWITCH      VARCHAR2(3 BYTE),
  CAM_INS_USER          NUMBER(5)               NOT NULL,
  CAM_INS_DATE          DATE                    NOT NULL,
  CAM_LUPD_USER         NUMBER(5)               NOT NULL,
  CAM_LUPD_DATE         DATE                    NOT NULL,
  CAM_EMAIL             VARCHAR2(50 BYTE),
  CAM_ADD_FOUR          VARCHAR2(50 BYTE),
  CAM_MOBL_ONE          VARCHAR2(40 BYTE),
  CAM_STATE_CODE        NUMBER(3),
  CAM_COMM_TYPE         CHAR(1 BYTE),
  CAM_ADDRMAST_PARAM1   VARCHAR2(100 BYTE),
  CAM_ADDRMAST_PARAM2   VARCHAR2(100 BYTE),
  CAM_ADDRMAST_PARAM3   VARCHAR2(100 BYTE),
  CAM_ADDRMAST_PARAM4   VARCHAR2(100 BYTE),
  CAM_ADDRMAST_PARAM5   VARCHAR2(100 BYTE),
  CAM_ADDRMAST_PARAM6   VARCHAR2(100 BYTE),
  CAM_ADDRMAST_PARAM7   VARCHAR2(100 BYTE),
  CAM_ADDRMAST_PARAM8   VARCHAR2(100 BYTE),
  CAM_ADDRMAST_PARAM9   VARCHAR2(100 BYTE),
  CAM_ADDRMAST_PARAM10  VARCHAR2(100 BYTE)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_ADDR_MAST ADD (
  CONSTRAINT PK_ADDR_MAST
 PRIMARY KEY
 (CAM_INST_CODE, CAM_ADDR_CODE))
/

ALTER TABLE VMSCMS.CMS_ADDR_MAST ADD (
  CONSTRAINT FK_ADDRMAST_CNTRYMAST 
 FOREIGN KEY (CAM_INST_CODE, CAM_CNTRY_CODE) 
 REFERENCES VMSCMS.GEN_CNTRY_MAST (GCM_INST_CODE,GCM_CNTRY_CODE),
  CONSTRAINT FK_STATE_MAST_STATE_CODE 
 FOREIGN KEY (CAM_INST_CODE, CAM_CNTRY_CODE, CAM_STATE_CODE) 
 REFERENCES VMSCMS.GEN_STATE_MAST (GSM_INST_CODE,GSM_CNTRY_CODE,GSM_STATE_CODE),
  CONSTRAINT FK_ADDRMAST_USERMAST1 
 FOREIGN KEY (CAM_INS_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_ADDRMAST_USERMAST2 
 FOREIGN KEY (CAM_LUPD_USER) 
 REFERENCES VMSCMS.CMS_USER_MAST (CUM_USER_PIN),
  CONSTRAINT FK_ADDRMAST_CUSTMAST 
 FOREIGN KEY (CAM_INST_CODE, CAM_CUST_CODE) 
 REFERENCES VMSCMS.CMS_CUST_MAST (CCM_INST_CODE,CCM_CUST_CODE))
/

