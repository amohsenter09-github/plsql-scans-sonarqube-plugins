SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0002_Scripts.log;


----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0002
	
	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 20-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R16_B0001 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0002

SET ECHO ON;

PROMPT     *** ALTERING THE TABLE CMS_ECNS_LOG.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/DDL/CMS_ECNS_LOG.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING BACKUP TABLE CREATE_BACKUP.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/DDL/CREATE_BACKUP.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;

PROMPT     *** CREATING PROCEDURE SP_GENERATE_UPDATE_PROXY.PRC *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/DDL/SP_GENERATE_UPDATE_PROXY.prc

PROMPT     -----------------------------------------------------------

SET ECHO ON;

PROMPT     *** INSERTING INTO TABLE CMS_INST_PARAM.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/DML/CMS_INST_PARAM.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** INSERTING INTO TABLE CMS_PROG_MAST.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/DML/CMS_PROG_MAST.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** INSERTING INTO TABLE  PCMS_PROCESS_SCHEDULE.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/DML/PCMS_PROCESS_SCHEDULE.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** Updating INTO TABLE  VMS_CONFIG_QUERY.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0002/DML/VMS_CONFIG_QUERY.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;
 

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0002

spool off;


