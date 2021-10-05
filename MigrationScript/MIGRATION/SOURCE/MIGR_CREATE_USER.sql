SET SERVEROUTPUT ON


DECLARE
   v_inst_bin           VARCHAR2 (2000);
   v_err_msg            VARCHAR2 (4000);
   v_grup_name          VARCHAR2 (40)   := 'MIGR_GROUP';
   v_grp_code           NUMBER;
   v_inst_code          NUMBER (5)      := 1;
   v_login_code         VARCHAR2 (40);
   v_encr_pswd          VARCHAR2 (200);
   v_user_name          VARCHAR2 (50);
   v_validfrom_date     VARCHAR2 (20);
   v_validto_date       VARCHAR2 (20);
   v_email              VARCHAR2 (100);
   v_mobile_no          VARCHAR2 (20);
   v_dob                VARCHAR2 (20);
   v_source             NUMBER (1);
   v_termial_prev       NUMBER (1);
   v_user_status        NUMBER (1);
   v_ins_user           NUMBER (8);
   v_mask_flag          VARCHAR2 (2);
   v_bin_list           VARCHAR2 (2000);
   v_regen_pwd_flag     VARCHAR2 (2);
   v_regen_pwd_resn     VARCHAR2 (200);
   v_user_flag          VARCHAR2 (2);
   v_emailchange_flag   VARCHAR2 (2);
   v_errmsg             VARCHAR2 (2000);
   v_cnt                number(2);
