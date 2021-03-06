CREATE TABLE VMSCMS.MIGR_FILE_DETL
(
  MFD_MIGR_TYPE       VARCHAR2(50 BYTE),
  MFD_FILE_NAME       VARCHAR2(50 BYTE),
  MFD_FILE_HEADER     VARCHAR2(100 BYTE),
  MFD_FILE_REC_CNT    NUMBER(15),
  MFD_SUCC_REC_CNT    NUMBER(6),
  MFD_ERR_REC_CNT     NUMBER(6),
  MFD_FILE_LOAD_FLAG  VARCHAR2(1 BYTE),
  MFD_INS_DATE        DATE,
  MFD_PROCESS_MSG     VARCHAR2(4000 BYTE)
);
