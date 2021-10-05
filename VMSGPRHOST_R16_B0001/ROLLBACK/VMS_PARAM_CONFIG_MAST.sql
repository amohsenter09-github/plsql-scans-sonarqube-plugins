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
      AND object_name = 'VMS_PARAM_CONFIG_MAST_R16B1';

   IF v_chk_tab = 1
   THEN
   	
      DELETE FROM VMSCMS.VMS_PARAM_CONFIG_MAST
            WHERE (VPC_PARAM_TYPE,
                   VPC_PARAM_ID,
                   VPC_PARAM_NAME) IN (
                      SELECT VPC_PARAM_TYPE,
                             VPC_PARAM_ID,
                             VPC_PARAM_NAME
                        FROM VMSCMS.VMS_PARAM_CONFIG_MAST_R16B1);

      DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows deleted ');
	  
	 
ELSE
      DBMS_OUTPUT.put_line ('Insert Backup Object Not Found');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      v_err := SUBSTR (SQLERRM, 1, 100);
      DBMS_OUTPUT.put_line ('Main Excp ' || v_err);
END;
/