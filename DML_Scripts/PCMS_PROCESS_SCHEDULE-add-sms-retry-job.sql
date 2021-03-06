INSERT INTO PCMS_PROCESS_SCHEDULE
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
VALUES      ((select max(pps_process_id) + 5 from PCMS_PROCESS_SCHEDULE),
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
commit;

-- select * from pcms_process_schedule where pps_process_name = 'SMS RETRY';

-- Revert Script
-- delete from pcms_process_schedule  where pps_process_name = 'SMS RETRY';