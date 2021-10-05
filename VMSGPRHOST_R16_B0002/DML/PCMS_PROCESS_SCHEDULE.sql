DECLARE
   v_chk_tab   VARCHAR2 (10);
   v_err       VARCHAR2 (1000);
   v_cnt       NUMBER (2);
BEGIN
   
	SELECT COUNT (1)
	INTO v_chk_tab
	FROM all_objects
	WHERE object_type = 'TABLE'
	AND owner = 'VMSCMS'
	AND object_name = 'PCMS_PROCESS_SCHEDULE_R16B2';

	IF v_chk_tab = 1
	THEN
	
		SELECT COUNT(1) 
		INTO v_cnt 
		FROM vmscms.PCMS_PROCESS_SCHEDULE
		WHERE PPS_PROCESS_ID = (select max(pps_process_id) + 1 from vmscms.PCMS_PROCESS_SCHEDULE);

		IF v_cnt = 0
		THEN 
		
			INSERT
			INTO vmscms.PCMS_PROCESS_SCHEDULE_R16B2
            (pps_process_id,
             pps_process_name,
             pps_process_interval,
             pps_schedule_days,
             pps_ins_user,
             pps_ins_date,
             pps_start_hour,
             pps_start_min,
             pps_start_sec,
             pps_end_hour,
             pps_end_min,
             pps_end_sec,
             pps_file_id,
             pps_process_type,
             pps_procinterval_type,
             pps_retry_cnt,
             pps_dep_subprocessid,
             pps_scheduler_stat,
             pps_mail_success,
             pps_mail_fail,
             pps_dep_processid,
             pps_proc_running,
             pps_procretry_date,
             pps_inst_code,
             pps_process_class,
             pps_process_job,
             pps_process_jobgroup,
             pps_process_trgr,
             pps_process_trgrgroup,
             pps_proccomplete_flag,
             pps_proccomplete_date,
             pps_event_type,
             pps_front_config,
             pps_dayof_month,
             pps_multirun_interval,
             pps_multirun_interval_type,
             pps_multirun_flag,
             pps_variable_count,
             pps_variable_interval
             )
VALUES      ((select max(pps_process_id) + 1 from vmscms.PCMS_PROCESS_SCHEDULE),
             'SMS RETRY',
             1,
             NULL,
             1,
             sysdate,
             '0',
             '0',
             '0',
             '0',
             '0',
             '0',
             1,
             'E',
             'MM',
             0,
             NULL,
             'D',
             '1',
             '1',
             NULL,
             'N',
             sysdate,
             1,
             'cmsServlets.scheduler.EcnsRetryJob',
             'EcnsRetryJob',
             'EcnsRetryJobGroup',
             'EcnsRetryTrigger',
             'EcnsRetryTriggerGroup',
             'N',
             sysdate,
             'O',
             'Y',
             NULL,
             NULL,
             NULL,
             'D',
             0,
             NULL
             );


			
		END IF;
		
			INSERT INTO VMSCMS.PCMS_PROCESS_SCHEDULE
            SELECT *
              FROM VMSCMS.PCMS_PROCESS_SCHEDULE_R16B2
             WHERE PPS_PROCESS_ID NOT IN (
                       SELECT PPS_PROCESS_ID
                         FROM VMSCMS.PCMS_PROCESS_SCHEDULE);
						 

      DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Inserted ');
	

    ELSE
       DBMS_OUTPUT.put_line (' Backup Object Not Found');
    END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      v_err := SUBSTR (SQLERRM, 1, 100);
      DBMS_OUTPUT.put_line ('Main Excp ' || v_err);
END;
/