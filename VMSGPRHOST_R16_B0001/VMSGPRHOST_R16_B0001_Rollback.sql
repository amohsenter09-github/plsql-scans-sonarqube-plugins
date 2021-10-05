SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0001_Rollback.log;

----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--	Note : This Script Need to execute only if VMSGPRHOST_R16_B0001  patch is to be ROLLBACK/.
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0001_Rollback

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 15-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R16_B0000 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0001_Rollback

SET ECHO ON;

PROMPT     *** DELETING FROM  TABLE  VMS_SHIPMENT_TRAN_MAST.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/ROLLBACK/VMS_SHIPMENT_TRAN_MAST.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** DELETING FROM  TABLE  VMS_PARAM_CONFIG_MAST.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/ROLLBACK/VMS_PARAM_CONFIG_MAST.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** DELETING FROM  TABLE  CMS_TRANSACTION_MAST.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/ROLLBACK/CMS_TRANSACTION_MAST.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** UPDATING BACK INTO TABLE  VMS_FSAPI_VALIDATIONDTLS.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/ROLLBACK/VMS_FSAPI_VALIDATIONDTLS.sql

PROMPT     ----------------------------------------------------------- 

PROMPT     *** DROPPING BACKUP TABLE  DROP.sql *****

--@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/ROLLBACK/DROP.sql

PROMPT     -----------------------------------------------------------

SET ECHO ON;

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0001_Rollback

spool off;


