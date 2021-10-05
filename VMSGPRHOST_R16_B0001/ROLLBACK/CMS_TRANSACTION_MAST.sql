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
      AND object_name = 'CMS_TRANSACTION_MAST_R16B1';

   IF v_chk_tab = 1
   THEN
      DELETE FROM vmscms.CMS_TRANSACTION_MAST
            WHERE (CTM_INST_CODE,
                   CTM_DELIVERY_CHANNEL,
                   CTM_TRAN_CODE) IN 
					(
					SELECT CTM_INST_CODE,
                           CTM_DELIVERY_CHANNEL,
                           CTM_TRAN_CODE
					FROM VMSCMS.CMS_TRANSACTION_MAST_R16B1);

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
