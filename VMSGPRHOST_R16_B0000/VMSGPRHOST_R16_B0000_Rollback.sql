SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0000_Rollback.log;

----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--	Note : This Script Need to execute only if VMSGPRHOST_R15_B0006  patch is to be ROLLBACK/.
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0000_Rollback

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 10-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R16_B0000 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0000_Rollback

SET ECHO OFF;

PROMPT     *** CREATING PROCEDURE SP_CARDSTATUS_COPY.prc *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0000/ROLLBACK/SP_CARDSTATUS_COPY.prc

PROMPT     -----------------------------------------------------------

SET ECHO ON;

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0000_Rollback

spool off;


