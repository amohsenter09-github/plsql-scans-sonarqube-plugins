SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0004_Scripts.log;


----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0004

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 27-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R16_B0003 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0004

SET ECHO ON;

PROMPT     *** CREATING BACKUP TABLE TRANSACTIONLOG.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0004/DDL/TRANSACTIONLOG.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING BACKUP TABLE CMS_TRANSACTION_LOG_DTL.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0004/DDL/CMS_TRANSACTION_LOG_DTL.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING BACKUP TABLE CREATE_BACKUP.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0004/DDL/CREATE_BACKUP.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;

PROMPT     *** CREATING THE PROCEDURE SP_COMMON_TXNLOG.PRC *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0004/DDL/SP_COMMON_TXNLOG.prc

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING THE PROCEDURE SP_CARDSTATUS_COPY.PRC *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0004/DDL/SP_CARDSTATUS_COPY.prc

PROMPT     -----------------------------------------------------------

SET ECHO ON;

PROMPT     *** INSERTING INTO TABLE CMS_INST_PARAM.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0004/DML/CMS_INST_PARAM.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0004

spool off;


