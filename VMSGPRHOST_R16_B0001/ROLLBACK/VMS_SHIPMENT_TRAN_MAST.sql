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
      AND object_name = 'VMS_SHIPMENT_TRAN_MAST_R16B1';

   IF v_chk_tab = 1
   THEN
   
			 DELETE FROM VMSCMS.VMS_SHIPMENT_TRAN_MAST
            WHERE (vsm_shipment_id,vsm_shipment_key,
					vsm_shipment_desc,vsm_cca_trancode) IN (
                      SELECT vsm_shipment_id,vsm_shipment_key,
							vsm_shipment_desc,vsm_cca_trancode
                        FROM VMSCMS.VMS_SHIPMENT_TRAN_MAST_R16B1);
        
		 
	   	   
         DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows DELETED ');
		 
	 
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