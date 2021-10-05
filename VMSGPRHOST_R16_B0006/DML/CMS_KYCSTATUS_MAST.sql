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
      AND object_name = 'CMS_KYCSTATUS_MAST_R16B6';

   IF v_chk_tab = 1
   THEN
   
			 SELECT COUNT (1)
				INTO v_cnt
				FROM VMSCMS.CMS_KYCSTATUS_MAST
			   WHERE ckm_flag = 'M' ;
				 

			  IF v_cnt = 0
			  THEN

				INSERT INTO vmscms.CMS_KYCSTATUS_MAST_R16B6 (
					ckm_inst_code,
					ckm_flag,
					ckm_flag_desc,
					ckm_ins_user,
					ckm_ins_date,
					ckm_lupd_user,
					ckm_lupd_date
				) VALUES (
					1,
					'M',
					'MINOR',
					1,
					SYSDATE,
					1,
					SYSDATE
				);



             END IF; 
			  
			
				   INSERT INTO VMSCMS.CMS_KYCSTATUS_MAST
						 SELECT *
						   FROM VMSCMS.CMS_KYCSTATUS_MAST_R16B6
						  WHERE (ckm_flag								  
								) NOT IN (
								   SELECT ckm_flag
									 FROM VMSCMS.CMS_KYCSTATUS_MAST);

      DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows inserted ');
	  
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