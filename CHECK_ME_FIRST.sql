spool $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/CHECK_ME_FIRST.log;

SET SERVEROUTPUT ON;

DECLARE 

V_CIV_VERS_BULD VMSCMS.CMS_INCOMM_VERSION.CIV_VERS_BULD%TYPE;

BEGIN

BEGIN

	FOR I IN (SELECT * FROM all_objects WHERE owner ='VMSCMS' AND (object_NAME LIKE '%_R15B%' OR object_NAME LIKE '%_R16B%') 
	AND OBJECT_TYPE ='TABLE') LOOP 
    
    EXECUTE IMMEDIATE 'DROP '|| i.object_TYPE || ' ' ||I.owner||'.'||I.OBJECT_NAME;
   
    END LOOP;
	
EXCEPTION
		WHEN OTHERS THEN
		NULL;
		
END;

	  SELECT CIV_VERS_BULD
        INTO   V_CIV_VERS_BULD
        FROM   VMSCMS.CMS_INCOMM_VERSION 
        WHERE CIV_BASE_VERS ='DB - 3.5.1';
           
        
        IF V_CIV_VERS_BULD = 'VMSGPRHOST_R15.1' 
        THEN 
            
	    DBMS_OUTPUT.PUT_LINE('****************************************');								
			
        DBMS_OUTPUT.PUT_LINE('PLEASE EXECUTE RELEASE VMSGPRHOST_R16');

	    DBMS_OUTPUT.PUT_LINE('****************************************');					
		
        
        ELSIF V_CIV_VERS_BULD = 'VMSGPRHOST_R16'
        THEN

	    DBMS_OUTPUT.PUT_LINE('****************************************');							
		
        DBMS_OUTPUT.PUT_LINE(' RELEASE VMSGPRHOST_R16 IS ALREADY INSTALLED') ;

	    DBMS_OUTPUT.PUT_LINE('****************************************');					
        
        ELSIF V_CIV_VERS_BULD NOT IN ('VMSGPRHOST_R15.1','VMSGPRHOST_R16')
        THEN

	    DBMS_OUTPUT.PUT_LINE('****************************************');							
        
         DBMS_OUTPUT.PUT_LINE('PLEASE IMPLEMENT FURTHER RELEASES AFTER '||V_CIV_VERS_BULD) ;

	    DBMS_OUTPUT.PUT_LINE('****************************************');							 
            
        END IF;     
        
EXCEPTION WHEN NO_DATA_FOUND
THEN
     DBMS_OUTPUT.PUT_LINE('DATABASE RELEASE NOT FOUND IN VERSION MASTER');       
                     
END; 
/

spool off;

