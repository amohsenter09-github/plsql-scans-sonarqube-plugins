SET lin 1000
SET pages 2000
SET trimspool on
SET serveroutput on
set define on

SPOOL $VMS_HOME/MIGRATION/ROLLBACK_MIGR_LOG.log


PROMPT 						START OF ROLLBACK MIGRATION


DECLARE
   p_migr_seqno  NUMBER := &MIGRATION_SEQNO;
   p_errmsg      VARCHAR2 (200);
   p_inst_code   NUMBER;
   p_migruser    NUMBER;
   P_RESP_MSG    varchar2(1000);
BEGIN

		p_inst_code := 1;

           BEGIN
              SELECT cum_user_pin
                INTO p_migruser
                FROM VMSCMS.cms_user_mast
               WHERE cum_user_code = 'MIGR_USER' AND cum_inst_code = p_inst_code;
           EXCEPTION
              WHEN OTHERS
              THEN
                 p_errmsg := 'Migration User not Created ';
                 DBMS_OUTPUT.put_line (p_errmsg);
                 RETURN;
           END;
           
		   VMSCMS.SP_MIGR_ROLLBACK (p_migr_seqno, p_migruser,p_errmsg);
			   
	      IF p_errmsg = 'OK'
		  THEN 
		  
		  DBMS_OUTPUT.put_line ('ROLLBACK SUCCESSFUL');
		  
		  ELSE
           
		  DBMS_OUTPUT.put_line ('ROLLBACK FAILED');
	     
          END IF;  		 
			   commit;
           
END;
/

PROMPT 						END OF ROLLBACK MIGRATION


-------------------------------------------------------------
--                  CREATE REPORTS                         --
-------------------------------------------------------------

@$VMS_HOME/MIGRATION/SOURCE/DATA_ROLLBACK_REPORTS.sql;

commit;

/*

PROMPT 						START OF ENABLING ROW MOVEMENT

@$VMS_HOME/MIGRATION/SOURCE/ENABLE_ROW_MOVEMENT.sql;

PROMPT 						END OF ENABLING ROW MOVEMENT


PROMPT 						START OF SHRINKIG SEGEMENTS


DECLARE
   prm_errmsg   VARCHAR2 (200);
BEGIN

   prm_errmsg := 'OK';
   
        VMSCMS.migr_bulk_shrink_segment (prm_errmsg);
        
        DBMS_OUTPUT.put_line ('From Shrinking segments process-' || prm_errmsg);
        
END;
/

PROMPT 						END OF SHRINKIG SEGEMENTS

*/

SPOOL off