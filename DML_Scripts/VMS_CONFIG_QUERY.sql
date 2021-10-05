SET DEFINE OFF;
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_CARDSTOCK_QRY','SELECT cci_store_id loc,
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
		  --AND cp.CPC_CARD_ID           = c.CPC_CARD_ID
		    AND g.csr_card_id = cp.cpc_card_id
            AND g.csr_inst_code = cp.cpc_inst_code
            AND g.csr_prod_code = cp.cpc_prod_code
		  AND r.cpb_inst_bin           = ?
		  AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
		 -- AND CP.CPC_CARD_ID           =C.CPC_CARD_ID
		 -- AND CP.CPC_PROD_CODE         =C.CPC_PROD_CODE
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
		ORDER BY cap_proxy_number','loc,pan,encrPan,hashPan,expryDate,dispname,srvCode,acctNo,expirydate,prodCode,profCode,cardId,proxyNumber,cardType,cardStat,custCode,deliveryMethod,logoId,effectiveDate,packageId,orderType',1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_B2BHEADER_DTLQRY','SELECT VOD_PARENT_oid parentOrderId,
		  vod_order_id childOrderId,
		  vod_program_id programId,
		  DECODE(?,''Y'',
		  CASE
			WHEN ? = ''CCF_B2B_QRY''
			THEN (fn_dmaps_main(vod_firstname)
			  ||'' ''
			  ||fn_dmaps_main(vod_lastname))
			ELSE FN_B2B_EMBNAME(fn_dmaps_main(vod_firstname),fn_dmaps_main(vod_lastname),26)
		  END,
		  CASE
			WHEN ? = ''CCF_B2B_QRY''
			THEN vod_firstname
			  ||'' ''
			  ||vod_lastname
			ELSE FN_B2B_EMBNAME(vod_firstname,vod_lastname,26)
		  END )shipToName,
		  DECODE(?,''Y'',fn_dmaps_main(vod_address_line1),vod_address_line1) shiptoaddress1,
		  DECODE(?,''Y'',fn_dmaps_main(vod_address_line2),vod_address_line2) shipToAddress2,
		  DECODE(?,''Y'',fn_dmaps_main(vod_city)
		  ||'',''
		  ||fn_dmaps_main(vod_state)
		  ||'',''
		  ||fn_dmaps_main(vod_postalcode),vod_city
		  ||'',''
		  ||vod_state
		  ||'',''
		  ||vod_postalcode) shipToCityStatePostalcode,
		  DECODE(?,''Y'',fn_dmaps_main(vod_country),vod_country) countryName,
		  DECODE(?,''Y'',fn_dmaps_main(vod_ship_to_companyname),vod_ship_to_companyname) companyName,
		  VOD_ORDER_TYPE orderType,
		  '''' sourceOrderId
		FROM vms_order_details
		WHERE vod_order_id =?
		AND VOD_PARTNER_ID =?','parentOrderId,childOrderId,programId,shipToName,shipToAddress1,shipToAddress2,shipToCityStatePostalcode,countryName,companyName,orderType,sourceOrderId',1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_RESP_FILE_QRY','INSERT INTO VMS_RESPONSEFILE_DATA_TEMP(VRD_MAGIC_NUMBER,VRD_STATUS,VRD_CARRIER,VRD_DATE,VRD_TRACKING_NUMBER,
VRD_MERCHANT_ID,VRD_MERCHANT_NAME,VRD_STORELOCATIONID,VRD_BATCH_NUMBER,VRD_CASE_NUMBER,VRD_PALLET_NUMBER,VRD_SERIAL_NUMBER,VRD_SHIP_TO,
VRD_STREET_ADDR1,VRD_STREET_ADDR2,VRD_CITY,VRD_STATE,VRD_ZIP,VRD_DC_ID,VRD_PROD_ID,VRD_ORDER_ID,VRD_PARENT_SERIAL_NUMBER) VALUES
(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)','VARCHAR2,VARCHAR2,VARCHAR2,DATE,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2',1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),'4.6','CF');
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_RESP_FILE_DTLS_QRY','INSERT INTO VMS_RESPONSE_FILEUPLOAD_DTLS(VRF_INST_CODE,VRF_FILE_NAME,VRF_TOTAL_RECCOUNT,VRF_SUCCESS_RECCOUNT,
VRF_FAILURE_RECCOUNT,VRF_FAILURE_DESC,VRF_FILE_STATUS,VRF_INS_USER,VRF_LUPD_USER,VRF_INS_DATE,VRF_LUPD_DATE) VALUES(?,?,?,?,?,?,?,?,?,SYSDATE,SYSDATE)','N/A',1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),null,'CF');
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_RETN_FILE_QRY','INSERT INTO VMS_RETURNFILE_DATA_TEMP(VRD_CUSTOMER_DESC,VRD_SHIP_SUFFIX_NO,VRD_PARENT_ORDER_ID,VRD_CHILD_ORDER_ID,VRD_SERIAL_NUMBER,VRD_REJECT_CODE,VRD_REJECT_REASON,VRD_FILE_DATE,
VRD_CARD_TYPE,VRD_CLIENT_ORDER_ID)
VALUES(?,?,?,?,?,?,?,?,?,?)','VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,DATE,VARCHAR2,VARCHAR2',1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),'4.6','RF');
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_RETN_FILE_DTLS_QRY','INSERT INTO VMS_RETURN_FILEUPLOAD_DTLS(VRF_INST_CODE,VRF_FILE_NAME,VRF_TOTAL_RECCOUNT,VRF_SUCCESS_RECCOUNT,VRF_FAILURE_RECCOUNT,VRF_FAILURE_DESC,
VRF_FILE_STATUS,VRF_INS_USER,VRF_LUPD_USER,VRF_INS_DATE,VRF_LUPD_DATE) VALUES(?,?,?,?,?,?,?,?,?,SYSDATE,SYSDATE)','N/A',1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),null,'RF');
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_SHIP_FILE_QRY','INSERT INTO VMS_SHIPMENTFILE_DATA_TEMP(VSD_CUSTOMER_DESC,VSD_SOURCEONE_BATCH_NO,VSD_PARENT_ORDER_ID,VSD_CHILD_ORDER_ID,VSD_FILE_DATE,VSD_SERIAL_NUMBER,
VSD_CARDS,VSD_PACKAGE_ID,VSD_CARD_TYPE,VSD_CONTACT_NAME,VSD_SHIP_TO,VSD_ADDRESS_ONE,VSD_ADDRESS_TWO,VSD_CITY,VSD_STATE,VSD_ZIP,VSD_TRACKING_NUMBER,VSD_SHIP_DATE,VSD_SHIPMENT_ID,VSD_SHIPMENT_METHOD)
VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)','VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,DATE,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,DATE,VARCHAR2,VARCHAR2',1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),'4.6','SF');
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_SHIP_FILE_DTLS_QRY','INSERT INTO VMS_SHIPMENT_FILEUPLOAD_DTLS(VSF_INST_CODE,VSF_FILE_NAME,VSF_TOTAL_RECCOUNT,VSF_SUCCESS_RECCOUNT,VSF_FAILURE_RECCOUNT,VSF_FAILURE_DESC,
VSF_FILE_STATUS,VSF_INS_USER,VSF_LUPD_USER,VSF_INS_DATE,VSF_LUPD_DATE) VALUES(?,?,?,?,?,?,?,?,?,SYSDATE,SYSDATE)','N/A',1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),null,'SF');
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_B2BREPL_QRY','SELECT fn_dmaps_main (cap_pan_code_encr) pan,PACKIDMAST.VPM_VENDOR_ID,
		  CAP_SERIAL_NUMBER serialNo,''IND''  orderType,
		  cap_pan_code_encr encrPan,
		  cap_pan_code hashPan,
		  NVL(TO_CHAR(CAP_REPLACE_EXPRYDT,''YYMM''),TO_CHAR (cap_expry_date, ''YYMM'')) expryDate,
		  cbp_param_value srvCode,
		  cam_acct_bal acctbal,
		  cam_acct_no acctNo,
		  NVL(CAP_REPLACE_EXPRYDT, cap_expry_date) expirydate,
		  TO_CHAR (cap_pangen_date, ''YYMM'') effectiveDate,
		  cap_prod_code prodCode,
		  cpc_profile_code profCode,
		  PACKIDMAST.VPM_PACKAGE_ID AS cardId ,
		  PACKIDMAST.VPM_PACKAGE_ID AS packageId ,
		  cap_proxy_number proxyNumber,
		  cap_card_type cardType,
		  cap_card_stat cardStat,
		  cap_cust_code custCode,
		  DECODE (cap_repl_flag, 0, NVL(c.cpc_del_met,1),cap_repl_flag) deliveryMethod,
		  (SELECT LPAD(NVL(vpd_field_value,''0''),6,''0'')
		  FROM VMS_PACKAGEID_DETL
		  WHERE vpd_package_id=PACKIDMAST.VPM_PACKAGE_ID
		  AND vpd_field_key   =''logoId''
		  ) logoId,
		  ccs_card_status cardStatus,
		  cpb_inst_bin binNo
		FROM cms_appl_pan,
		  cms_cardissuance_status,
		  cms_bin_param,
		  cms_prod_mast,
		  cms_prod_bin,
		  cms_acct_mast,
		  cms_prod_cattype c,
		  cms_prod_cardpack cp,
		  VMS_PACKAGEID_MAST PACKIDMAST,
		  vms_shipment_tran_mast
		WHERE cap_inst_code   = ccs_inst_code
		AND cap_repl_flag                 = VSM_SHIPMENT_ID
		AND PACKIDMAST.VPM_PACKAGE_ID     =CP.CPC_CARD_DETAILS
		AND CP.CPC_CARD_ID                =C.CPC_CARD_ID
		AND cp.cpc_prod_code              =c.cpc_prod_code
		AND PACKIDMAST.VPM_VENDOR_ID      = ?
		AND cap_pan_code                  = ccs_pan_code
		AND cpm_inst_code                 = cap_inst_code
		AND cpm_prod_code                 = cap_prod_code
		AND cpm_prod_code                 = c.cpc_prod_code
		AND cpb_inst_code                 = cpm_inst_code
		AND cpb_prod_code                 =cpm_prod_code
		AND cbp_inst_code                 =cpm_inst_code
		AND cbp_profile_code              = cpc_profile_code
		AND cam_inst_code                 =cap_inst_code
		AND cam_acct_id                   =cap_acct_id
		AND c.cpc_inst_code               = cap_inst_code
		AND c.cpc_prod_code               = cap_prod_code
		AND c.cpc_card_type               = cap_card_type
		AND cp.CPC_INST_CODE              = c.cpc_inst_code
		AND cp.CPC_PROD_CODE              = c.cpc_prod_code
		AND NVL(C.CPC_B2B_FLAG,''N'')       =''Y''
		AND Cap_CARDpack_ID               =cp.CPC_CARD_ID
		AND CAP_PAN_CODE_ENCR            IS NOT NULL
		AND NVL(cap_repl_flag,0)         <> 0
		AND cap_inst_code                 =1
		AND cap_proxy_msg                 = ''Success''
		AND cbp_param_name                = ''Service Code''
		AND (ccs_card_status              = ''2''
		OR ccs_card_status                =''20'')
		AND ((NVL(CPC_CCF_SERIAL_FLAG,''N'')=''Y''
		AND CAP_SERIAL_NUMBER            IS NOT NULL)
		OR (CAP_SERIAL_NUMBER            IS NULL))
		AND c.CPC_CCF_FORMAT_VERSION      =?
		AND not exists
		  (SELECT vli_pan_code
		  FROM vms_line_item_dtl,
			vms_order_lineitem
		  WHERE vli_order_id =vol_order_id
		  AND vli_partner_id =vol_partner_id
		  AND VLI_LINEITEM_ID=VOL_LINE_ITEM_ID
		  AND VOL_CCF_FLAG  <> ''1'' and vli_pan_code=cap_pan_code
		  )
		ORDER BY cap_proxy_number','pan,serialNo,encrPan,hashPan,expryDate,srvCode,acctBal,expirydate,prodCode,profCode,cardId,proxyNumber,cardType,cardStat,custCode,deliveryMethod,logoId,cardStatus,binNo,acctNo,effectiveDate,packageId,orderType',1,to_date('06-NOV-17 05.35.24','DD-MON-RR HH.MI.SS'),1,to_date('06-JUN-18 04.36.39','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_B2BREPL_VENDOR_QRY','SELECT DISTINCT packIdMast.Vpm_Vendor_Id vendorId ,
  prodCat.cpc_ccf_format_version
FROM CMS_PROD_CATTYPE prodCat,
  cms_prod_cardpack cardpack,
  vms_packageid_mast packidmast,
  cms_appl_pan applpan,
  cms_cardissuance_status cs
WHERE applpan.cap_pan_code                  =cs.ccs_pan_code
AND (NVL( prodCat.CPC_B2B_FLAG,''N'')         =''Y''
OR (NVL(prodCat.CPC_B2B_FLAG,''N'')           =''Y''
AND NVL( prodCat.cpc_pan_inventory_flag,''N'')=''Y'' ))
AND (cs.ccs_card_status                     = ''2''
OR cs.ccs_card_status                       =''20'')
AND prodCat.cpc_prod_code                   =applpan.cap_prod_code
AND prodCat.cpc_card_type                   =applpan.cap_card_type
AND CARDPACK.CPC_PROD_CODE                  =PRODCAT.CPC_PROD_CODE
AND Cap_CARDpack_ID                         =cardpack.CPC_CARD_ID
AND NVL(cap_repl_flag,0)                   <> 0
AND packidmast.vpm_package_id               =cardpack.cpc_card_details
GROUP BY packIdMast.Vpm_Vendor_Id ,
  prodCat.cpc_ccf_format_version','vendorId',1,to_date('06-NOV-17 05.35.24','DD-MON-RR HH.MI.SS'),1,to_date('06-NOV-17 05.35.24','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_B2B_QRY','SELECT fn_dmaps_main (cap_pan_code_encr) pan,CAP_SERIAL_NUMBER serialNo,cap_pan_code_encr encrPan,cap_pan_code hashpan,TO_CHAR (cap_expry_date, ''YYMM'') expryDate,
				TO_CHAR (cap_pangen_date, ''YYMM'') effectiveDate,DECODE(c.CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(cap_disp_name),cap_disp_name) dispname,
				(Select cbp_param_value  FROM cms_bin_param where cbp_profile_code = cpc_profile_code AND cbp_param_name  = ''Service Code'') srvCode,
				cam_acct_bal acctbal,CASE WHEN CCM_BUSINESS_NAME IS NULL THEN CAST(cam_acct_bal as VARCHAR2(20))
				ELSE CCM_BUSINESS_NAME END AS acctbalBusiness,cam_acct_no acctNo,cap_expry_date expirydate,cap_prod_code prodCode,cpc_profile_code profCode,cp.CPC_CARD_DETAILS AS cardId ,
				cap_proxy_number proxyNumber,cap_card_type cardType,cap_card_stat cardStat,cap_cust_code custcode,vol_package_id packageId,
				(SELECT upper(DECODE(CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(NVL (decode(fn_dmaps_main(vol_embossedline),''null'',vpd_field_value,vol_embossedline), vpd_field_value)),NVL (decode(vol_embossedline,''null'',vpd_field_value,vol_embossedline), vpd_field_value)))
				  FROM vms_packageid_detl  WHERE vpd_package_id = vpm_package_id AND vpd_field_key = ''embossLine3'') fullname,
				  (SELECT DECODE(CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(NVL (decode(fn_dmaps_main(vol_embossedline),''null'',vpd_field_value,vol_embossedline), vpd_field_value)),NVL (decode(vol_embossedline,''null'',vpd_field_value,vol_embossedline), vpd_field_value))
					FROM vms_packageid_detl WHERE vpd_package_id = vpm_package_id AND vpd_field_key = ''embossLine3'') embName,
					(SELECT DECODE(CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(NVL (decode(fn_dmaps_main(VOL_EMBOSSED_LINE1),''null'',vpd_field_value,VOL_EMBOSSED_LINE1), vpd_field_value)),NVL (decode(VOL_EMBOSSED_LINE1,''null'',vpd_field_value,VOL_EMBOSSED_LINE1), vpd_field_value))
					FROM vms_packageid_detl WHERE vpd_package_id = vpm_package_id  AND vpd_field_key = ''embossLine4'') embNameTwo,
				  VSM_SHIPMENT_ID deliveryMethod,(select LPAD(NVL(vpd_field_value,''0''),6,''0'')  from VMS_PACKAGEID_DETL where vpd_package_id=PACKIDMAST.VPM_PACKAGE_ID and vpd_field_key=''logoId'') logoId,
				  cpB_INST_BIN binNo FROM cms_appl_pan,cms_cust_mast,cms_cardissuance_status,vms_order_lineitem,vms_order_details,vms_line_item_dtl,
					 cms_bin_param,cms_prod_mast,cms_prod_bin,cms_acct_mast,cms_prod_cattype c,cms_prod_cardpack cp,VMS_PACKAGEID_MAST PACKIDMAST,
					 vms_shipment_tran_mast where cap_inst_code = ccs_inst_code AND vod_shipping_method = VSM_SHIPMENT_KEY
				AND CAP_CUST_CODE = CCM_CUST_CODE AND CAP_INST_CODE = CCM_INST_CODE AND vod_order_id =vol_order_id AND vod_partner_id  =vol_partner_id
				AND vol_product_id =c.cpc_product_id AND vol_package_id =packidmast.vpm_package_id AND vol_order_id =vli_order_id AND vol_line_item_id  = vli_lineitem_id
				and cap_pan_code = vli_pan_code and vol_order_id  = ? AND vol_partner_id = ? AND PACKIDMAST.VPM_PACKAGE_ID = CP.CPC_CARD_DETAILS and cp.cpc_prod_code =c.cpc_prod_code
				AND PACKIDMAST.VPM_VENDOR_ID = ? AND cap_pan_code = ccs_pan_code AND cpm_inst_code = cap_inst_code AND cpm_prod_code = cap_prod_code
				AND cpm_prod_code = c.cpc_prod_code AND cpb_inst_code = cpm_inst_code AND cpb_prod_code =cpm_prod_code AND cbp_inst_code =cpm_inst_code
				AND cbp_profile_code = cpc_profile_code AND cam_inst_code =cap_inst_code AND cam_acct_id =cap_acct_id AND c.cpc_inst_code = cap_inst_code
				AND c.cpc_prod_code = cap_prod_code AND c.cpc_card_type = cap_card_type AND cp.CPC_INST_CODE = c.cpc_inst_code AND cp.CPC_PROD_CODE = c.cpc_prod_code AND NVL(C.CPC_B2B_FLAG,''N'') =''Y'' AND CAP_PAN_CODE_ENCR IS NOT NULL and cap_inst_code =1 AND cap_proxy_msg  = ''Success'' AND ccs_card_status = ''2'' AND ((NVL(CPC_CCF_SERIAL_FLAG,''N'')=''Y'' AND CAP_SERIAL_NUMBER is not null) OR (CAP_SERIAL_NUMBER is   null))
				AND NVL(cap_repl_flag,0) =0	and c.CPC_CCF_FORMAT_VERSION= ?
				and cbp_param_name=''CARD_VERIFY_TYPE'' and CBP_PARAM_VALUE = ?
				ORDER BY CAP_PROXY_NUMBER','pan,serialNo,encrPan,hashPan,expryDate,dispname,srvCode,acctBal,expirydate,prodCode,profCode,cardId,proxyNumber,cardType,cardStat,custcode,packageId,fullName,embName,embNameTwo,deliveryMethod,logoId,acctNo,binNo,effectiveDate,acctbalBusiness',1,to_date('06-NOV-17 04.19.12','DD-MON-RR HH.MI.SS'),1,to_date('30-AUG-18 10.11.07','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'SNO_FILE_QRY','INSERT INTO VMS_SERIAL_DETAILS_TEMP(VSD_PRODUCT_ID,VSD_SERIAL_NUMBER,VSD_VAN16) VALUES(?,?,?)','VARCHAR2,NUMBER,VARCHAR2',1,to_date('20-DEC-17 03.30.40','DD-MON-RR HH.MI.SS'),1,to_date('20-DEC-17 03.30.40','DD-MON-RR HH.MI.SS'),'4.6','SU');
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'SNO_FILE_HEAD_QRY','INSERT INTO VMS_SERIAL_HEADER_DETAILS(VSH_INST_CODE,VSH_FILE_NAME,VSH_MERCHANT_ID,VSH_VALUE_ONE,VSH_VALUE_TWO,VSH_DENOMINATION,VSH_PRODUCT_DESCRIPTION,VSH_INS_USER,VSH_LUPD_USER,VSH_INS_DATE,VSH_LUPD_DATE) VALUES(?,?,?,?,?,?,?,?,?,SYSDATE,SYSDATE)','NUMBER,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,VARCHAR2,NUMBER,NUMBER',1,to_date('20-DEC-17 03.30.40','DD-MON-RR HH.MI.SS'),1,to_date('20-DEC-17 03.30.40','DD-MON-RR HH.MI.SS'),null,'SU');
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'SNO_FILE_DTLS_QRY','INSERT INTO VMS_SERIAL_FILEUPLOAD_DTLS(VSF_INST_CODE,VSF_FILE_NAME,VSF_TOTAL_RECCOUNT,VSF_SUCCESS_RECCOUNT,VSF_FAILURE_RECCOUNT,VSF_FAILURE_DESC,
VSF_FILE_STATUS,VSF_INS_USER,VSF_LUPD_USER,VSF_INS_DATE,VSF_LUPD_DATE) VALUES(?,?,?,?,?,?,?,?,?,SYSDATE,SYSDATE)','N/A',1,to_date('20-DEC-17 03.30.40','DD-MON-RR HH.MI.SS'),1,to_date('20-DEC-17 03.30.40','DD-MON-RR HH.MI.SS'),null,'SU');
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_INV_QRY','SELECT NVL (TO_CHAR (cmm_location_id), ''*'') loc,
		  fn_dmaps_main (cap_pan_code_encr) pan,''RTL''  orderType,
		  cap_pan_code_encr encrPan,
		  cap_pan_code hashPan,
		  TO_CHAR (cap_expry_date, ''YYMM'') expryDate,
		  TO_CHAR (cap_pangen_date, ''YYMM'') effectiveDate,
		  Decode(mm.cpc_encrypt_enable ,''Y'',fn_dmaps_main(cap_disp_name) ,cap_disp_name) dispname,
		  mm.srvCode,
		  cap_acct_no acctNo,
		  cap_expry_date expirydate,
		  cap_prod_code prodCode,
		  mm.cpC_profile_code profCode,
		  CPC_CARD_DETAILS AS cardId ,
		  CPC_CARD_DETAILS AS packageId ,
		  cap_proxy_number proxyNumber,
		  cap_card_type cardType,
		  cap_card_stat cardStat,
		  cap_cust_code custCode,
		  DECODE (cap_repl_flag, 2, cap_repl_flag, NVL (mm.cpc_del_met, 1) ) deliveryMethod,
		 (select LPAD(NVL(vpd_field_value,''0''),6,''0'')  from VMS_PACKAGEID_DETL where vpd_package_id=PACKIDMAST.VPM_PACKAGE_ID  and vpd_field_key=''logoId'') logoId
		FROM cms_appl_pan_temp,
		cms_cardissuance_status cs,
		  cms_merinv_merpan,
		  CMS_MERINV_PRODCAT,
		  cms_prod_cardpack cp,
		  VMS_PACKAGEID_MAST PACKIDMAST,
		  (SELECT cpm_prod_code,
			CPM_PROD_DESC,cpc_encrypt_enable,
			c.CPC_CARD_ID,
			cpc_prod_code,
			cpc_profile_code,
			cpc_card_type,
			cpc_cardtype_desc,
			cpb_inst_bin,
			cpm_inst_code,
			cpc_del_met,
			cbp_param_value srvcode,
			LPAD(NVL(cpc_logo_id,''0''),6,''0'') logoId
		  FROM cms_prod_mast b,
			cms_prod_cattype c,
			cms_prod_bin r,
			cms_bin_param t
		  WHERE b.cpm_inst_code  = c.cpc_inst_code
		  AND b.cpm_prod_code    = c.cpc_prod_code
		  AND b.cpm_inst_code    = r.cpb_inst_code
		  AND B.CPM_PROD_CODE    = R.CPB_PROD_CODE
		  AND r.cpb_inst_bin     = ?
		  AND t.cbp_inst_code    = b.cpm_inst_code
		  AND t.cbp_profile_code = c.cpc_profile_code
		  AND t.cbp_param_name   = ''Service Code''
		  ) mm
		WHERE cap_inst_code          = cmm_inst_code
		AND cap_pan_code             = cmm_pan_code
		AND cmm_ordr_refrno         IN (MS_STARTER_FILES)
		AND cmm_inst_code            = cmp_inst_code
		AND cmm_merprodcat_id        = cmp_merprodcat_id
		AND cmp_inst_code            = mm.cpm_inst_code
		AND cmp_prod_code            = mm.cpc_prod_code
		AND cmp_prod_cattype         = mm.cpc_card_type
		AND cp.CPC_INST_CODE         = cmp_inst_code
		AND cp.CPC_PROD_CODE         = cmp_prod_code
		AND cp.CPC_CARD_ID           = CMP_CARD_ID
		AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
		AND cp.CPC_PROD_CODE         =mm.CPm_PROD_CODE
		AND PACKIDMAST.VPM_VENDOR_ID =?
		AND cap_proxy_msg            = ''Success''
		AND cap_pan_code=cs.ccs_pan_code  AND cs.ccs_card_status=''2''
		ORDER BY cap_proxy_number','loc,pan,encrPan,hashPan,expryDate,dispname,srvCode,acctNo,expirydate,prodCode,profCode,cardId,proxyNumber,cardType,cardStat,custCode,deliveryMethod,logoId,effectiveDate,packageId,orderType',1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'REGEN_CARDSTOCK_QRY','SELECT DISTINCT NVL(TO_CHAR(CML_LOCATION_ID),''*'') locId,
		  NVL(TO_CHAR(CML_LOCATION_ID),CCI_STORE_ID) loc,CASE WHEN cap_startercard_flag=''Y'' THEN ''RTL'' ELSE ''IND'' END  orderType,
		  FN_DMAPS_MAIN(CAP_PAN_CODE_ENCR) pan,
		  TO_CHAR(CAP_EXPRY_DATE,''YYMM'') expryDate,
		  TO_CHAR (cap_pangen_date, ''YYMM'') effectiveDate,
		  Decode(CT.CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(CAP_DISP_NAME),CAP_DISP_NAME) dispname,
		  CBP_PARAM_VALUE srvCode,
		  CAM_ACCT_NO acctNo,
		  CAP_EXPRY_DATE expirydate,
		  CAP_PROD_CODE prodCode,
		  CPC_PROFILE_CODE profCode,
		  NVL(cci_package_type,cp.cpc_card_details) cardId ,
		  NVL(cci_package_type,cp.cpc_card_details) packageId ,
		  CAP_PROXY_NUMBER proxyNumber ,
		  CAP_CARD_TYPE cardType,
		  DECODE (cap_repl_flag, 0, NVL(cpc_del_met,1),cap_repl_flag) deliveryMethod,
		  CAP_IPIN_OFFSET encryptedPinData,
		  (select LPAD(NVL(vpd_field_value,''0''),6,''0'')  from VMS_PACKAGEID_DETL where vpd_package_id=PACKIDMAST.VPM_PACKAGE_ID and vpd_field_key=''logoId'') logoId
		FROM CMS_APPL_PAN,
		  CMS_CARDISSUANCE_STATUS,
		  CMS_BIN_PARAM,
		  CMS_PROD_MAST,
		  CMS_ACCT_MAST,
		  CMS_PROD_CATTYPE CT,
		  cms_merinv_location,
		  CMS_MERINV_MERPAN pan,
		  CMS_CAF_INFO_ENTRY,
		  cms_prod_cardpack cp ,
		  CMS_MERINV_PRODCAT PM,
		   VMS_PACKAGEID_MAST PACKIDMAST
		WHERE CAP_INST_CODE    =CCS_INST_CODE
		AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
		AND CP.CPC_CARD_ID           =CT.CPC_CARD_ID
		AND CP.CPC_PROD_CODE         =Ct.CPC_PROD_CODE
		AND CAP_PAN_CODE       =CCS_PAN_CODE
		AND cap_mbr_numb       =''000''
		AND CBP_PROFILE_CODE   =CPC_PROFILE_CODE
		AND CPM_PROD_CODE      =CAP_PROD_CODE
		AND CAP_ACCT_ID        =CAM_ACCT_ID
		AND CBP_PARAM_NAME     =''Service Code''
		AND CCS_CCF_FNAME      =?
		AND ct.CPC_PROD_CODE   = CAP_PROD_CODE
		AND CPC_CARD_TYPE      = CAP_CARD_TYPE
		AND cam_inst_code      =cap_inst_code
		AND cpm_inst_code      =cap_inst_code
		AND CT.CPC_INST_CODE   =CAP_INST_CODE
		AND CBP_INST_CODE      =CAP_INST_CODE
		AND cp.CPC_CARD_ID     =ct.CPC_CARD_ID
		AND cp.cpc_inst_code   =ct.cpc_inst_code
		AND cap_appl_code      =cmm_appl_code(+)
		AND cmm_mer_id         = cml_mer_id(+)
		AND cmm_location_id    =cml_location_id(+)
		AND CAP_APPL_CODE      =CCI_APPL_CODE(+)
		AND CAP_PAN_CODE       = CMM_PAN_CODE(+)
		AND CAP_CARD_STAT     <> ''9''
		AND CAP_PAN_CODE_ENCR IS NOT NULL
		ORDER BY CAP_PROXY_NUMBER','locId,loc,pan,expryDate,dispname,srvCode,acctNo,expirydate,prodCode,profCode,cardId,proxyNumber,cardType,deliveryMethod,encryptedPinData,logoId,effectiveDate,packageId,orderType',1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_REISU_DTL_QUERY','SELECT cci_store_id loc,
		  fn_dmaps_main (cap_pan_code_encr) pan,''IND'' orderType,
		  cap_pan_code_encr encrPan,
		  cap_pan_code hashPan,
		  NVL(TO_CHAR(CAP_REPLACE_EXPRYDT,''YYMM''),TO_CHAR (cap_expry_date, ''YYMM'')) expryDate,
		  Decode(c.CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(CAP_DISP_NAME),CAP_DISP_NAME) dispname,
		  cbp_param_value srvCode,
		  cam_acct_no acctNo,
		  NVL(CAP_REPLACE_EXPRYDT, cap_expry_date) expirydate,
		  TO_CHAR (cap_pangen_date, ''YYMM'') effectiveDate,
		  cap_prod_code prodCode,
		  cpc_profile_code profCode,
		  PACKIDMAST.VPM_REPLACEMENT_PACKAGE_ID AS cardId ,
		  PACKIDMAST.VPM_REPLACEMENT_PACKAGE_ID AS packageId ,
		  cap_proxy_number proxyNumber,
		  cap_card_type cardType,
		  cap_card_stat cardStat,
		  cap_cust_code custCode,
		  cci_package_type packType,
		  DECODE (cap_repl_flag, 0, NVL(c.cpc_del_met,1),cap_repl_flag) deliveryMethod,
		  (select LPAD(NVL(vpd_field_value,''0''),6,''0'')  from VMS_PACKAGEID_DETL where vpd_package_id=PACKIDMAST.VPM_PACKAGE_ID and vpd_field_key=''logoId'') logoId,
		  ccs_card_status cardStatus
		FROM cms_appl_pan,
		  cms_cardissuance_status,
		  cms_bin_param,
		  cms_prod_mast,
		  cms_prod_bin,
		  cms_acct_mast,
		  cms_prod_cattype c,
		  cms_caf_info_entry ,
		  cms_prod_cardpack cp,
		  VMS_PACKAGEID_MAST PACKIDMAST
		WHERE cap_inst_code     = ccs_inst_code
		AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
		AND CP.CPC_CARD_ID     =C.CPC_CARD_ID
		AND cp.CPC_PROD_CODE   =c.CPC_PROD_CODE
		AND PACKIDMAST.VPM_VENDOR_ID=?
		AND cap_pan_code        = ccs_pan_code
		AND cpm_inst_code       = cap_inst_code
		AND cpm_prod_code       = cap_prod_code
		AND cpb_inst_code       = cpm_inst_code
		AND cpb_prod_code       =cpm_prod_code
		AND cbp_inst_code       =cpm_inst_code
		AND cbp_profile_code    = cpC_profile_code
		AND cam_inst_code       =cap_inst_code
		AND cam_acct_id         =cap_acct_id
		AND c.cpc_inst_code     = cap_inst_code
		AND c.cpc_prod_code     = cap_prod_code
		AND c.cpc_card_type     = cap_card_type
		AND cp.CPC_INST_CODE    = c.cpc_inst_code
		AND cp.CPC_PROD_CODE    = c.cpc_prod_code
		and (nvl( C.CPC_B2B_FLAG,''N'')=''N'' OR (nvl(C.CPC_B2B_FLAG,''N'')=''Y''  AND nvl( C.cpc_pan_inventory_flag,''N'')=''N'' ))
		AND  (NVL(C.cpc_user_identify_type,''2'') <> ''1'' )
		AND cp.CPC_CARD_ID      = c.CPC_CARD_ID
		AND cap_pan_code_encr  IS NOT NULL
		AND cci_appl_code(+)    =TO_CHAR(cap_appl_code)
		AND cap_pan_code       IN
		  (SELECT chr_new_pan
		  FROM CMS_HTLST_REISU
		  WHERE chr_inst_code=cap_inst_code
		  AND chr_new_pan    =cap_pan_code
		  AND CHR_REISU_CAUSE=''R''
		  )
		AND cap_inst_code       =1
		AND cap_mbr_numb        = ''000''
		AND cap_startercard_flag=''N''
		AND cap_card_stat      <> ''9''
		AND cap_proxy_msg       = ''Success''
		AND cpb_inst_bin        = ?
		AND cbp_param_name      = ''Service Code''
		AND (ccs_card_status    = ''2''
		OR ccs_card_status      =''20'')
		ORDER BY cap_proxy_number','loc,pan,encrPan,hashPan,expryDate,dispname,srvCode,acctNo,expirydate,prodCode,profCode,cardId,proxyNumber,cardType,cardStat,custCode,packType,deliveryMethod,logoId,cardStatus,effectiveDate,orderType',1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_DTL_QUERY','SELECT cci_store_id loc,
			  fn_dmaps_main (cap_pan_code_encr) pan,''IND''  orderType,
			  cap_pan_code_encr encrPan,
			  cap_pan_code hashPan,
			  NVL(TO_CHAR(CAP_REPLACE_EXPRYDT,''YYMM''),TO_CHAR (cap_expry_date, ''YYMM'')) expryDate,
			  Decode(c.CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(CAP_DISP_NAME),CAP_DISP_NAME) dispname,
			  cbp_param_value srvCode,
			  cam_acct_no acctNo,
			  NVL(CAP_REPLACE_EXPRYDT, cap_expry_date) expirydate,
			  TO_CHAR (cap_pangen_date, ''YYMM'') effectiveDate,
			  cap_prod_code prodCode,
			  cpc_profile_code profCode,
			  cp.CPC_CARD_DETAILS AS cardId ,
			  cap_proxy_number proxyNumber,
			  cap_card_type cardType,
			  cap_card_stat cardStat,
			  cap_cust_code custCode,
			  cci_package_type packType,
			  DECODE (cap_repl_flag, 0, NVL(c.cpc_del_met,1),cap_repl_flag) deliveryMethod,
			  (select LPAD(NVL(vpd_field_value,''0''),6,''0'')  from VMS_PACKAGEID_DETL where vpd_package_id=PACKIDMAST.VPM_PACKAGE_ID and vpd_field_key=''logoId'') logoId,
			  ccs_card_status  cardStatus
			FROM cms_appl_pan,
			  cms_cardissuance_status,
			  cms_bin_param,
			  cms_prod_mast,
			  cms_prod_bin,
			  cms_acct_mast,
			  cms_prod_cattype c,
			  cms_caf_info_entry ,
			  cms_prod_cardpack cp,  VMS_PACKAGEID_MAST PACKIDMAST
			WHERE cap_inst_code     = ccs_inst_code
			AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
			AND CP.CPC_CARD_ID     =C.CPC_CARD_ID
			AND cp.CPC_PROD_CODE   =c.CPC_PROD_CODE
			AND PACKIDMAST.VPM_VENDOR_ID=?
			AND cap_pan_code        = ccs_pan_code
			AND cpm_inst_code       = cap_inst_code
			AND cpm_prod_code       = cap_prod_code
			AND cpb_inst_code       = cpm_inst_code
			AND cpb_prod_code       =cpm_prod_code
			AND cbp_inst_code       =cpm_inst_code
			AND cbp_profile_code    = cpc_profile_code
			AND cam_inst_code       =cap_inst_code
			AND cam_acct_id         =cap_acct_id
			AND c.cpc_inst_code     = cap_inst_code
			AND c.cpc_prod_code     = cap_prod_code
			AND c.cpc_card_type     = cap_card_type
			AND cp.CPC_INST_CODE    = c.cpc_inst_code
			AND cp.CPC_PROD_CODE    = c.cpc_prod_code
			AND cp.CPC_CARD_ID      = c.CPC_CARD_ID
			and (nvl( C.CPC_B2B_FLAG,''N'')=''N'' OR (nvl(C.CPC_B2B_FLAG,''N'')=''Y''  AND nvl( C.cpc_pan_inventory_flag,''N'')=''N'')
			  )
			AND (nvl(C.cpc_user_identify_type,''2'') <> ''1'' )
			AND cap_pan_code_encr  IS NOT NULL
			AND cci_appl_code(+)    =TO_CHAR(cap_appl_code)
			AND cap_pan_code NOT   IN
			  (SELECT chr_new_pan
			  FROM CMS_HTLST_REISU
			  WHERE chr_inst_code=cap_inst_code
			  AND chr_new_pan    =cap_pan_code
			  AND CHR_REISU_CAUSE=''R''
			  )
			AND cap_inst_code       =1
			AND cap_mbr_numb        = ''000''
			AND cap_startercard_flag=''N''
			AND cap_card_stat      <> ''9''
			AND cap_proxy_msg       = ''Success''
			AND cpb_inst_bin        = ?
			AND cbp_param_name      = ''Service Code''
			AND (ccs_card_status    = ''2''
			OR ccs_card_status      =''20'')
			ORDER BY cap_proxy_number','loc,pan,encrPan,hashPan,expryDate,dispname,srvCode,acctNo,expirydate,prodCode,profCode,cardId,proxyNumber,cardType,cardStat,custCode,packType,deliveryMethod,logoId,cardStatus,effectiveDate,orderType',1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_B2BORDER_REPLQRY','SELECT fn_dmaps_main (cap_pan_code_encr) pan,CAP_SERIAL_NUMBER serialNo,cap_pan_code_encr encrPan,DECODE(c.CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(cap_disp_name),cap_disp_name) dispname,cap_pan_code hashPan,
					NVL(TO_CHAR(CAP_REPLACE_EXPRYDT,''YYMM''),TO_CHAR (cap_expry_date, ''YYMM'')) expryDate, 
			  (Select cbp_param_value  FROM cms_bin_param where 
			  cbp_profile_code  = cpc_profile_code AND cbp_param_name  = ''Service Code'') srvCode,
			  cam_acct_bal acctbal, case when ccm_business_name is null then cast(cam_acct_bal as varchar2(20))
					ELSE CCM_BUSINESS_NAME END AS acctbalBusiness,cam_acct_no acctNo, NVL(CAP_REPLACE_EXPRYDT, cap_expry_date) expirydate, TO_CHAR (cap_pangen_date, ''YYMM'') effectiveDate, cap_prod_code prodCode, cpc_profile_code profCode,
					PACKIDMAST.VPM_REPLACEMENT_PACKAGE_ID AS cardId , PACKIDMAST.VPM_REPLACEMENT_PACKAGE_ID AS packageId , cap_proxy_number proxyNumber, cap_card_type cardType, cap_card_stat cardStat, cap_cust_code custCode,
					DECODE(cap_repl_flag,0,NVL(c.cpc_del_met,1),cap_repl_flag) deliveryMethod, (SELECT LPAD(NVL(vpd_field_value,''0''),6,''0'') FROM VMS_PACKAGEID_DETL WHERE vpd_package_id=PACKIDMAST.VPM_PACKAGE_ID AND vpd_field_key   =''logoId'' ) logoId,
					ccs_card_status cardStatus,cpb_inst_bin binNo,(SELECT upper(DECODE(CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(NVL (decode(fn_dmaps_main(vol_embossedline),''null'',vpd_field_value,vol_embossedline), vpd_field_value)),NVL (decode(vol_embossedline,''null'',vpd_field_value,vol_embossedline), vpd_field_value)))FROM vms_packageid_detl
					WHERE vpd_package_id = vpm_package_id AND vpd_field_key= ''embossLine3'') fullname,(SELECT DECODE(CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(NVL (decode(fn_dmaps_main(vol_embossedline),''null'',vpd_field_value,vol_embossedline), vpd_field_value)),NVL(decode(vol_embossedline,''null'',vpd_field_value,vol_embossedline), vpd_field_value)) FROM vms_packageid_detl
					WHERE vpd_package_id = vpm_package_id AND vpd_field_key = ''embossLine3'' ) embName, (SELECT DECODE(CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(NVL (decode(fn_dmaps_main(VOL_EMBOSSED_LINE1),''null'',vpd_field_value,VOL_EMBOSSED_LINE1), vpd_field_value)),NVL(decode(VOL_EMBOSSED_LINE1,''null'',vpd_field_value,VOL_EMBOSSED_LINE1), vpd_field_value))
					FROM vms_packageid_detl WHERE vpd_package_id = vpm_package_id AND vpd_field_key = ''embossLine4'' ) embNameTwo  FROM cms_appl_pan,cms_cust_mast, cms_cardissuance_status, cms_bin_param, cms_prod_mast, cms_prod_bin, cms_acct_mast, cms_prod_cattype c, cms_prod_cardpack cp, VMS_PACKAGEID_MAST PACKIDMAST,
					vms_shipment_tran_mast ,vms_order_lineitem,vms_line_item_dtl  WHERE cap_inst_code= ccs_inst_code AND vol_order_id  =vli_order_id  AND vli_order_id = ?  AND vli_partner_id =? AND vol_line_item_id  =vli_lineitem_id  AND vol_partner_id  = vli_partner_id
					AND vli_partner_id=''Replace_Partner_ID'' AND cap_pan_code= vli_pan_code  AND VOl_CCF_FLAG=''1'' AND to_char(cap_repl_flag) = VSM_SHIPMENT_ID AND PACKIDMAST.VPM_PACKAGE_ID =CP.CPC_CARD_DETAILS AND PACKIDMAST.VPM_PACKAGE_ID =vol_package_id  AND cp.cpc_prod_code =c.cpc_prod_code AND PACKIDMAST.VPM_VENDOR_ID= ?
					AND cap_pan_code= ccs_pan_code AND CAP_CUST_CODE = CCM_CUST_CODE  AND cpm_inst_code= cap_inst_code AND cpm_prod_code= cap_prod_code AND cpm_prod_code= c.cpc_prod_code AND cpb_inst_code= cpm_inst_code  AND cpb_prod_code=cpm_prod_code  AND cbp_inst_code=cpm_inst_code  AND cbp_profile_code=cpc_profile_code
					AND cam_inst_code=cap_inst_code AND cam_acct_id=cap_acct_id   AND c.cpc_inst_code=cap_inst_code AND c.cpc_prod_code=cap_prod_code AND c.cpc_card_type=cap_card_type AND cp.CPC_INST_CODE=c.cpc_inst_code  AND cp.CPC_PROD_CODE=c.cpc_prod_code  AND CAP_PAN_CODE_ENCR IS NOT NULL AND NVL(cap_repl_flag,0) <> 0 AND cap_inst_code=1 AND cap_proxy_msg=''Success''
					AND (ccs_card_status=''2'' OR ccs_card_status =''20'') AND c.CPC_CCF_FORMAT_VERSION =? 
			  and cbp_param_name=''CARD_VERIFY_TYPE'' and CBP_PARAM_VALUE = ?
			  ORDER BY cap_proxy_number','pan,serialNo,encrPan,hashPan,expryDate,dispname,srvCode,acctBal,expirydate,prodCode,profCode,cardId,proxyNumber,cardType,cardStat,custcode,packageId,fullName,embName,embNameTwo,deliveryMethod,logoId,acctNo,binNo,effectiveDate,acctbalBusiness',1,to_date('13-MAR-18 04.30.36','DD-MON-RR HH.MI.SS'),1,to_date('13-MAR-18 04.30.36','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'CCF_B2BREPL_ORDERQRY','SELECT DISTINCT vol_order_id oid ,
				  vol_partner_id pid,
				  prodCat.cpc_prod_code prId,
				  prodCat.CPC_CCF_FORMAT_VERSION vId,
				  vod_individual_ccf indccf ,vod_print_order prinfOdrCcf
				FROM CMS_PROD_CATTYPE prodCat,
				  cms_prod_cardpack cardpack,
				  vms_packageid_mast packidmast,
				  vms_order_lineitem,
				  vms_order_details
          ,cms_bin_param
				WHERE cpc_product_id         =vol_product_id
				AND vol_ccf_flag             =''1''
				AND vol_order_id             =vod_order_id
				AND vol_partner_id           =vod_partner_id
				AND vol_partner_id           =''Replace_Partner_ID''
				AND CARDPACK.CPC_PROD_CODE   =PRODCAT.CPC_PROD_CODE
				AND packidmast.vpm_package_id=cpc_card_details
				AND packIdMast.Vpm_Vendor_Id =?
        AND cbp_profile_code=cpc_profile_code
        and cbp_param_name=''CARD_VERIFY_TYPE''
        and CBP_PARAM_VALUE = ?
				GROUP BY vol_order_id ,
				  vol_partner_id ,
				  prodCat.CPC_CCF_FORMAT_VERSION,
				  prodCat.cpc_prod_code,
				  vod_individual_ccf,vod_print_order','vendorId',1,to_date('13-MAR-18 04.30.36','DD-MON-RR HH.MI.SS'),1,to_date('13-MAR-18 04.30.36','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'B2B_VENDOR_LIST_QRYNAME',' SELECT DISTINCT packIdMast.Vpm_Vendor_Id vendorId
FROM    vms_packageid_mast packidmast,
vms_order_details,  vms_order_lineitem
WHERE vol_order_id  =vod_order_id
AND VOD_PARTNER_ID=VOL_PARTNER_ID
AND vol_ccf_flag =''1'' AND packidmast.vpm_package_id=VOL_PACKAGE_ID ',' ',1,to_date('22-MAY-18 04.36.49','DD-MON-RR HH.MI.SS'),1,to_date('22-MAY-18 04.36.49','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'B2B_ORDER_IDQRYNAME','SELECT DISTINCT vol_order_id oid ,
			  vol_partner_id pid,
			  prodCat.CPC_CCF_FORMAT_VERSION vId ,
			  vod_individual_ccf indccf,vod_print_order prinfOdrCcf
			FROM CMS_PROD_CATTYPE prodCat,
			  cms_prod_cardpack cardpack,
			  vms_packageid_mast packidmast,
			  vms_order_lineitem,
			  vms_order_details
        ,cms_bin_param
			WHERE cpc_product_id         =vol_product_id
			AND vol_ccf_flag             =''1''
			AND vol_order_id             =vod_order_id
			AND vol_partner_id           =vod_partner_id
			AND CARDPACK.CPC_PROD_CODE   =PRODCAT.CPC_PROD_CODE
			AND packidmast.vpm_package_id=cpc_card_details
			AND packIdMast.Vpm_Vendor_Id = ?
      AND cbp_profile_code=cpc_profile_code
      and cbp_param_name=''CARD_VERIFY_TYPE''
      and CBP_PARAM_VALUE = ?
			AND vol_partner_id          <> ''Replace_Partner_ID''
			GROUP BY vol_order_id ,
			  vol_partner_id ,
			  prodCat.CPC_CCF_FORMAT_VERSION,
			  vod_individual_ccf,vod_print_order',' ',1,to_date('22-MAY-18 04.36.49','DD-MON-RR HH.MI.SS'),1,to_date('22-MAY-18 04.36.49','DD-MON-RR HH.MI.SS'),null,null);
Insert into vmscms.VMS_CONFIG_QUERY (VCQ_INST_CODE,VCQ_QUERY_ID,VCQ_QUERY_VALUE,VCQ_QUERY_SELECTVALUE,VCQ_INS_USER,VCQ_INS_DATE,VCQ_LUPD_USER,VCQ_LUPD_DATE,VCQ_VERSION_NAME,VCQ_FILE_IDENTIFIER) values (1,'REGEN_INV_QRY','SELECT DISTINCT NVL(TO_CHAR(CML_LOCATION_ID),''*'') locId,
		  NVL(TO_CHAR(CML_LOCATION_ID),CCI_STORE_ID) loc,CASE WHEN cap_startercard_flag=''Y'' THEN ''RTL'' ELSE ''IND'' END  orderType,
		  FN_DMAPS_MAIN(CAP_PAN_CODE_ENCR) pan,
		  TO_CHAR(CAP_EXPRY_DATE,''YYMM'') expryDate,
		  TO_CHAR (cap_pangen_date, ''YYMM'') effectiveDate,
		  Decode(CT.CPC_ENCRYPT_ENABLE,''Y'',fn_dmaps_main(CAP_DISP_NAME),CAP_DISP_NAME) dispname,
		  CBP_PARAM_VALUE srvCode,
		  CAM_ACCT_NO acctNo,
		  CAP_EXPRY_DATE expirydate,
		  CAP_PROD_CODE prodCode,
		  CPc_PROFILE_CODE profCode,
		  NVL(cci_package_type,cp.cpc_card_details) cardId ,
		  NVL(cci_package_type,cp.cpc_card_details) packageId ,
		  CAP_PROXY_NUMBER proxyNumber ,
		  CAP_CARD_TYPE cardType,
		  DECODE (cap_repl_flag, 0, NVL(cpc_del_met,1),cap_repl_flag) deliveryMethod,
		  CAP_IPIN_OFFSET encryptedPinData,
		  (select LPAD(NVL(vpd_field_value,''0''),6,''0'')  from VMS_PACKAGEID_DETL where vpd_package_id=PACKIDMAST.VPM_PACKAGE_ID and vpd_field_key=''logoId'') logoId
		FROM CMS_APPL_PAN,
		  CMS_CARDISSUANCE_STATUS,
		  CMS_BIN_PARAM,
		  CMS_PROD_MAST,
		  CMS_ACCT_MAST,
		  CMS_PROD_CATTYPE CT,
		  cms_merinv_location,
		  CMS_MERINV_MERPAN pan,
		  CMS_CAF_INFO_ENTRY,
		  cms_prod_cardpack cp ,
		  CMS_MERINV_PRODCAT PM,
		  VMS_PACKAGEID_MAST PACKIDMAST
		WHERE CAP_INST_CODE      =CCS_INST_CODE
		AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
		AND CP.CPC_PROD_CODE         =Ct.CPC_PROD_CODE
		AND CAP_PAN_CODE         =CCS_PAN_CODE
		AND cap_mbr_numb         =''000''
		AND CBP_PROFILE_CODE     =CPC_PROFILE_CODE
		AND CPM_PROD_CODE        =CAP_PROD_CODE
		AND CAP_ACCT_ID          =CAM_ACCT_ID
		AND CBP_PARAM_NAME       =''Service Code''
		AND CCS_CCF_FNAME        =?
		AND ct.CPC_PROD_CODE     = CAP_PROD_CODE
		AND CPC_CARD_TYPE        = CAP_CARD_TYPE
		AND cam_inst_code        =cap_inst_code
		AND cpm_inst_code        =cap_inst_code
		AND ct.cpc_inst_code     =cap_inst_code
		AND cbp_inst_code        =cap_inst_code
		AND pm.cmp_card_id       =cp.cpc_card_id
		AND pan.cmm_merprodcat_id=pm.cmp_merprodcat_id
		AND cap_appl_code        =cmm_appl_code(+)
		AND cmm_mer_id           = cml_mer_id(+)
		AND cmm_location_id      =cml_location_id(+)
		AND CAP_APPL_CODE        =CCI_APPL_CODE(+)
		AND CAP_PAN_CODE         = CMM_PAN_CODE(+)
		AND CAP_CARD_STAT       <> ''9''
		AND CAP_PAN_CODE_ENCR   IS NOT NULL
		ORDER BY CAP_PROXY_NUMBER','locId,loc,pan,expryDate,dispname,srvCode,acctNo,expirydate,prodCode,profCode,cardId,proxyNumber,cardType,deliveryMethod,encryptedPinData,logoId,effectiveDate,packageId,orderType',1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),1,to_date('30-OCT-17 03.39.23','DD-MON-RR HH.MI.SS'),null,null);
