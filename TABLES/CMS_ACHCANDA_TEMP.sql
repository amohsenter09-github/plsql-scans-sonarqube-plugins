CREATE TABLE VMSCMS.CMS_ACHCANDA_TEMP
(
  CAT_BATCH_NO     NUMBER(10),
  CAT_FILE_NAME     VARCHAR2(255),
  CAT_REC_NO        NUMBER(10),
  CAT_ACH_REC       VARCHAR2(4000),
  CAT_ACH_DATA      vmscms.C_ACH_TYPE,
  CAT_PROC_STAT     CHAR(1)                DEFAULT 'P',
  CAT_INS_DATE      DATE                   DEFAULT SYSDATE,
  CAT_PROCESS_DATE  DATE
)
TABLESPACE CMS_BIG_TXN;

create index VMSCMS.indx_achcan_filename on VMSCMS.CMS_ACHCANDA_TEMP(cat_file_name) TABLESPACE CMS_BIG_IDX;