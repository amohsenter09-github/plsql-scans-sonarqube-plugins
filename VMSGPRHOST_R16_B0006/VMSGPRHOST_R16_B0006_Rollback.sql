SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0006_Rollback.log;

----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--	Note : This Script Need to execute only if VMSGPRHOST_R16_B0004  patch is to be ROLLBACK/.
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0006_Rollback

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 31-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R16_B0005 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0006_Rollback


SET ECHO ON;

PROMPT     *** DELETING FROM TABLE CMS_KYCSTATUS_MAST  *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0006/ROLLBACK/CMS_KYCSTATUS_MAST.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** UPDATING BACK INTO TABLE CMS_INST_PARAM  *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0006/ROLLBACK/CMS_INST_PARAM.sql

PROMPT     -----------------------------------------------------------
 

SET ECHO OFF;
 
PROMPT     *** CREATING THE PROCEDURE SP_TRAN_FEES_CMSAUTH.PRC *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0006/ROLLBACK/SP_TRAN_FEES_CMSAUTH.prc

PROMPT     -----------------------------------------------------------
 

SET ECHO ON;

PROMPT     *** DROPPING THE BACKUP TABLE DROP  *****

--@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0006/ROLLBACK/DROP.sql

PROMPT     -----------------------------------------------------------

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0006_Rollback

spool off;


