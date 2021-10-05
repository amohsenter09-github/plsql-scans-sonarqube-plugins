SPOOL $VMS_HOME/APPROACH_1/LOG/APPROACH_1RB.log;

set lines 1000;
set pages 1000; 
set echo on;
set serveroutput on
set define off

set echo off;

PROMPT     *** CREATING VMSB2BAPI PACKAGE spec*****

@$VMS_HOME/APPROACH_1/ROLLBACK/VMSB2BAPI.pks;

PROMPT -----------------------------------------------------------

PROMPT     *** CREATING VMSB2BAPI PACKAGE body *****

@$VMS_HOME/APPROACH_1/ROLLBACK/VMSB2BAPI.pkb;

PROMPT ----------------------------------------------------------- 

PROMPT     *** CREATING VMSCARD PACKAGE *****

@$VMS_HOME/APPROACH_1/ROLLBACK/VMSCARD.pkb;

PROMPT -----------------------------------------------------------

PROMPT     *** CREATING VMS_SPIL_VIRTUAL PACKAGE *****

@$VMS_HOME/APPROACH_1/ROLLBACK/VMS_SPIL_VIRTUAL.pkb;

PROMPT -----------------------------------------------------------

PROMPT     *** CREATING VMSCARD_STOCK PACKAGE *****

@$VMS_HOME/APPROACH_1/ROLLBACK/VMSCARD_STOCK.pkb;

PROMPT -----------------------------------------------------------
 

PROMPT END OF RELEASE APPROACH_1RB

spool off;