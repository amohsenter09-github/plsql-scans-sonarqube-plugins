CREATE OR REPLACE PROCEDURE VMSCMS.sp_user_report
AS
CURSOR c1 IS SELECT cug_group_code , cug_group_name FROM CMS_USER_GROUP
v_cug_group_code  NUMBER(3);
v_cug_group_name  VARCHAR2(30);
BEGIN
 OPEN c1;
 FETCH c1 INTO  v_cug_group_code , v_cug_group_name;
 LOOP
 EXIT whenc1%NOTFOUND;
 SELECT CPM_PROG_CODE, CPM_MENU_LINK,CPM_TAB_TYPE,CPM_PROG_NAME ,CPM_MENU_PATH, CPM_MENU_DESC
 FROM CMS_PROG_MAST
 WHERE CPM_TAB_TYPE ='M'
 AND CPM_PROG_CODE IN  (SELECT CGP_PROG_CODE
    FROM CMS_GROUP_PROG
    WHERE CGP_INST_CODE = 1
    AND CGP_GROUP_CODE = v_cug_group_code:)
 UNION
 SELECT CPM_PROG_CODE, CPM_MENU_LINK,CPM_TAB_TYPE,CPM_PROG_NAME ,CPM_MENU_PATH, CPM_MENU_DESC
 FROM CMS_PROG_MAST
 WHERE CPM_TAB_TYPE ='S'
 AND CPM_PROG_CODE IN  (SELECT CGP_PROG_CODE
    FROM CMS_GROUP_PROG
    WHERE CGP_INST_CODE = 1
    AND CGP_GROUP_CODE = v_cug_group_code:)  ;
 FETCH c1 INTO  v_cug_group_code , v_cug_group_name;
 END LOOP;
 CLOSE c1;
END;
/


