SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0002_Rollback.log;

----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--	Note : This Script Need to execute only if VMSGPRHOST_R16_B0001  patch is to be ROLLBACK/.
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0002_Rollback

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 20-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R16_B0001 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0002_Rollback

SET ECHO ON;

PROMPT     *** Updating back INTO TABLE  VMS_CONFIG_QUERY.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/ROLLBACK/VMS_CONFIG_QUERY.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** DELETING FROM TABLE CMS_INST_PARAM.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/ROLLBACK/CMS_INST_PARAM.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** DELETING FROM TABLE CMS_PROG_MAST.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/ROLLBACK/CMS_PROG_MAST.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** DELETING FROM TABLE  PCMS_PROCESS_SCHEDULE.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/ROLLBACK/PCMS_PROCESS_SCHEDULE.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;

PROMPT     *** CREATING PROCEDURE SP_GENERATE_UPDATE_PROXY.PRC *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/ROLLBACK/SP_GENERATE_UPDATE_PROXY.prc

PROMPT     -----------------------------------------------------------

SET ECHO ON;

PROMPT     *** DROPPING BACKUP TABLE  DROP.sql *****

--@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/ROLLBACK/DROP.sql

PROMPT     -----------------------------------------------------------

SET ECHO ON;

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0002_Rollback

spool off;


