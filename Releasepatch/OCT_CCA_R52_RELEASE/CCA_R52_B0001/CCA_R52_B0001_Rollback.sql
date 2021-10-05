SPOOL $VMS_HOME/OCT_CCA_R52_RELEASE/LOG/CCA_R52_B0001_Rollback.log;

----------------------------------------------------------------------------------------------------------------
--
--	Please keep OCT_CCA_R52_RELEASE folder in $VMS_HOME/ and then execute the script						
--	execute all the scripts using SQL prompt of Oracle only.							 
--	Please take a proper back up of schema before executing this scripts					
--	
--	Note : This Script Need to execute only if CCA_R52_B0001  patch is to be ROLLBACK/.
--													
----------------------------------------------------------------------------------------------------------------						
	
	--- RELEASE NAME : Release CCA_R52_B0001_Rollback

	--- RELEASED FOR : Defect IDs : 

	--- RELEASED BY  : DB Team  on 20-09-2021.


	--- PREREQUISITE FOR THIS BUILD : This script is to be executed on a environment where CCA_R52_B0001 is available



set define off;
set lines 1000;
set pages 1000; 
set serveroutput on


PROMPT			 	START OF RELEASE CCA_R52_B0001_Rollback

SET ECHO OFF;

PROMPT     *** Creating PACKAGE BODY GPP_CARDS.pkb *****

@$VMS_HOME/OCT_CCA_R52_RELEASE/CCA_R52_B0001/ROLLBACK/GPP_CARDS.pkb

PROMPT     ----------------------------------------------------------- 

PROMPT			 	END OF RELEASE CCA_R52_B0001_Rollback

spool off;





