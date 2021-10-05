SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0003_Scripts.log;


----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0003

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 22-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R16_B0002 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0003

SET ECHO ON;

PROMPT     *** CREATING BACKUP TABLE CREATE_BACKUP.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0003/DDL/CREATE_BACKUP.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;

PROMPT     *** CREATING PROCEDURE SP_DISPUTE_PROCESS.prc *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0003/DDL/SP_DISPUTE_PROCESS.prc

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING PROCEDURE SP_DISPUTE_TXNS.prc *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0003/DDL/SP_DISPUTE_TXNS.prc

PROMPT     -----------------------------------------------------------

SET ECHO ON;

PROMPT     *** INSERTING INTO TABLE CMS_INST_PARAM.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0003/DML/CMS_INST_PARAM.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0003

spool off;


