SET SERVEROUTPUT ON;
DECLARE
   v_chk_tab   VARCHAR2 (10);
   v_err       VARCHAR2 (1000);
   v_cnt       NUMBER (2);
   v1		   VARCHAR2 (2000);
   v2		   VARCHAR2 (2000);
   v3		   VARCHAR2 (2000);
BEGIN
   SELECT COUNT (1)
     INTO v_chk_tab
     FROM all_objects
    WHERE object_type = 'TABLE'
      AND owner = 'VMSCMS'
      AND object_name = 'VMS_CONFIG_QUERY_R16B2';

   IF v_chk_tab = 1
   THEN
			 
	 
			 update vmscms.VMS_CONFIG_QUERY set VCQ_QUERY_VALUE='SELECT cci_store_id loc,
		  fn_dmaps_main (cap_pan_code_encr) pan,''RTL''  orderType,
		  cap_pan_code_encr encrPan,
		  cap_pan_code hashPan,
		  TO_CHAR (cap_expry_date, ''YYMM'') expryDate,
		  TO_CHAR (cap_pangen_date, ''YYMM'') effectiveDate,
		  Decode(mm.CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(CAP_DISP_NAME),CAP_DISP_NAME) dispname,
		  mm.srvCode,
		  cap_acct_no acctNo,
		  cap_expry_date expirydate,
		  cap_prod_code prodCode,
		  mm.cpc_profile_code profCode,
		  mm.csr_card_id AS cardId ,
		  (select cpc_card_details from cms_prod_cardpack where cpc_card_id = csr_card_id ) AS packageId ,
		  cap_proxy_number proxyNumber,
		  cap_card_type cardType,
		  cap_card_stat cardStat,
		  cap_cust_code custCode,
		  DECODE (cap_repl_flag, 2, cap_repl_flag, NVL (mm.cpc_del_met, 1) ) deliveryMethod,
		  (select LPAD(NVL(vpd_field_value,''0''),6,''0'')  from VMS_PACKAGEID_DETL where vpd_package_id=mm.logoId and vpd_field_key=''logoId'') logoId
		FROM
		  (SELECT cpm_prod_code,
			cpm_prod_desc,
			c.cpc_prod_code,
			csr_file_name,
			cpc_profile_code,
			c.cpc_card_type,
			g.csr_card_id,
			cp.CPC_CARD_DETAILS,
			c.cpc_cardtype_desc,
			cpb_inst_bin,
			cpm_inst_code,
			c.cpc_del_met,
			c.cpc_inst_code,
			csr_bran_fiid,
			cbp_param_value srvcode,
			PACKIDMAST.VPM_PACKAGE_ID logoId,c.cpc_encrypt_enable
		  FROM cms_prod_mast b,
			cms_prod_cattype c,
			cms_prod_bin r,
			cms_stock_report g,
			cms_bin_param t ,
			CMS_PROD_CARDPACK CP,
			VMS_PACKAGEID_MAST PACKIDMAST
		  WHERE b.cpm_inst_code        = c.cpc_inst_code
		  AND b.cpm_prod_code          = c.cpc_prod_code
		  AND b.cpm_inst_code          = r.cpb_inst_code
		  AND b.cpm_prod_code          = r.cpb_prod_code
		  AND cp.CPC_INST_CODE         = c.cpc_inst_code
		  AND cp.CPC_PROD_CODE         = c.cpc_prod_code
		  AND g.csr_card_id = cp.cpc_card_id
          AND g.csr_inst_code = cp.cpc_inst_code
          AND g.csr_prod_code = cp.cpc_prod_code
		  AND r.cpb_inst_bin           = ?
		  AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
		 AND PACKIDMAST.VPM_VENDOR_ID =?
		  AND g.csr_file_name          = MS_STARTER_FILES
		  AND c.cpc_inst_code          = g.csr_inst_code
		  AND c.cpc_prod_code          = g.csr_prod_code
		  AND c.cpc_card_type          = g.csr_card_type
		  AND t.cbp_inst_code          = b.cpm_inst_code
		  AND t.cbp_profile_code       = c.cpc_profile_code
		  AND t.cbp_param_name         = ''Service Code''
		  ) mm,
		  cms_appl_pan_temp,
		  cms_caf_info_entry
		WHERE cap_file_name  =MS_STARTER_FILES
		AND mm.cpm_inst_code = cap_inst_code
		AND mm.cpm_prod_code = cap_prod_code
		AND mm.cpc_inst_code = cap_inst_code
		AND mm.cpc_prod_code = cap_prod_code
		AND mm.cpc_card_type = cap_card_type
		AND cci_inst_code    =cap_inst_code
		AND cci_appl_code    =TO_CHAR(cap_appl_code)
		AND cci_inst_code    = mm.cpm_inst_code
		AND cci_file_name    = mm.csr_file_name
		AND cap_proxy_msg    = ''Success''
		ORDER BY cap_proxy_number'
        where vcq_query_id='CCF_CARDSTOCK_QRY';

		 

      DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Updated ');
	  
	     ELSE
      DBMS_OUTPUT.put_line ('Backup Object Not Found');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      v_err := SUBSTR (SQLERRM, 1, 100);
      DBMS_OUTPUT.put_line ('Main Excp ' || v_err);
END;
/