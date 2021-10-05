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
      AND object_name = 'VMS_SHIPMENT_TRAN_MAST_R16B1';

   IF v_chk_tab = 1
   THEN
			  

		SELECT COUNT (1)
		INTO v_cnt
		FROM vmscms.VMS_SHIPMENT_TRAN_MAST
		WHERE VSM_SHIPMENT_ID = 'D'
		AND VSM_SHIPMENT_KEY = 'FEDEX_INTERNATIONAL_PRIORITY'
		AND VSM_SHIPMENT_DESC = 'FedEx International Priority'
		AND VSM_CCA_TRANCODE = '57';                       

		IF v_cnt = 0
		THEN
		
					INSERT INTO vmscms.vms_shipment_tran_mast_r16b1 (
						vsm_shipment_id,
						vsm_shipment_key,
						vsm_shipment_desc,
						vsm_cca_trancode
					) VALUES (
						'D',
						'FEDEX_INTERNATIONAL_PRIORITY',
						'FedEx International Priority',
						'57'
					);
		
		END IF;
		
		SELECT COUNT (1)
		INTO v_cnt
		FROM vmscms.VMS_SHIPMENT_TRAN_MAST
		WHERE VSM_SHIPMENT_ID = 'E'
		AND VSM_SHIPMENT_KEY = 'FEDEX_INTERNATIONAL_ECONOMY'
		AND VSM_SHIPMENT_DESC = 'FedEx International Economy'
		AND VSM_CCA_TRANCODE = '58';                         

		IF v_cnt = 0
		THEN
		
		
		

			INSERT INTO vmscms.vms_shipment_tran_mast_r16b1 (
				vsm_shipment_id,
				vsm_shipment_key,
				vsm_shipment_desc,
				vsm_cca_trancode
			) VALUES (
				'E',
				'FEDEX_INTERNATIONAL_ECONOMY',
				'FedEx International Economy',
				'58'
			);


		
		END IF;
		
		
		SELECT COUNT (1)
		INTO v_cnt
		FROM vmscms.VMS_SHIPMENT_TRAN_MAST
		WHERE VSM_SHIPMENT_ID = 'F'
		AND VSM_SHIPMENT_KEY = 'FEDEX_GROUND_INTERNATIONAL'
		AND VSM_SHIPMENT_DESC = 'FedEx Ground International'
		AND VSM_CCA_TRANCODE = '59';                         

		IF v_cnt = 0
		THEN
		
		 
			 
			INSERT INTO vmscms.vms_shipment_tran_mast_r16b1 (
				vsm_shipment_id,
				vsm_shipment_key,
				vsm_shipment_desc,
				vsm_cca_trancode
			) VALUES (
				'F',
				'FEDEX_GROUND_INTERNATIONAL',
				'FedEx Ground International',
				'59'
			);
		END IF;
		
		 INSERT INTO VMSCMS.VMS_SHIPMENT_TRAN_MAST
            SELECT *
              FROM VMSCMS.VMS_SHIPMENT_TRAN_MAST_R16B1
             WHERE (vsm_shipment_id,vsm_shipment_key,
										vsm_shipment_desc,
										vsm_cca_trancode) NOT IN (
                       SELECT vsm_shipment_id,vsm_shipment_key,
										vsm_shipment_desc,
										vsm_cca_trancode
                         FROM VMSCMS.VMS_SHIPMENT_TRAN_MAST);
		
   
	 DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Inserted ');

				
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

