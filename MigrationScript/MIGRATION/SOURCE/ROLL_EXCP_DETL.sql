SET DEFINE ON;
SPOOL $VMS_HOME/MIGRATION/ROLL_EXCP_DETL.log

SELECT MDR_FILE_NAME FILE_NAME,MDR_MIGR_SEQNO MIGR_SEQNO ,MDR_REASON REASON
FROM VMSCMS.MIGR_DET_ROLL_EXCP
WHERE MDR_MIGR_SEQNO = &migr_seq;

SPOOL OFF;