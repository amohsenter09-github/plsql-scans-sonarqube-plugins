SET lin 1000
SET pages 2000
SET trimspool on
SET serveroutput on
set define on

SPOOL $VMS_HOME/MIGRATION/GEN_ONLINE_DATA.log


PROMPT 						START OF ONLINE FILE GENRATION


DECLARE
   p_migr_seqno  NUMBER := &MIGRATION_SEQNO;
   P_RESP_MSG    varchar2(1000);
BEGIN

	 BEGIN	  

           VMSCMS.MIGR_ONLINE_TXNDATA_AFTMIG (p_migr_seqno, P_RESP_MSG );
		   
		   if P_RESP_MSG ='OK'
		   then		   
		       DBMS_OUTPUT.put_line ('Online Txn Data generation completed');   
			   COMMIT;
		   else 
           		DBMS_OUTPUT.put_line ('Problem during online txn file generation' || P_RESP_MSG);   
			
		   end if;
      EXCEPTION WHEN OTHERS
      THEN
          DBMS_OUTPUT.put_line ('Problem during online txn file generation Block runing-' || sqlerrm);     	  
	  END;
	
	/*
	  BEGIN	  

           VMSCMS.MIGR_ONLINE_CARDDATA_AFTMIG (p_migr_seqno, P_RESP_MSG );
		   
		   if P_RESP_MSG ='OK'
		   then		   
		       DBMS_OUTPUT.put_line ('Online CARD Data generated successfully');   
			   COMMIT;
		   else 
           		DBMS_OUTPUT.put_line ('Problem during online CARD file generation' || P_RESP_MSG);   
			
		   end if;
      EXCEPTION WHEN OTHERS
      THEN
          DBMS_OUTPUT.put_line ('Problem during online CARD file generation Block runing' || sqlerrm);     	  
	  END;
	  
	  BEGIN	  

           VMSCMS.MIGR_ONLINE_ACCTDATA_FILE(p_migr_seqno, P_RESP_MSG );
		   
		   if P_RESP_MSG ='OK'
		   then		   
		       DBMS_OUTPUT.put_line ('Online Acct Data generated successfully');   
			   COMMIT;
		   else 
           		DBMS_OUTPUT.put_line ('Problem during online Acct file generation' || P_RESP_MSG);   
			
		   end if;
      EXCEPTION WHEN OTHERS
      THEN
          DBMS_OUTPUT.put_line ('Problem during online Acct file generation Block runing' || sqlerrm);     	  
	  END;
	 */ 
                      
END;
/

PROMPT 						END OF ONLINE FILE GENRATION

SPOOL off