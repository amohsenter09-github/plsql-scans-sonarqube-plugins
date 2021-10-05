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
      AND object_name = 'CMS_INST_PARAM_R16B3';

   IF v_chk_tab = 1
   THEN      	  
   
		DELETE FROM VMSCMS.CMS_INST_PARAM
            WHERE (CIP_INST_CODE,
				   CIP_PARAM_KEY,
				   CIP_PARAM_VALUE) IN (
                      SELECT CIP_INST_CODE,
				             CIP_PARAM_KEY,
				             CIP_PARAM_VALUE
                        FROM VMSCMS.CMS_INST_PARAM_R16B3);
						 

      DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Deleted ');
	  
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