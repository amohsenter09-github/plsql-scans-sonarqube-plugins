CREATE TABLE vmscms.VMS_RAN_FILE_DETL
(	
	VRD_BATCH_ID VARCHAR2(20),
	VRD_PROGRAM_IDENTIFIER VARCHAR2(20),
	VRD_BATCH_RECCOUNT	NUMBER(20,0),
	VRD_PROGRAM_TOT_CNT	NUMBER(20,0),	
	VRD_PROGRAM_RANGE_TOT_CNT		NUMBER(20,0),
	VRD_PROGRAM_ADD_CNT	NUMBER(20,0),
	VRD_PROGRAM_UPD_CNT	NUMBER(20,0),
	VRD_PROGRAM_NOCHANGE_CNT	NUMBER(20,0),
	VRD_PROGRAM_ERR_CNT	NUMBER(20,0),
	VRD_MERCHANT_TOT_CNT	NUMBER(20,0),
	VRD_MERCHANT_ADD_CNT	NUMBER(20,0),
	VRD_MERCHANT_UPD_CNT	NUMBER(20,0),
	VRD_MERCHANT_NOCHANGE_CNT	NUMBER(20,0),
	VRD_MERCHANT_ERR_CNT	NUMBER(20,0),
	VRD_PROCESS_FLAG	CHAR(1) DEFAULT 'N',
	VRD_PROCESS_DETL	VARCHAR2(1000),
	VRD_PROCESS_DATE	DATE,
	CONSTRAINT FK_RAN_FILE_DETL FOREIGN KEY (VRD_BATCH_ID) REFERENCES vmscms.VMS_RAN_FILE (VRF_BATCH_ID)
);

CREATE INDEX vmscms.IND_RAN_FILEDETL_BATCHID ON vmscms.VMS_RAN_FILE_DETL(VRD_BATCH_ID);