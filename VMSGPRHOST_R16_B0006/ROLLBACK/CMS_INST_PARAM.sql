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
   
		   UPDATE vmscms.CMS_INST_PARAM A SET (CIP_DISPLAY_FLAG,CIP_PARAM_DISP_TYPE) = (
		   SELECT CIP_DISPLAY_FLAG,CIP_PARAM_DISP_TYPE FROM vmscms.CMS_INST_PARAM_R16B6 B
		    WHERE A.CIP_INST_CODE = B.CIP_INST_CODE AND A.CIP_PARAM_KEY = B.CIP_PARAM_KEY
			AND A.CIP_PARAM_VALUE =B.CIP_PARAM_VALUE)WHERE cip_param_key = 'CHARGEBACK_TIMEFRAME';
		
	 
						 

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