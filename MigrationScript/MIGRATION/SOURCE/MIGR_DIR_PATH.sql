SET define on;
GRANT JAVAUSERPRIV TO VMSCMS;
GRANT EXECUTE ON DBMS_SYSTEM TO VMSCMS;
host loadjava -u VMSCMS/'&Enter_VMSCMS_Schema_Password'@'&CONNSTRING_For_Appropriate_DB' -v -resolve $VMS_HOME/MIGRATION/DirList.class

CREATE TABLE vmscms.migr_dir_path (mdp_path VARCHAR2(1000));
INSERT INTO vmscms.migr_dir_path
     VALUES ('&Enter_VMS_HOME_Path');
COMMIT ;
SET define off;


