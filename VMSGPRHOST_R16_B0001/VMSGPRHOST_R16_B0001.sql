SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0001_Scripts.log;


----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0001
	
	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 15-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R16_B0000 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0001

SET ECHO ON;

PROMPT     *** ALTERING THE TABLE  ACH_TRANSACTION_HIST.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/DDL/ACH_TRANSACTION_HIST.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING BACKUP TABLE  CREATE_BACKUP.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/DDL/CREATE_BACKUP.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** INSERTING INTO TABLE  VMS_SHIPMENT_TRAN_MAST.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/DML/VMS_SHIPMENT_TRAN_MAST.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** INSERTING INTO TABLE  VMS_PARAM_CONFIG_MAST.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/DML/VMS_PARAM_CONFIG_MAST.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** INSERTING INTO TABLE  CMS_TRANSACTION_MAST.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/DML/CMS_TRANSACTION_MAST.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** UPDATING INTO TABLE  VMS_FSAPI_VALIDATIONDTLS.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0001/DML/VMS_FSAPI_VALIDATIONDTLS.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;
 

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0001

spool off;