BEGIN
   v_login_code := 'MIGR_USER';
   v_encr_pswd :='6d645c5c9181cf3c9faec23a79aaac4f57ea106616a51bc234a7ce645efa926a';
   v_user_name := 'MIGR';
   v_validfrom_date := to_char(sysdate,'mm/dd/yyyy');
   v_validto_date := to_char(add_months(sysdate,60),'mm/dd/yyyy');
   v_email := 'migr@test.com';
   v_mobile_no := NULL;
   v_dob := NULL;
   v_source := 1;
   v_termial_prev := 1;
   v_user_status := 1;
   v_ins_user := 1;
   v_mask_flag := 'Y';
   v_bin_list := NULL;
   v_regen_pwd_flag := 'N';
   v_regen_pwd_resn := NULL;
   v_user_flag := 'A';
   v_emailchange_flag := NULL;
   v_err_msg := 'OK';

   
      SELECT COUNT(1)
      INTO   V_CNT 
      FROM VMSCMS.cms_groupdetl_mast
      WHERE  CGM_INST_CODE = v_inst_code
      AND    cgm_grup_name = V_GRUP_NAME;
          
      IF V_CNT >= 1
      THEN

      v_err_msg :=
           'GROUP MIGR_GROUP ALREADY EXISTS';
            
      DBMS_OUTPUT.put_line (v_err_msg);
      RETURN;          
          
      END IF;
          
          
        SELECT COUNT(1)
        INTO v_cnt
        FROM VMSCMS.cms_user_mast
        WHERE cum_inst_code = v_inst_code
        AND cum_user_code   = v_login_code;
      
      IF v_cnt           >= 1 THEN
        v_err_msg         := 'Login code MIGR_USER already exists in HOST';
        
      DBMS_OUTPUT.put_line (v_err_msg);
      RETURN;        
        
      END IF;
          

    SELECT COUNT(1)
    INTO v_cnt
    FROM VMSCMS.cms_userdetl_mast
    WHERE cum_lgin_code = v_login_code;
        
    IF v_cnt           >= 1 THEN
      v_err_msg        := 'Login code MIGR_USER already exists in CS Desktop';
      
      DBMS_OUTPUT.put_line (v_err_msg);
      RETURN;      
      
    END IF;          
   


   BEGIN
      SELECT VMSCMS.seq_mag_grup_sqid.NEXTVAL
        INTO v_grp_code
        FROM DUAL;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_msg :=
               'Error while getting sequence for group code--'  --Error message modified by Pankaj S. on 25-Sep-2013
            || SUBSTR (SQLERRM, 1, 200);
         DBMS_OUTPUT.put_line (v_err_msg);
         RETURN;
   END;

  /*
    BEGIN
           SELECT  SUBSTR(LISTAGG(cbm_inst_bin, ',') WITHIN GROUP (ORDER BY cbm_inst_code),1,2000)
           into v_inst_bin
            FROM   VMSCMS.cms_bin_mast
            where cbm_inst_code =1;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_err_msg :='Bin Not Found';
       DBMS_OUTPUT.PUT_LINE( v_err_msg);
      RETURN;
    WHEN OTHERS THEN
      v_err_msg :='Error while getting the bin list---'||substr(sqlerrm,1,200);
        DBMS_OUTPUT.PUT_LINE( v_err_msg);
      RETURN;
    END;
   */ 
    
   BEGIN
      INSERT INTO VMSCMS.cms_groupdetl_mast
                  (cgm_inst_code, cgm_grup_code, cgm_grup_name,
                   cgm_grup_desc, cgm_lgpw_chin, cgm_txpw_chin,
                   cgm_grup_stus, cgm_vald_ipad, cgm_ins_user, cgm_ins_date,
                   cgm_lupd_user, cgm_lupd_date, cgm_owner_id, cgm_auth_bin
                  )
           VALUES (v_inst_code, v_grp_code, v_grup_name,
                   v_grup_name, 90, -1,
                   1, 0, 1, SYSDATE,
                   1, SYSDATE, 1, v_inst_bin
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_msg :=
               'Error while inserting into grop detl mast---'
            || SUBSTR (SQLERRM, 1, 200);
         DBMS_OUTPUT.put_line (v_err_msg);
         RETURN;
   END;

   BEGIN
      INSERT INTO VMSCMS.cms_groupdetl_audt
                  (cga_inst_code, cga_grup_code, cga_grup_name,
                   cga_grup_desc, cga_lgpw_chin, cga_txpw_chin,
                   cga_grup_stus, cga_vald_ipad, cga_ins_user, cga_ins_date,
                   cga_owner_id, cga_auth_bin, cga_role_id, cga_audt_flag
                  )
           VALUES (v_inst_code, v_grp_code, v_grup_name,
                   v_grup_name, 90, -1,
                   1, 0, 1, SYSDATE,
                   1, v_inst_bin, 1, 'A'
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_msg :=
               'Error while inserting into grop detl audit---' --Error message modified by Pankaj S. on 25-Sep-2013
            || SUBSTR (SQLERRM, 1, 200);
         DBMS_OUTPUT.put_line (v_err_msg);
         RETURN;
   END;

   BEGIN
      INSERT INTO VMSCMS.cms_group_role
                  (cgr_inst_code, cgr_grup_code, cgr_role_code,
                   cgr_ins_user, cgr_ins_date
                  )
           VALUES (v_inst_code, v_grp_code, 8,
                   1, SYSDATE
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         v_err_msg :=
               'Error while inserting into grop role---'
            || SUBSTR (SQLERRM, 1, 200);
         DBMS_OUTPUT.put_line (v_err_msg);
         RETURN;
   END;

   BEGIN
      VMSCMS.sp_csr_create_user (v_inst_code,
                          v_login_code,
                          v_grp_code,
                          v_encr_pswd,
                          v_user_name,
                          v_validfrom_date,
                          v_validto_date,
                          v_email,
                          v_mobile_no,
                          v_dob,
                          v_source,
                          v_termial_prev,
                          v_user_status,
                          v_ins_user,
                          v_mask_flag,
                          v_bin_list,
                          v_regen_pwd_flag,
                          v_regen_pwd_resn,
                          'A',
                          v_emailchange_flag,
                          v_errmsg
                         );

      IF v_errmsg <> 'OK'
      THEN
         DBMS_OUTPUT.put_line (v_errmsg);
         RETURN;
      END IF;
   END;

    DBMS_OUTPUT.put_line (v_err_msg);

END;
/
SHOW ERROR;

/*
DECLARE 
  INSTCODE NUMBER;
  USERCODE VARCHAR2(200);
  PSWD VARCHAR2(200);
  USERNAME VARCHAR2(200);
  BRANCODE VARCHAR2(200);
  VALIDFROM DATE;
  VALIDTO DATE;
  USERSUSP VARCHAR2(200);
  PRM_USER_TYPE VARCHAR2(200);
  PRM_CALLCENTER_ID VARCHAR2(200);
  PRM_CORP_ID VARCHAR2(200);
  EMAIL VARCHAR2(200);
  PRM_ACCESS_FLAG VARCHAR2(200);
  LUPDUSER NUMBER;
  ERRMSG VARCHAR2(200);

BEGIN 
  INSTCODE := 1;
  USERCODE := 'MIGR_USER';
  PSWD := 'PASS123';
  USERNAME := 'MIGR';
  BRANCODE := '0000';
  VALIDFROM := SYSDATE;
  VALIDTO := ADD_MONTHS(SYSDATE,60);
  USERSUSP := 'Y';
  PRM_USER_TYPE := 0;
  PRM_CALLCENTER_ID := '456';
  PRM_CORP_ID := '123';
  EMAIL := 'migr@test.com';
  PRM_ACCESS_FLAG := 'Y';
  LUPDUSER := 1;
  ERRMSG := NULL;

  VMSCMS.SP_CREATE_USER ( INSTCODE, USERCODE, PSWD, USERNAME, BRANCODE, VALIDFROM, VALIDTO, USERSUSP, PRM_USER_TYPE, PRM_CALLCENTER_ID, PRM_CORP_ID, EMAIL, PRM_ACCESS_FLAG, LUPDUSER, ERRMSG );

  IF ERRMSG  <> 'OK'	THEN
  DBMS_OUTPUT.PUT_LINE('From user creation-'||ERRMSG);
	RETURN;
  END IF;			
END;
/
SHOW ERROR;

*/

SET SERVEROUTPUT OFF
