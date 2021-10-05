DECLARE
   v_chk_tab   VARCHAR2 (10);
   v_err       VARCHAR2 (1000);
   v_cnt       NUMBER (2);
BEGIN
   
   SELECT COUNT (1)
     INTO v_chk_tab
     FROM all_objects
    WHERE object_type = 'TABLE'
      AND owner = 'VMSCMS'
      AND object_name = 'VMS_PARAM_CONFIG_MAST_R16B1';

   IF v_chk_tab = 1
   THEN

   SELECT COUNT (1)
     INTO v_cnt
     FROM vmscms.VMS_PARAM_CONFIG_MAST
    WHERE VPC_PARAM_TYPE = 'PackageId_Ship_Methods'
      AND VPC_PARAM_ID = 'D'
      AND VPC_PARAM_NAME = 'FedEx International Priority';

   IF v_cnt = 0
   THEN

			INSERT INTO vmscms.vms_param_config_mast_r16b1 (
			vpc_param_type,
			vpc_param_id,
			vpc_param_name,
			vpc_remarks,
			vpc_ins_user,
			vpc_ins_date,
			vpc_lupd_user,
			vpc_lupd_date
		) VALUES (
			'PackageId_Ship_Methods',
			'D',
			'FedEx International Priority',
			'Used in Define Package ID for Loading Ship Methods',
			1,
			SYSDATE,
			1,
			SYSDATE
		);

		 
   END IF;
	
   SELECT COUNT (1)
     INTO v_cnt
     FROM vmscms.VMS_PARAM_CONFIG_MAST
    WHERE VPC_PARAM_TYPE = 'PackageId_Ship_Methods'
      AND VPC_PARAM_ID = 'E'
      AND VPC_PARAM_NAME = 'FedEx International Economy';

   IF v_cnt = 0
   THEN

			   
			INSERT INTO vmscms.vms_param_config_mast_r16b1 (
				vpc_param_type,
				vpc_param_id,
				vpc_param_name,
				vpc_remarks,
				vpc_ins_user,
				vpc_ins_date,
				vpc_lupd_user,
				vpc_lupd_date
			) VALUES (
				'PackageId_Ship_Methods',
				'E',
				'FedEx International Economy',
				'Used in Define Package ID for Loading Ship Methods',
				1,
				SYSDATE,
				1,
				SYSDATE
			);
		 
		
		
   END IF;
   
   SELECT COUNT (1)
     INTO v_cnt
     FROM vmscms.VMS_PARAM_CONFIG_MAST
    WHERE VPC_PARAM_TYPE = 'PackageId_Ship_Methods'
      AND VPC_PARAM_ID = 'F'
      AND VPC_PARAM_NAME = 'FedEx Ground International';

   IF v_cnt = 0
   THEN

		 

			INSERT INTO vmscms.vms_param_config_mast_r16b1 (
				vpc_param_type,
				vpc_param_id,
				vpc_param_name,
				vpc_remarks,
				vpc_ins_user,
				vpc_ins_date,
				vpc_lupd_user,
				vpc_lupd_date
			) VALUES (
				'PackageId_Ship_Methods',
				'F',
				'FedEx Ground International',
				'Used in Define Package ID for Loading Ship Methods',
				1,
				SYSDATE,
				1,
				SYSDATE
			);
		 
   END IF;
 

   
         INSERT INTO VMSCMS.VMS_PARAM_CONFIG_MAST
            SELECT *
              FROM VMSCMS.VMS_PARAM_CONFIG_MAST_R16B1
             WHERE (VPC_PARAM_TYPE,
                    VPC_PARAM_ID,
                    VPC_PARAM_NAME) NOT IN (
                       SELECT VPC_PARAM_TYPE,
                              VPC_PARAM_ID,
                              VPC_PARAM_NAME
                         FROM VMSCMS.VMS_PARAM_CONFIG_MAST);
			
         DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows inserted ');
		 
				
   ELSE
      DBMS_OUTPUT.put_line (' Backup Object Not Found');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      v_err := SUBSTR (SQLERRM, 1, 100);
      DBMS_OUTPUT.put_line ('Main Excp ' || v_err);
END;
/

