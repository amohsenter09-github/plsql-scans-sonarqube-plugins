
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
      AND object_name = 'VMS_FSAPI_VALIDATION_R16B1';

   IF v_chk_tab = 1
   THEN
   
   
		 UPDATE vmscms.VMS_FSAPI_VALIDATIONDTLS A SET VFV_FIELD_VALUES= (SELECT 
		 VFV_FIELD_VALUES FROM vmscms.VMS_FSAPI_VALIDATION_R16B1 B 
		 WHERE A.VFV_API_NAME = B.VFV_API_NAME AND 
			   A.VFV_FIELD_NAME = B. VFV_FIELD_NAME AND 
			   A.VFV_REQUEST_METHOD = B.VFV_REQUEST_METHOD )
			   WHERE VFV_API_NAME = 'ORDER' AND VFV_FIELD_NAME = 'shippingMethod';

	    DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Updated ');
			  
	 
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

