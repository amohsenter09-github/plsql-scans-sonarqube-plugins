set serveroutput on;
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
      AND object_name = 'CMS_INST_PARAM_R16B6';

   IF v_chk_tab = 1
   THEN      	  
   
		 
		
	
		   UPDATE vmscms.CMS_INST_PARAM SET CIP_DISPLAY_FLAG = 'Y', CIP_PARAM_DISP_TYPE = 'TEXT' 
		   WHERE cip_param_key = 'CHARGEBACK_TIMEFRAME';
						 

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