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
      DELETE FROM vmscms.PCMS_PROCESS_SCHEDULE
            WHERE (PPS_PROCESS_ID
                  ) IN (
                     SELECT PPS_PROCESS_ID
                       FROM vmscms.PCMS_PROCESS_SCHEDULE_R16B2);
					   
			      DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows deleted ');		   
					   
		  
   ELSE
      DBMS_OUTPUT.put_line ('Backup Object Not Found');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      v_err := SUBSTR (SQLERRM, 1, 100);
      DBMS_OUTPUT.put_line ('Main Excp ' || v_err);
END;
/