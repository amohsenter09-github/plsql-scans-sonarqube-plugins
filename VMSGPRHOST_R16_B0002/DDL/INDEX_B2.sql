SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/INDEX_B2.log;

SET ECHO ON;
SET SERVEROUTPUT ON;
CREATE INDEX vmscms.IDX_CSR_FILE_NAME ON vmscms.cms_stock_report(csr_file_name) TABLESPACE cms_index ONLINE; 

SPOOL OFF;
