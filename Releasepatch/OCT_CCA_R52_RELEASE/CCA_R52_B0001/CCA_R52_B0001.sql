SPOOL $VMS_HOME/OCT_CCA_R52_RELEASE/LOG/CCA_R52_B0001_Scripts.log;


----------------------------------------------------------------------------------------------------------------
--
--	Please keep OCT_CCA_R52_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release CCA_R52_B0001

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 20-09-2021.

  
set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT START OF RELEASE CCA_R52_B0001

SET ECHO OFF;

PROMPT     *** Creating PACKAGE BODY GPP_CARDS.pkb *****

@$VMS_HOME/OCT_CCA_R52_RELEASE/CCA_R52_B0001/DDL/GPP_CARDS.pkb

PROMPT     -----------------------------------------------------------

SET ECHO OFF;



PROMPT			 	END OF RELEASE CCA_R52_B0001

spool off;
