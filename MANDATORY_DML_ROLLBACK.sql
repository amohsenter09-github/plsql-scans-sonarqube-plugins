SPOOL $VMS_HOME/MAY_VMSGPRHOST_R16_RELEASE/LOG/MANDATORY_ROLLBACK_DML.log;


PROMPT   CMS Mandatory Version Maintanence


-------------------------------------------
------CMS Mandatory for all Release--------
-------------------------------------------
SET ECHO ON 


delete from VMSCMS.CMS_INCOMM_VERSION
where CIV_BASE_VERS  in ('DB - 3.5.1','CMS - 3.5.1','INCOMM_VERSION_CMS','JAVA - 3.5.1');



INSERT INTO VMSCMS.CMS_INCOMM_VERSION
    VALUES ('DB - 3.5.1', NULL, 'VMSGPRHOST_R15.1',SYSDATE,'DBA', SYSDATE);

	
INSERT INTO VMSCMS.CMS_INCOMM_version
    VALUES ('CMS - 3.5.1', NULL, 'VMSGPRHOST_R15.1',SYSDATE, 'ADMIN', SYSDATE);


INSERT INTO VMSCMS.CMS_INCOMM_version
   VALUES ('JAVA - 3.5.1', NULL, 'VMSGPRHOST_R15.1',SYSDATE, 'ADMIN', SYSDATE);
	
	
INSERT INTO VMSCMS.CMS_INCOMM_version
    VALUES ('INCOMM_VERSION_CMS', NULL, 'VMSGPRHOST_R15.1',SYSDATE, 'ADMIN', SYSDATE);


-------------------------------------------
------CSR Mandatory for all Release--------
-------------------------------------------

delete from vmscms.CMS_INCOMM_VERSION
where CIV_BASE_VERS  in ('CSR - 1.0.1','CSR-JAVA - 1.0.1','INCOMM_VERSION_CSR');


INSERT INTO vmscms.CMS_INCOMM_VERSION
	VALUES ('CSR-JAVA - 1.0.1', NULL, 'VMSGPRHOST_R15.1',SYSDATE,'ADMIN', SYSDATE);

INSERT INTO vmscms.CMS_INCOMM_version
    VALUES ('CSR - 1.0.1', NULL, 'VMSGPRHOST_R15.1',SYSDATE, 'ADMIN', SYSDATE);


INSERT INTO vmscms.CMS_INCOMM_version
VALUES ('INCOMM_VERSION_CSR', NULL, 'VMSGPR CS Desktop R15.1',SYSDATE, 'ADMIN', SYSDATE);

	
commit;

SET ECHO OFF

spool off;