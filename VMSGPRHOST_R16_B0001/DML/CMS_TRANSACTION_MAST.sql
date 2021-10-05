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
      AND object_name = 'CMS_TRANSACTION_MAST_R16B1';

   IF v_chk_tab = 1
   THEN
   
		SELECT COUNT (1)
		INTO v_cnt
		FROM vmscms.CMS_TRANSACTION_MAST
		WHERE CTM_INST_CODE = 1
		AND CTM_DELIVERY_CHANNEL = '03'
		AND CTM_TRAN_CODE = '57';                          

		IF v_cnt = 0
		THEN
		
							INSERT INTO vmscms.cms_transaction_mast_r16b1 (
					ctm_inst_code,
					ctm_tran_code,
					ctm_tran_desc,
					ctm_credit_debit_flag,
					ctm_delivery_channel,
					ctm_output_type,
					ctm_tran_type,
					ctm_support_type,
					ctm_lupd_date,
					ctm_lupd_user,
					ctm_ins_date,
					ctm_ins_user,
					ctm_support_catg,
					ctm_preauth_flag,
					ctm_amnt_transfer_flag,
					ctm_login_txn,
					ctm_prfl_flag,
					ctm_fee_flag,
					ctm_txn_ind,
					ctm_adjustment_flag,
					ctm_initial_preauth_ind,
					ctm_deployment_flag,
					ctm_loadtrans_flag,
					ctm_preauth_type,
					ctm_success_alerts,
					ctm_rvsl_success_alerts,
					ctm_failure_alerts,
					ctm_display_txndesc,
					ctm_prflupd_flag,
					ctm_kycdisplay_flag,
					ctm_txn_map_code,
					ctm_txn_map_flag,
					ctm_transaction_identifier,
					ctm_card_activation,
					ctm_redemption_delay_flag,
					ctm_cardstat_change_txn,
					ctm_rrn_check,
					ctm_badcredit_flag
				) VALUES (
					1,
					'57',
					'FedEx International Priority',
					'NA',
					'03',
					'N',
					'N',
					'T',
					SYSDATE,
					1,
					SYSDATE,
					1,
					NULL,
					'N',
					'N',
					'Y',
					'N',
					'Y',
					'N',
					'N',
					'N',
					0,
					'N',
					NULL,
					NULL,
					NULL,
					NULL,
					'FedEx International Priority',
					'N',
					'N',
					'NA',
					'N',
					'0',
					'N',
					NULL,
					NULL,
					'Y',
					NULL
				);
 
		END IF;
		
		
		
		
		SELECT COUNT (1)
		INTO v_cnt
		FROM vmscms.CMS_TRANSACTION_MAST
		WHERE CTM_INST_CODE = 1
		AND CTM_DELIVERY_CHANNEL = '03'
		AND CTM_TRAN_CODE = '58';                          

		IF v_cnt = 0
		THEN
		
					 
			INSERT INTO vmscms.cms_transaction_mast_r16b1 (
				ctm_inst_code,
				ctm_tran_code,
				ctm_tran_desc,
				ctm_credit_debit_flag,
				ctm_delivery_channel,
				ctm_output_type,
				ctm_tran_type,
				ctm_support_type,
				ctm_lupd_date,
				ctm_lupd_user,
				ctm_ins_date,
				ctm_ins_user,
				ctm_support_catg,
				ctm_preauth_flag,
				ctm_amnt_transfer_flag,
				ctm_login_txn,
				ctm_prfl_flag,
				ctm_fee_flag,
				ctm_txn_ind,
				ctm_adjustment_flag,
				ctm_initial_preauth_ind,
				ctm_deployment_flag,
				ctm_loadtrans_flag,
				ctm_preauth_type,
				ctm_success_alerts,
				ctm_rvsl_success_alerts,
				ctm_failure_alerts,
				ctm_display_txndesc,
				ctm_prflupd_flag,
				ctm_kycdisplay_flag,
				ctm_txn_map_code,
				ctm_txn_map_flag,
				ctm_transaction_identifier,
				ctm_card_activation,
				ctm_redemption_delay_flag,
				ctm_cardstat_change_txn,
				ctm_rrn_check,
				ctm_badcredit_flag
			) VALUES (
				1,
				'58',
				'FedEx International Economy',
				'NA',
				'03',
				'N',
				'N',
				'T',
				SYSDATE,
				1,
				SYSDATE,
				1,
				NULL,
				'N',
				'N',
				'Y',
				'N',
				'Y',
				'N',
				'N',
				'N',
				0,
				'N',
				NULL,
				NULL,
				NULL,
				NULL,
				'FedEx International Economy',
				'N',
				'N',
				'NA',
				'N',
				'0',
				'N',
				NULL,
				NULL,
				'Y',
				NULL
			);


		END IF;
		
		
		
		
		SELECT COUNT (1)
		INTO v_cnt
		FROM vmscms.CMS_TRANSACTION_MAST
		WHERE CTM_INST_CODE = 1
		AND CTM_DELIVERY_CHANNEL = '03'
		AND CTM_TRAN_CODE = '59';                          

		IF v_cnt = 0
		THEN
		
		
					
			INSERT INTO vmscms.cms_transaction_mast_r16b1 (
				ctm_inst_code,
				ctm_tran_code,
				ctm_tran_desc,
				ctm_credit_debit_flag,
				ctm_delivery_channel,
				ctm_output_type,
				ctm_tran_type,
				ctm_support_type,
				ctm_lupd_date,
				ctm_lupd_user,
				ctm_ins_date,
				ctm_ins_user,
				ctm_support_catg,
				ctm_preauth_flag,
				ctm_amnt_transfer_flag,
				ctm_login_txn,
				ctm_prfl_flag,
				ctm_fee_flag,
				ctm_txn_ind,
				ctm_adjustment_flag,
				ctm_initial_preauth_ind,
				ctm_deployment_flag,
				ctm_loadtrans_flag,
				ctm_preauth_type,
				ctm_success_alerts,
				ctm_rvsl_success_alerts,
				ctm_failure_alerts,
				ctm_display_txndesc,
				ctm_prflupd_flag,
				ctm_kycdisplay_flag,
				ctm_txn_map_code,
				ctm_txn_map_flag,
				ctm_transaction_identifier,
				ctm_card_activation,
				ctm_redemption_delay_flag,
				ctm_cardstat_change_txn,
				ctm_rrn_check,
				ctm_badcredit_flag
			) VALUES (
				1,
				'59',
				'FedEx Ground International',
				'NA',
				'03',
				'N',
				'N',
				'T',
				SYSDATE,
				1,
				SYSDATE,
				1,
				NULL,
				'N',
				'N',
				'Y',
				'N',
				'Y',
				'N',
				'N',
				'N',
				0,
				'N',
				NULL,
				NULL,
				NULL,
				NULL,
				'FedEx Ground International',
				'N',
				'N',
				'NA',
				'N',
				'0',
				'N',
				NULL,
				NULL,
				'Y',
				NULL
			);
		 
		END IF;
		
  

         INSERT INTO VMSCMS.CMS_TRANSACTION_MAST
            SELECT *
              FROM VMSCMS.CMS_TRANSACTION_MAST_R16B1
             WHERE (CTM_INST_CODE,
                    CTM_DELIVERY_CHANNEL,
                    CTM_TRAN_CODE) NOT IN (
                       SELECT CTM_INST_CODE,
                              CTM_DELIVERY_CHANNEL,
                              CTM_TRAN_CODE
                         FROM VMSCMS.CMS_TRANSACTION_MAST);
			
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