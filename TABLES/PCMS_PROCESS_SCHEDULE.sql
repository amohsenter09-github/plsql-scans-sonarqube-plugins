ALTER TABLE vmscms.PCMS_PROCESS_SCHEDULE ADD
(
PPS_MULTIRUN_INTERVAL	NUMBER(5,0),
PPS_MULTIRUN_INTERVAL_TYPE VARCHAR2(20 BYTE),
PPS_MULTIRUN_FLAG	VARCHAR2(20 BYTE)
);