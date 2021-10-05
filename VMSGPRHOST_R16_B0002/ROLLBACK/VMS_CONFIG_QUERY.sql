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
      AND object_name = 'VMS_CONFIG_QUERY_R16B2';

   IF v_chk_tab = 1
   THEN

			
					UPDATE vmscms.VMS_CONFIG_QUERY a
				SET
					vcq_query_value = (
						SELECT
							vcq_query_value
						FROM
							vmscms.VMS_CONFIG_QUERY_R16B2 b
						WHERE
							a.vcq_query_id = b.vcq_query_id
					)
			WHERE
				vcq_query_id ='CCF_CARDSTOCK_QRY';
       
      DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Updated ');
	  
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
