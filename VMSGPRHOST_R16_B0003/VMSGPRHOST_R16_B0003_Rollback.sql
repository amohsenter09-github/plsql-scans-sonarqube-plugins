SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0003_Rollback.log;

----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--	Note : This Script Need to execute only if VMSGPRHOST_R15_B0006  patch is to be ROLLBACK/.
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0003_Rollback

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 22-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R16_B0003 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0003_Rollback

SET ECHO ON;

PROMPT     *** DELETING FROM TABLE CMS_INST_PARAM.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0003/ROLLBACK/CMS_INST_PARAM.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;

PROMPT     *** CREATING PROCEDURE SP_DISPUTE_PROCESS.prc *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0003/ROLLBACK/SP_DISPUTE_PROCESS.prc

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING PROCEDURE SP_DISPUTE_TXNS.prc *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0003/ROLLBACK/SP_DISPUTE_TXNS.prc

PROMPT     -----------------------------------------------------------

SET ECHO ON;

PROMPT     *** DROPPING BACKUP TABLE  DROP.sql *****

--@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0003/ROLLBACK/DROP.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0003_Rollback

spool off;


