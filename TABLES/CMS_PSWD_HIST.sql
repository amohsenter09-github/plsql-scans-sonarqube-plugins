CREATE TABLE VMSCMS.CMS_PSWD_HIST
(
  CPH_USER_CODE  NUMBER(8)                      NOT NULL,
  CPH_PSWD_TYPE  NUMBER(1)                      NOT NULL,
  CPH_OLD_PSWD   VARCHAR2(200 BYTE)             NOT NULL,
  CPH_NEW_PSWD   VARCHAR2(200 BYTE)             NOT NULL,
  CPH_INS_USER   NUMBER(8)                      NOT NULL,
  CPH_INS_DATE   DATE                           NOT NULL,
  CPH_PWCH_RESN  VARCHAR2(200 BYTE)
)
TABLESPACE CMS_HIST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_PSWD_HIST ADD (
  CONSTRAINT FK_CPH_PWIN_CUM_USID 
 FOREIGN KEY (CPH_INS_USER) 
 REFERENCES VMSCMS.CMS_USERDETL_MAST (CUM_USER_CODE),
  CONSTRAINT FK_CPH_PWUS_CUM_USID 
 FOREIGN KEY (CPH_USER_CODE) 
 REFERENCES VMSCMS.CMS_USERDETL_MAST (CUM_USER_CODE))
/

