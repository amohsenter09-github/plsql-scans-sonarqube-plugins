SPOOL $VMS_HOME/APPROACH_1/LOG/APPROACH_1.log;

set lines 1000;
set pages 1000; 
set echo on;
set serveroutput on
set define off

PROMPT START OF RELEASE APPROACH_1

PROMPT     ***  creating VMS_INVENTORY_CONTROL table *****

@$VMS_HOME/APPROACH_1/DDL/VMS_INVENTORY_CONTROL.sql;

PROMPT -----------------------------------------------------------

set echo off;

PROMPT     *** CREATING VMSB2BAPI PACKAGE spec*****

@$VMS_HOME/APPROACH_1/DDL/VMSB2BAPI.pks;

PROMPT -----------------------------------------------------------

PROMPT     *** CREATING VMSB2BAPI PACKAGE body *****

@$VMS_HOME/APPROACH_1/DDL/VMSB2BAPI.pkb;

PROMPT -----------------------------------------------------------

PROMPT     *** CREATING VMSCARD PACKAGE *****

@$VMS_HOME/APPROACH_1/DDL/VMSCARD.pkb;

PROMPT -----------------------------------------------------------

PROMPT     *** CREATING VMS_SPIL_VIRTUAL PACKAGE *****

@$VMS_HOME/APPROACH_1/DDL/VMS_SPIL_VIRTUAL.pkb;

PROMPT -----------------------------------------------------------

PROMPT     *** CREATING VMSCARD_STOCK PACKAGE *****

@$VMS_HOME/APPROACH_1/DDL/VMSCARD_STOCK.pkb;

PROMPT -----------------------------------------------------------
 

PROMPT END OF RELEASE APPROACH_1

spool off;