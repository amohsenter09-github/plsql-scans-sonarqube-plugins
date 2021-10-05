DECLARE
    v_err     VARCHAR2 (1000);
    q1        CLOB;
    q2        CLOB;
BEGIN

    q1 := 'SELECT fn_dmaps_main(cap_pan_code_encr) pan,
       cpc_src_app srcApp,
       vol_image_url imageUrl,
       vol_giftbox_id giftBoxId,
       CAP_SERIAL_NUMBER serialNo,
       cap_pan_code_encr encrPan,
       cap_pan_code hashpan,
       TO_CHAR(cap_expry_date, ''YYMM'') expryDate,
       TO_CHAR(cap_pangen_date, ''YYMM'') effectiveDate,
       DECODE(c.CPC_ENCRYPT_ENABLE, ''Y'', fn_dmaps_main(cap_disp_name), cap_disp_name) dispname,
       (Select cbp_param_value
        FROM cms_bin_param
        where cbp_profile_code = cpc_profile_code AND cbp_param_name = ''Service Code'') srvCode,
       trim(TO_CHAR(cam_acct_bal, 9999999990.99)) acctbal,
       FN_DMAPS_MAIN(DECODE(vol_embossed_line1, ''null'', NULL, vol_embossed_line1)) AS acctbalBusiness,
       cam_acct_no acctNo,
       cap_expry_date expirydate,
       cap_prod_code prodCode,
       cpc_profile_code profCode,
       cp.CPC_CARD_DETAILS AS cardId,
       cap_proxy_number proxyNumber,
       cap_card_type cardType,
       cap_card_stat cardStat,
       cap_cust_code custcode,
       vol_package_id packageId,
       (SELECT upper(DECODE(CPC_ENCRYPT_ENABLE, ''Y'',
                            fn_dmaps_main(NVL(decode(vol_embossedline, ''null'', vpd_field_value, vol_embossedline),
                                              vpd_field_value)),
                            NVL(decode(vol_embossedline, ''null'', vpd_field_value, vol_embossedline), vpd_field_value)))
        FROM vms_packageid_detl
        WHERE vpd_package_id = vpm_package_id
          AND vpd_field_key = ''embossLine3'') fullname,
       (SELECT DECODE(CPC_ENCRYPT_ENABLE, ''Y'',
                      fn_dmaps_main(NVL(decode(vol_embossedline, ''null'', vpd_field_value, vol_embossedline),
                                        vpd_field_value)),
                      NVL(decode(vol_embossedline, ''null'', vpd_field_value, vol_embossedline), vpd_field_value))
        FROM vms_packageid_detl
        WHERE vpd_package_id = vpm_package_id
          AND vpd_field_key = ''embossLine3'') embName,
       (SELECT DECODE(CPC_ENCRYPT_ENABLE, ''Y'',
                      fn_dmaps_main(NVL(decode(VOL_EMBOSSED_LINE1, ''null'', vpd_field_value, VOL_EMBOSSED_LINE1),
                                        vpd_field_value)),
                      NVL(decode(VOL_EMBOSSED_LINE1, ''null'', vpd_field_value, VOL_EMBOSSED_LINE1), vpd_field_value))
        FROM vms_packageid_detl
        WHERE vpd_package_id = vpm_package_id
          AND vpd_field_key = ''embossLine4'') embNameTwo,
       VSM_SHIPMENT_ID deliveryMethod,
       nvl(NVL(vol_logo_id, (select LPAD(NVL(vpl_logo_id, ''0''), 6, ''0'')
                             from VMS_PACKID_LOGOID_MAPPING
                             where vpl_package_id = vol_package_id
                               and vpl_default_flag = ''Y'')), ''000000'') logoId,
       cpB_INST_BIN binNo,
       VOL_CARRIER_MSG carrierMessage,
       VOL_CARRIER_TO carrierTo,
       VOL_CARRIER_FROM carrierFrom,
       '''' carrierToFrom,
       trim(TO_CHAR(vms_order_lineitem.VOL_DENOMINATION, 9999999990.99)) orderAmount
FROM cms_appl_pan,
     cms_cust_mast,
     cms_cardissuance_status,
     vms_order_lineitem,
     vms_order_details,
     vms_line_item_dtl,
     cms_bin_param,
     cms_prod_mast,
     cms_prod_bin,
     cms_acct_mast,
     cms_prod_cattype c,
     cms_prod_cardpack cp,
     VMS_PACKAGEID_MAST PACKIDMAST,
     vms_shipment_tran_mast
where cap_inst_code = ccs_inst_code
  AND vod_shipping_method = VSM_SHIPMENT_KEY
  AND CAP_CUST_CODE = CCM_CUST_CODE
  AND CAP_INST_CODE = CCM_INST_CODE
  AND vod_order_id = vol_order_id
  AND vod_partner_id = vol_partner_id
  AND vol_product_id = c.cpc_product_id
  AND vol_package_id = packidmast.vpm_package_id
  AND vol_order_id = vli_order_id
  AND vol_line_item_id = vli_lineitem_id
  and cap_pan_code = vli_pan_code
  and vol_order_id = ?
  AND vol_partner_id = ?
  AND PACKIDMAST.VPM_PACKAGE_ID = CP.CPC_CARD_DETAILS
  and cp.cpc_prod_code = c.cpc_prod_code
  AND PACKIDMAST.VPM_VENDOR_ID = ?
  AND cap_pan_code = ccs_pan_code
  AND cpm_inst_code = cap_inst_code
  AND cpm_prod_code = cap_prod_code
  AND cpm_prod_code = c.cpc_prod_code
  AND cpb_inst_code = cpm_inst_code
  AND cpb_prod_code = cpm_prod_code
  AND cbp_inst_code = cpm_inst_code
  AND cbp_profile_code = cpc_profile_code
  AND cam_inst_code = cap_inst_code
  AND cam_acct_id = cap_acct_id
  AND c.cpc_inst_code = cap_inst_code
  AND c.cpc_prod_code = cap_prod_code
  AND c.cpc_card_type = cap_card_type
  AND cp.CPC_INST_CODE = c.cpc_inst_code
  AND cp.CPC_PROD_CODE = c.cpc_prod_code
  AND NVL(C.CPC_B2B_FLAG, ''N'') = ''Y''
  AND CAP_PAN_CODE_ENCR IS NOT NULL
  and cap_inst_code = 1
  AND cap_proxy_msg = ''Success''
  AND ccs_card_status = ''2''
  AND ((NVL(CPC_CCF_SERIAL_FLAG, ''N'') = ''Y'' AND CAP_SERIAL_NUMBER is not null) OR (CAP_SERIAL_NUMBER is null))
  AND NVL(cap_repl_flag, 0) = 0
  AND c.CPC_CCF_FORMAT_VERSION = ?
  and cbp_param_name = ''CARD_VERIFY_TYPE''
  and CBP_PARAM_VALUE = ?
ORDER BY CAP_PROXY_NUMBER';

    UPDATE vmscms.vms_config_query
    SET    vcq_query_value = q1
    WHERE  vcq_inst_code = 1
           AND vcq_query_id = 'CCF_B2B_QRY';

    q2 := 'SELECT cpc_src_app srcApp,
       fn_dmaps_main(cap_pan_code_encr) pan,
       vol_image_url imageUrl,
       vol_giftbox_id giftBoxId,
       CAP_SERIAL_NUMBER serialNo,
       cap_pan_code_encr encrPan,
       DECODE(c.CPC_ENCRYPT_ENABLE, ''Y'', fn_dmaps_main(cap_disp_name), cap_disp_name) dispname,
       cap_pan_code hashPan,
       NVL(TO_CHAR(CAP_REPLACE_EXPRYDT, ''YYMM''), TO_CHAR(cap_expry_date, ''YYMM'')) expryDate,
       (Select cbp_param_value
        FROM cms_bin_param
        where cbp_profile_code = cpc_profile_code AND cbp_param_name = ''Service Code'') srvCode,
       trim(TO_CHAR(cam_acct_bal, 9999999990.99)) acctbal,
       FN_DMAPS_MAIN(DECODE(vol_embossed_line1, ''null'', NULL, vol_embossed_line1)) AS acctbalBusiness,
       cam_acct_no acctNo,
       NVL(CAP_REPLACE_EXPRYDT, cap_expry_date) expirydate,
       TO_CHAR(cap_pangen_date, ''YYMM'') effectiveDate,
       cap_prod_code prodCode,
       cpc_profile_code profCode,
       PACKIDMAST.VPM_REPLACEMENT_PACKAGE_ID AS cardId,
       PACKIDMAST.VPM_REPLACEMENT_PACKAGE_ID AS packageId,
       cap_proxy_number proxyNumber,
       cap_card_type cardType,
       cap_card_stat cardStat,
       cap_cust_code custCode,
       DECODE(cap_repl_flag, 0, NVL(c.cpc_del_met, 1), cap_repl_flag) deliveryMethod,
       nvl(NVL(vol_logo_id, (select LPAD(NVL(vpl_logo_id, ''0''), 6, ''0'')
                             from VMS_PACKID_LOGOID_MAPPING
                             where vpl_package_id = PACKIDMAST.VPM_REPLACEMENT_PACKAGE_ID
                               and vpl_default_flag = ''Y'')), ''000000'') logoId,
       ccs_card_status cardStatus,
       cpb_inst_bin binNo,
       (SELECT upper(DECODE(CPC_ENCRYPT_ENABLE, ''Y'', fn_dmaps_main(NVL(
               decode(fn_dmaps_main(vol_embossedline), ''null'', vpd_field_value, vol_embossedline), vpd_field_value)),
                            NVL(decode(vol_embossedline, ''null'', vpd_field_value, vol_embossedline), vpd_field_value)))
        FROM vms_packageid_detl
        WHERE vpd_package_id = vpm_package_id
          AND vpd_field_key = ''embossLine3'') fullname,
       (SELECT DECODE(CPC_ENCRYPT_ENABLE, ''Y'', fn_dmaps_main(NVL(
               decode(fn_dmaps_main(vol_embossedline), ''null'', vpd_field_value, vol_embossedline), vpd_field_value)),
                      NVL(decode(vol_embossedline, ''null'', vpd_field_value, vol_embossedline), vpd_field_value))
        FROM vms_packageid_detl
        WHERE vpd_package_id = vpm_package_id
          AND vpd_field_key = ''embossLine3'') embName,
       (SELECT DECODE(CPC_ENCRYPT_ENABLE, ''Y'', fn_dmaps_main(NVL(
               decode(fn_dmaps_main(VOL_EMBOSSED_LINE1), ''null'', vpd_field_value, VOL_EMBOSSED_LINE1),
               vpd_field_value)),
                      NVL(decode(VOL_EMBOSSED_LINE1, ''null'', vpd_field_value, VOL_EMBOSSED_LINE1), vpd_field_value))
        FROM vms_packageid_detl
        WHERE vpd_package_id = vpm_package_id
          AND vpd_field_key = ''embossLine4'') embNameTwo,
       trim(TO_CHAR(cam_acct_bal, 9999999990.99)) orderAmount
FROM cms_appl_pan,
     cms_cust_mast,
     cms_cardissuance_status,
     cms_bin_param,
     cms_prod_mast,
     cms_prod_bin,
     cms_acct_mast,
     cms_prod_cattype c,
     cms_prod_cardpack cp,
     VMS_PACKAGEID_MAST PACKIDMAST,
     vms_shipment_tran_mast,
     vms_order_lineitem,
     vms_line_item_dtl
WHERE cap_inst_code = ccs_inst_code
  AND vol_order_id = vli_order_id
  AND vli_order_id = ?
  AND vli_partner_id = ?
  AND vol_line_item_id = vli_lineitem_id
  AND vol_partner_id = vli_partner_id
  AND vli_partner_id = ''Replace_Partner_ID''
  AND cap_pan_code = vli_pan_code
  AND VOl_CCF_FLAG = ''1''
  AND to_char(cap_repl_flag) = VSM_SHIPMENT_ID
  AND PACKIDMAST.VPM_PACKAGE_ID = CP.CPC_CARD_DETAILS
  AND PACKIDMAST.VPM_PACKAGE_ID = vol_package_id
  AND cp.cpc_prod_code = c.cpc_prod_code
  AND PACKIDMAST.VPM_VENDOR_ID = ?
  AND cap_pan_code = ccs_pan_code
  AND CAP_CUST_CODE = CCM_CUST_CODE
  AND cap_inst_code = ccm_inst_code
  AND cpm_inst_code = cap_inst_code
  AND cpm_prod_code = cap_prod_code
  AND cpm_prod_code = c.cpc_prod_code
  AND cpb_inst_code = cpm_inst_code
  AND cpb_prod_code = cpm_prod_code
  AND cbp_inst_code = cpm_inst_code
  AND cbp_profile_code = cpc_profile_code
  AND cam_inst_code = cap_inst_code
  AND cam_acct_id = cap_acct_id
  AND c.cpc_inst_code = cap_inst_code
  AND c.cpc_prod_code = cap_prod_code
  AND c.cpc_card_type = cap_card_type
  AND cp.CPC_INST_CODE = c.cpc_inst_code
  AND cp.CPC_PROD_CODE = c.cpc_prod_code
  AND CAP_PAN_CODE_ENCR IS NOT NULL
  AND NVL(cap_repl_flag, 0) <> 0
  AND cap_inst_code = 1
  AND cap_proxy_msg = ''Success''
  AND cap_card_stat <> ''9''
  AND (ccs_card_status = ''2'' OR ccs_card_status = ''20'')
  AND c.CPC_CCF_FORMAT_VERSION = ?
  and cbp_param_name = ''CARD_VERIFY_TYPE''
  and CBP_PARAM_VALUE = ?
ORDER BY cap_proxy_number';

    UPDATE vmscms.vms_config_query
    SET    vcq_query_value = q2
    WHERE  vcq_inst_code = 1
           AND vcq_query_id = 'CCF_B2BORDER_REPLQRY';

EXCEPTION
    WHEN OTHERS THEN
      v_err := Substr (SQLERRM, 1, 100);

      dbms_output.Put_line ('Main Excp '
                            || v_err);
END;

/


--select * from vmscms.vms_config_query where vcq_inst_code = 1 and vcq_query_id in ('CCF_B2B_QRY', 'CCF_B2BORDER_REPLQRY');