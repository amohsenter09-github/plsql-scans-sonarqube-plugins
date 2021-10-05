SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0000_Scripts.log;


----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0000

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 10-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R15_B0006 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0000

SET ECHO ON;

PROMPT     *** CREATING TABLE GPR_VALIDCARDSTAT_AUDIT.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0000/DDL/GPR_VALIDCARDSTAT_AUDIT.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING SEQUENCE SEQ_CARDSTAT_AUDITID.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0000/DDL/SEQ_CARDSTAT_AUDITID.sql

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING SEQUENCE SEQ_CARDSTAT_SEQNO.sql *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0000/DDL/SEQ_CARDSTAT_SEQNO.sql

PROMPT     -----------------------------------------------------------

SET ECHO OFF;

PROMPT     *** CREATING PROCEDURE SP_CARDSTATUS_COPY.prc *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0000/DDL/SP_CARDSTATUS_COPY.prc

PROMPT     -----------------------------------------------------------

SET ECHO ON;

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0000

spool off;


