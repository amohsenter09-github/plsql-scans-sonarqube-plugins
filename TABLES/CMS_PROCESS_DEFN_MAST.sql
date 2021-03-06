CREATE TABLE VMSCMS.CMS_PROCESS_DEFN_MAST
(
  CPM_INST_CODE          NUMBER(3),
  CPM_PROCESS_ID         NUMBER(5),
  CPM_FILE_ID1           NUMBER(20),
  CPM_FILE1_PATH         VARCHAR2(100 BYTE),
  CPM_FILE1MENU_CAPTION  VARCHAR2(20 BYTE),
  CPM_EXTRN_FILTER1      NUMBER(20),
  CPM_FILTER_FLAG1       VARCHAR2(1 BYTE),
  CPM_FILE1_TAB_NAME     VARCHAR2(30 BYTE),
  CPM_FILE_ID2           NUMBER(20),
  CPM_FILE2_PATH         VARCHAR2(100 BYTE),
  CPM_FILE2MENU_CAPTION  VARCHAR2(20 BYTE),
  CPM_EXTRN_FILTER2      NUMBER(20),
  CPM_FILTER_FLAG2       VARCHAR2(1 BYTE),
  CPM_FILE2_TAB_NAME     VARCHAR2(30 BYTE),
  CPM_INS_USER           NUMBER(5),
  CPM_LUPD_USER          NUMBER(5),
  CPM_INS_DATE           DATE,
  CPM_LUPD_DATE          DATE,
  CPM_PROCESS_NAME       VARCHAR2(50 BYTE),
  CPM_PROCESS_SHORTNAME  VARCHAR2(20 BYTE),
  CPM_OUTFILE_PATH       VARCHAR2(100 BYTE),
  CPM_MENU_CAPTION       VARCHAR2(20 BYTE)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_PROCESS_DEFN_MAST ADD (
  CONSTRAINT PK_CPM_PROCESS_ID
 PRIMARY KEY
 (CPM_PROCESS_ID))
/

ALTER TABLE VMSCMS.CMS_PROCESS_DEFN_MAST ADD (
  CONSTRAINT FK_CPM_INST_CODE 
 FOREIGN KEY (CPM_INST_CODE) 
 REFERENCES VMSCMS.CMS_INST_MAST (CIM_INST_CODE),
  CONSTRAINT FK_CPM_FILE_ID1 
 FOREIGN KEY (CPM_FILE_ID1) 
 REFERENCES VMSCMS.CMS_FILE_DEFIN_MAST (CFD_FILE_ID),
  CONSTRAINT FK_CPM_FILE_ID2 
 FOREIGN KEY (CPM_FILE_ID2) 
 REFERENCES VMSCMS.CMS_FILE_DEFIN_MAST (CFD_FILE_ID))
/

