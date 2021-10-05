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
      AND object_name = 'CMS_PROG_MAST_R16B2';

   IF v_chk_tab = 1
   THEN
   
			 SELECT COUNT (1)
				INTO v_cnt
				FROM VMSCMS.CMS_PROG_MAST
			   WHERE CPM_INST_CODE = 1
               AND   CPM_PROG_CODE = (select max(cpm_prog_code)+1 from vmscms.cms_prog_mast);
				 

			  IF v_cnt = 0
			  THEN

					INSERT
				INTO VMSCMS.CMS_PROG_MAST_R16B2
				  (
					CPM_INST_CODE,
					CPM_PROG_CODE,
					CPM_TAB_TYPE,
					CPM_MENU_LINK,
					CPM_PROG_NAME,
					CPM_MENU_PATH,
					CPM_MENU_DESC,
					CPM_PROG_ORDER,
					CPM_PROG_STAT,
					CPM_INS_USER,
					CPM_INS_DATE,
					CPM_LUPD_USER,
					CPM_LUPD_DATE,
					CPM_ADMIN_MENU
				  )
				  VALUES
				  (
						1,
						(SELECT MAX(cpm_prog_code)+1 FROM vmscms.cms_prog_mast),
						'P',
						2093,
						'Failed SMS Retry',
						'/cms/ProcessScheduler/FailedSMSRetry.jsp',
						'cms.menu.prog.FailedSMSRetry',
						216.4,
						'Y',
						1,
						sysdate,
						1,
						sysdate,
						'N'
					  );

             END IF; 
			  
			
				   INSERT INTO VMSCMS.CMS_PROG_MAST
						 SELECT *
						   FROM VMSCMS.CMS_PROG_MAST_R16B2
						  WHERE (CPM_INST_CODE,
								 CPM_PROG_CODE
								) NOT IN (
								   SELECT CPM_INST_CODE,
										  CPM_PROG_CODE
									 FROM VMSCMS.CMS_PROG_MAST);

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