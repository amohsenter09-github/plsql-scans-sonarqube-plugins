CREATE TABLE VMSCMS.CMS_PRLK_MAST
(
  CPM_SBPG_CODE  NUMBER(8)                      NOT NULL,
  CPM_PRLK_CODE  NUMBER(8)                      NOT NULL,
  CPM_PROG_URL   VARCHAR2(400 BYTE)             NOT NULL,
  CPM_PROG_DESC  VARCHAR2(200 BYTE),
  CPM_PROG_KEYS  VARCHAR2(200 BYTE),
  CPM_INS_USER   NUMBER                         NOT NULL,
  CPM_INS_DATE   DATE                           NOT NULL,
  CPM_LUPD_USER  NUMBER,
  CPM_LUPD_DATE  DATE
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_PRLK_MAST ADD (
  CONSTRAINT FK_CPM_INS_CUM_USID 
 FOREIGN KEY (CPM_INS_USER) 
 REFERENCES VMSCMS.CMS_USERDETL_MAST (CUM_USER_CODE))
/

