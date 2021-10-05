SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/VMSGPRHOST_R16_B0005_Scripts.log;


----------------------------------------------------------------------------------------------------------------
--
--	Please keep MAY_VMSGPRHOST_R16_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release VMSGPRHOST_R16_B0005

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 28-05-2019.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where VMSGPRHOST_R16_B0004 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE VMSGPRHOST_R16_B0005
 

SET ECHO OFF;

PROMPT     *** CREATING THE PACKAGE BODY VMS_ACCOUNTS.PKG *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0005/DDL/VMS_ACCOUNTS.pkb

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING THE PACKAGE BODY VMS_TRANSACTION.PKG *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0005/DDL/VMS_TRANSACTION.pkb

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING THE PROCEDURE SP_ACH_CREDITTRANSACTION_CSR.PRC *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0005/DDL/SP_ACH_CREDITTRANSACTION_CSR.prc

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING THE PROCEDURE SP_AUTHORIZE_TXN_CSR_AUTH_ACH.PRC *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0005/DDL/SP_AUTHORIZE_TXN_CSR_AUTH_ACH.prc

PROMPT     -----------------------------------------------------------

PROMPT     *** CREATING THE PROCEDURE SP_SPIL_CARD_ACTIVATION.PRC *****

@$VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/VMSGPRHOST_R16_B0005/DDL/SP_SPIL_CARD_ACTIVATION.prc

PROMPT     -----------------------------------------------------------
 

SET ECHO OFF;

PROMPT			 	END OF RELEASE VMSGPRHOST_R16_B0005

spool off;


