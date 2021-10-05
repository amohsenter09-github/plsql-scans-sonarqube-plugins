CREATE TABLE vmscms.migr_callog_data_excp
(
mcd_file_name       VARCHAR2 (50 Byte),
mcd_record_number   NUMBER (20),
mcd_card_number     VARCHAR2 (19 Byte),
mcd_process_flag    VARCHAR2 (1 Byte),    
mcd_process_msg     VARCHAR2 (4000 Byte),  
mcd_ins_date        date,
mcd_sql_err         date
);