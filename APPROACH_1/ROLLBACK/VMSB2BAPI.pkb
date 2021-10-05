create or replace PACKAGE BODY         VMSCMS.VMSB2BAPI
IS
   -- Private type declarations

   -- Private constant declarations

   -- Private variable declarations

   -- Function and procedure implementations
   
   
   
/************************************************************************************************************

    * Modified by      : UBAIDUR RAHMAN.H
    * Modified Date    : 02-April-2019
    * Modified For     : VMS-823
    * Reviewer         : Saravanankumar
    * Build Number     : VMSR14_B0002 
	
     * Modified By      : Ubaidur Rahman H
     * Modified Date    : 29-AUG-2019
     * Purpose          : VMS-1084 (Pan genaration process from sequential to shuffled - B2B & Retail)
     * Reviewer         : Saravanakumar A
     * Release Number   : VMSGPRHOSTR20_B1    
     
      * Modified By      : Ubaidur Rahman H
     * Modified Date    : 03-Oct-2019
     * Purpose          : VMS-1052 B2B Order processing validation Enhancement
     * Reviewer         : Saravanakumar A
     * Release Number   : VMSGPRHOSTR21_B2    
	 
     * Modified By      : Ubaidur Rahman H
     * Modified Date    : 30-OCT-2019
     * Purpose          : VMS-1248 (Improve Query performance for BOL SQL for card creation)
     * Reviewer         : Saravanakumar A 
     
     * Modified By      : Ubaidur Rahman H
     * Modified Date    : 14-NOV-2019
     * Purpose          : Fix for dead lock issue
     * Reviewer         : Saravanakumar A 
     * Build Number     : VMS_RSI0226 
*****************************************************************************************************************/


   PROCEDURE process_order_request (p_inst_code_in    IN     NUMBER,
                                    p_order_id_in     IN     VARCHAR2,
                                    p_partner_id_in   IN     VARCHAR2,
                                    p_user_code_in    IN     NUMBER,
                                    p_resp_msg_out       OUT VARCHAR2)
   AS
   
 
     
      l_const              NUMBER := 1;
      l_mbr_numb           VARCHAR2 (5) := '000';
      l_parent_id     vms_order_details.vod_parent_oid%TYPE;
      l_card_stat          vms_order_details.vod_order_default_card_status%TYPE;
      l_prod_code          cms_prod_cattype.cpc_prod_code%TYPE;
      l_card_type          cms_prod_cattype.cpc_card_type%TYPE;
      l_profile_code       cms_prod_cattype.cpc_profile_code%TYPE;
      l_prxy_length        cms_prod_cattype.cpc_proxy_length%TYPE;
      l_serl_flag          cms_prod_cattype.cpc_ccf_serial_flag%TYPE;
      l_progm_id           cms_prod_cattype.cpc_program_id%TYPE;
      l_prod_type          cms_bin_param.cbp_param_value%TYPE;
      l_expry_date         cms_appl_pan.cap_expry_date%TYPE;
      l_succ_count         NUMBER (5) := 0;
      l_proc_stat          VARCHAR2 (5) := 'P';
      l_pins               shuffle_array_typ;
      l_encr_key           cms_bin_param.cbp_param_value%TYPE;
      l_auth_id            transactionlog.auth_id%TYPE;
      l_rrn                transactionlog.rrn%TYPE;
      l_timestamp          TIMESTAMP;
      l_business_time      transactionlog.business_time%TYPE;
      l_delivery_channel   cms_transaction_mast.ctm_delivery_channel%TYPE;
      l_txn_code           cms_transaction_mast.ctm_tran_code%TYPE;
      l_tran_desc          cms_transaction_mast.ctm_tran_desc%TYPE;
      l_drcr_flag          cms_transaction_mast.ctm_credit_debit_flag%TYPE;
      l_hashkey_id         cms_transaction_log_dtl.ctd_hashkey_id%TYPE;
      l_narration          cms_statements_log.csl_trans_narrration%TYPE;
      l_channel_code       vms_order_details.vod_channel_id%TYPE;
      l_activation_code    vms_order_details.vod_activation_code%TYPE;
      v_resp_msg_out       VARCHAR2 (1000);
      l_display_name       cms_prod_cattype.cpc_startercard_dispname%TYPE;
      l_disp_name          cms_appl_pan.cap_disp_name%TYPE;
      excp_error           EXCEPTION;
      l_check_digit_req    cms_prod_cattype.CPC_CHECK_DIGIT_REQ%TYPE;
      l_programid_req      cms_prod_cattype.CPC_PROGRAMID_REQ%TYPE;
      l_encryption_flag    cms_prod_cattype.CPC_ENCRYPT_ENABLE%TYPE;
      l_product_funding    vms_order_lineitem.VOL_PRODUCT_FUNDING%TYPE;
      l_print_order        vms_order_details.vod_print_order%TYPE;
      l_count              pls_integer;
      l_accept_partial     vms_order_details.vod_accept_partial%TYPE;
      l_reject_flag         VARCHAR2(10) := 'N';
      CURSOR cur_cards (prodcode   IN VARCHAR2,
                        prodcatg   IN NUMBER,
                        quantity   IN NUMBER)
      IS
        SELECT cap_appl_code,
               cap_prod_code,
               cap_prod_catg,
               cap_card_type,
               cap_cust_catg,
               cap_pan_code,
               cap_cust_code,
               cap_acct_id,
               cap_acct_no,
               cap_bill_addr,
               cap_pan_code_encr,
               cap_mask_pan,
               cap_appl_bran
           FROM cms_appl_pan_inv
           WHERE cap_prod_code = prodcode
                 AND cap_card_type = prodcatg
                 AND cap_issue_stat = 'N'
                 AND cap_card_seq  IN
			  (SELECT cap_card_seq
			  FROM
			    (SELECT a.cap_card_seq
			    FROM cms_appl_pan_inv a
			    WHERE a.cap_prod_code= prodcode
			    AND a.cap_card_type  = prodcatg
			    AND a.cap_issue_stat ='N'
				AND ROWNUM <= quantity + 1000000 /*Performance Issue Fix - Dead lock issue */
			    ORDER BY dbms_random.value
			    )
			  WHERE ROWNUM <= quantity
			  ) FOR UPDATE;
	---Modified for VMS-1084 (Pan genaration process from sequential to shuffled - B2B & Retail)		  

      TYPE t_cards IS TABLE OF cur_cards%ROWTYPE;

      cards                t_cards;

      PROCEDURE lp_update_orderstat (p_orderid_in     IN     VARCHAR2,
                                     p_partnerid_in   IN     VARCHAR2,
                                     p_status_in      IN     VARCHAR2,
                                     p_errmsg_out     IN OUT VARCHAR2)
      AS
      BEGIN
         BEGIN
            UPDATE vms_order_details
               SET vod_order_status =
                      DECODE (p_status_in,
                              'P', 'Processing',
                              'R', 'Rejected',
                              'C', 'Completed',
                              'Y', 'Processed'),
                   vod_parent_oid = l_parent_id,
                   vod_error_msg = p_errmsg_out
             WHERE vod_order_id = p_orderid_in
                   AND vod_partner_id = p_partnerid_in;
         EXCEPTION
            WHEN OTHERS
            THEN
               p_errmsg_out :=
                  'Error while selecting Order dtls:'
                  || SUBSTR (SQLERRM, 1, 200);
               ROLLBACK;
               RETURN;
         END;

         IF p_status_in = 'P'
         THEN
            BEGIN
               UPDATE vms_order_lineitem
                  SET vol_order_status = 'Processing',
                           vol_parent_oid = l_parent_id
                WHERE     vol_order_id = p_orderid_in
                      AND vol_partner_id = p_partnerid_in
                      AND vol_order_status = 'Received';
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error while selecting Order dtls:'
                     || SUBSTR (SQLERRM, 1, 200);
                  ROLLBACK;
                  RETURN;
            END;
         END IF;

         --p_errmsg_out := 'OK';
         COMMIT;
      END lp_update_orderstat;

      PROCEDURE lp_get_proxy (p_programid_in                 VARCHAR2,
                              p_proxylen_in                  VARCHAR2,
                              p_check_digit_request_in       VARCHAR2,
                              p_programid_req_in             VARCHAR2,
                              p_proxy_out                OUT VARCHAR2,
                              p_errmsg_out               OUT VARCHAR2)
      AS
         l_seq_no   cms_program_id_cnt.cpi_sequence_no%TYPE;
         l_row_id   ROWID;
         PRAGMA AUTONOMOUS_TRANSACTION;
      BEGIN
         p_errmsg_out := 'OK';

         IF  p_programid_req_in = 'Y'
         THEN
            BEGIN
               SELECT cpi_sequence_no
                 INTO l_seq_no
                 FROM cms_program_id_cnt
                WHERE cpi_program_id = p_programid_in
               FOR UPDATE;
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error while selecting cms_program_id_cnt:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RETURN;
            END;

            BEGIN
               p_proxy_out :=
                  fn_proxy_no (
                     NULL,
                     NULL,
                     p_programid_in,
                     l_seq_no,
                     p_inst_code_in,
                     p_user_code_in,
                     p_check_digit_request_in,
                     p_proxylen_in);


               IF p_proxy_out = '0'
               THEN
                  p_errmsg_out := 'proxy number should not be zero';
                  RETURN;
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error while generating Proxy number:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RETURN;
            END;
         ELSIF  p_programid_req_in = 'N'
         THEN
            BEGIN

             SELECT ROWID,LPAD (cpc_prxy_cntrlno, p_proxylen_in, 0)
                 INTO l_row_id,p_proxy_out
                 FROM cms_prxy_cntrl
                WHERE  cpc_inst_code = p_inst_code_in
                      AND cpc_prxy_key = DECODE(p_proxylen_in,7,'PRXYCTRL7',
                                                              8,'PRXYCTRL8',
                                                              9,'PRXYCTRL',
                                                              10,'PRXYCTRL10',
                                                              11,'PRXYCTRL11',
                                                              12,'PRXYCTRL12')
             FOR UPDATE;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  p_errmsg_out :=
                     'Proxy number not defined for institution: '
                     || p_inst_code_in;
                  RETURN;
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error while selecting cms_prxy_cntrl:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RETURN;
            END;

            BEGIN
               UPDATE cms_prxy_cntrl
                  SET cpc_prxy_cntrlno = cpc_prxy_cntrlno + 1,
                      cpc_lupd_user = p_user_code_in,
                      cpc_lupd_date = SYSDATE
                WHERE ROWID =  l_row_id;


               IF SQL%ROWCOUNT = 0
               THEN
                  p_errmsg_out := 'Proxy number is not updated successfully';
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error while updating cms_prxy_cntrl:'
                     || SUBSTR (SQLERRM, 1, 200);
            END;
         ELSE
            p_errmsg_out := 'Invalid length for proxy number generation';
         END IF;

         IF p_errmsg_out = 'OK'
         THEN
            COMMIT;
         ELSE
            ROLLBACK;
         END IF;
      END lp_get_proxy;

      PROCEDURE lp_virtual_process (
         p_lineitem_in    IN     VARCHAR2,
         p_productid_in   IN     VARCHAR2,
         l_encr_key_in    IN     VARCHAR2,
         p_cards_in       IN     t_cards,
         p_pins_in        IN     shuffle_array_typ,
         p_errmsg_out        OUT VARCHAR2)
      AS
         l_proxy_no         cms_appl_pan.cap_proxy_number%TYPE;
         --l_ctrl_num         vms_product_serial_cntrl.vps_serl_numb%TYPE;
         --l_end_serl         vms_product_serial_cntrl.vps_end_serl%TYPE;
         l_respcode         VARCHAR2 (10);
         l_serials          shuffle_array_typ;
         l_proxy_pin_encr   vms_line_item_dtl.vli_proxy_pin_encr%TYPE;
      BEGIN
         p_errmsg_out := 'OK';

         IF l_serl_flag = 'Y'
         THEN
            get_serials (p_productid_in,
                         p_cards_in.COUNT,
                         l_serials,
                         p_errmsg_out);

            IF p_errmsg_out <> 'OK'
            THEN
               p_errmsg_out := 'Error from get_serials:' || p_errmsg_out;
               RETURN;
            END IF;
         END IF;

         FOR i IN 1 .. p_cards_in.COUNT
         LOOP
            lp_get_proxy (l_progm_id,
                          l_prxy_length,
                          l_check_digit_req,
                          l_programid_req,
                          l_proxy_no,
                          p_errmsg_out);

            IF p_errmsg_out <> 'OK'
            THEN
               p_errmsg_out := 'Error from lp_get_proxy-' || p_errmsg_out;
               EXIT;
            END IF;

            --            IF l_serl_flag = 'Y'
            --            THEN
            --               BEGIN
            --                  SELECT vps_serl_numb, vps_end_serl
            --                    INTO l_ctrl_num, l_end_serl
            --                    FROM vms_product_serial_cntrl
            --                   WHERE vps_product_id = p_productid_in
            --                  FOR UPDATE;
            --               EXCEPTION
            --                  WHEN OTHERS
            --                  THEN
            --                     p_errmsg_out :=
            --                        'Error While fetching product_serial_cntrl :'
            --                        || SUBSTR (SQLERRM, 1, 200);
            --                     EXIT;
            --               END;
            --
            --               BEGIN
            --                  UPDATE vms_product_serial_cntrl
            --                     SET vps_serl_numb = vps_serl_numb + 1
            --                   WHERE vps_product_id = p_productid_in;
            --               EXCEPTION
            --                  WHEN OTHERS
            --                  THEN
            --                     p_errmsg_out :=
            --                        'Error While fetching product_serial_cntrl :'
            --                        || SUBSTR (SQLERRM, 1, 200);
            --                     EXIT;
            --               END;
            --            END IF;

            BEGIN
             IF l_serl_flag = 'Y' THEN
               UPDATE cms_appl_pan
                  SET cap_proxy_number = l_proxy_no,
                      cap_serial_number = l_serials (i)           --l_ctrl_num
                WHERE     cap_pan_code = p_cards_in (i).cap_pan_code
                      AND cap_inst_code = p_inst_code_in
                      AND cap_mbr_numb = l_mbr_numb;

                ELSE
                  UPDATE cms_appl_pan
                  SET cap_proxy_number = l_proxy_no
                WHERE     cap_pan_code = p_cards_in (i).cap_pan_code
                      AND cap_inst_code = p_inst_code_in
                      AND cap_mbr_numb = l_mbr_numb;
             END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error While updating proxy dtls :'
                     || SUBSTR (SQLERRM, 1, 200);
                  EXIT;
            END;

            BEGIN
               UPDATE cms_cust_mast
                  SET ccm_kyc_flag = 'A'
                WHERE ccm_cust_code = p_cards_in (i).cap_cust_code
                      AND ccm_inst_code = p_inst_code_in;
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error While updating kyc flag :'
                     || SUBSTR (SQLERRM, 1, 200);
                  EXIT;
            END;

            BEGIN
               INSERT INTO cms_smsandemail_alert (csa_inst_code,
                                                  csa_pan_code,
                                                  csa_pan_code_encr,
                                                  csa_loadorcredit_flag,
                                                  csa_lowbal_flag,
                                                  csa_negbal_flag,
                                                  csa_highauthamt_flag,
                                                  csa_dailybal_flag,
                                                  csa_insuff_flag,
                                                  csa_incorrpin_flag,
                                                  csa_fast50_flag,
                                                  csa_fedtax_refund_flag,
                                                  csa_deppending_flag,
                                                  csa_depaccepted_flag,
                                                  csa_deprejected_flag,
                                                  csa_ins_user,
                                                  csa_ins_date)
                    VALUES (p_inst_code_in,
                            p_cards_in (i).cap_pan_code,
                            p_cards_in (i).cap_pan_code_encr,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            0,
                            p_user_code_in,
                            SYSDATE);
            EXCEPTION
			WHEN DUP_VAL_ON_INDEX THEN NULL;
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error While Inserting smsandemail_alert :'
                     || SUBSTR (SQLERRM, 1, 200);
                  EXIT;
            END;

            BEGIN
               INSERT INTO cms_pan_acct (cpa_inst_code,
                                         cpa_cust_code,
                                         cpa_acct_id,
                                         cpa_acct_posn,
                                         cpa_pan_code,
                                         cpa_mbr_numb,
                                         cpa_ins_user,
                                         cpa_lupd_user,
                                         cpa_pan_code_encr)
                    VALUES (p_inst_code_in,
                            p_cards_in (i).cap_cust_code,
                            p_cards_in (i).cap_acct_id,
                            l_const,
                            p_cards_in (i).cap_pan_code,
                            l_mbr_numb,
                            p_user_code_in,
                            p_user_code_in,
                            p_cards_in (i).cap_pan_code_encr);
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error While Inserting pan_acct :'
                     || SUBSTR (SQLERRM, 1, 200);
                  EXIT;
            END;

            BEGIN
               sp_log_cardstat_chnge (p_inst_code_in,
                                      p_cards_in (i).cap_pan_code,
                                      p_cards_in (i).cap_pan_code_encr,
                                      LPAD (seq_auth_id.NEXTVAL, 6, '0'),
                                      '06',
                                      NULL,
                                      NULL,
                                      NULL,
                                      l_respcode,
                                      p_errmsg_out);

               IF p_errmsg_out <> 'OK'
               THEN
                  p_errmsg_out :=
                     'Error while logging appl shipped txn:' || p_errmsg_out;
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error While login shipped txn :'
                     || SUBSTR (SQLERRM, 1, 200);
                  EXIT;
            END;

            BEGIN
               l_proxy_pin_encr :=
                  fn_emaps_main_b2b (l_proxy_no || '|' || p_pins_in (i),
                                     l_encr_key_in);

               INSERT INTO vms_line_item_dtl (vli_pan_code,
                                              vli_order_id,
                                              vli_partner_id,
                                              vli_lineitem_id,
                                              vli_pin,
                                              vli_proxy_pin_encr,
                                              vli_proxy_pin_hash,
                                              vli_parent_oid)
                    VALUES (p_cards_in (i).cap_pan_code,
                            p_order_id_in,
                            p_partner_id_in,
                            p_lineitem_in,
                            p_pins_in (i),
                            l_proxy_pin_encr,
                            gethash (l_proxy_pin_encr),
                            l_parent_id);
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_errmsg_out :=
                     'Error While line item dtls :'
                     || SUBSTR (SQLERRM, 1, 200);
                  EXIT;
            END;
         END LOOP;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_errmsg_out := 'Main Excp :' || SUBSTR (SQLERRM, 1, 200);
      END LP_VIRTUAL_PROCESS;
   BEGIN
      p_resp_msg_out := 'OK';
      l_parent_id:=seq_parent_id.nextval;

      BEGIN
         BEGIN
            SELECT vod_order_default_card_status,
                   vod_channel_id,
                   vod_activation_code,DECODE(UPPER(VOD_PRINT_ORDER),'TRUE','P','F'),DECODE(UPPER(vod_accept_partial),'TRUE','Y','N')
              INTO l_card_stat, l_channel_code,l_activation_code, l_print_order,l_accept_partial
              FROM vms_order_details
             WHERE     vod_order_id = p_order_id_in
                   AND vod_partner_id = p_partner_id_in
                   AND vod_order_status = 'Received';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p_resp_msg_out := 'Invalid Order';
               RETURN;
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                  'Error While selecting order details:'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_error;
         END;

         lp_update_orderstat (p_order_id_in,
                              p_partner_id_in,
                              l_proc_stat,
                              p_resp_msg_out);

         IF p_resp_msg_out <> 'OK'
         THEN
            RAISE excp_error;
         END IF;

         BEGIN
            SELECT ccs_stat_code
              INTO l_card_stat
              FROM cms_card_stat
             WHERE ccs_stat_desc = UPPER (l_card_stat);
         EXCEPTION
            WHEN OTHERS
            THEN
               l_card_stat := NULL;
         END;

         BEGIN
            SELECT ctm_delivery_channel,
                   ctm_tran_code,
                   ctm_tran_desc,
                   ctm_credit_debit_flag
              INTO l_delivery_channel,
                   l_txn_code,
                   l_tran_desc,
                   l_drcr_flag
              FROM cms_transaction_mast
             WHERE ctm_inst_code = p_inst_code_in
                   AND (ctm_delivery_channel, ctm_tran_code) IN
                          (SELECT vft_channel_code, vft_tran_code
                             FROM vms_fsapi_trans_mast
                            WHERE vft_channel_desc = l_channel_code
                                  AND vft_request_type = 'INITIAL LOAD');
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                  'Error While selecting channel code:'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_error;
         END;

         FOR l_idx
            IN (SELECT vol_product_id,vol_embossedline,vol_package_id,
						vol_quantity,vol_product_funding,vol_line_item_id,
						vol_denomination,vol_order_id,vol_partner_id
                  FROM vms_order_lineitem
                 WHERE     vol_order_id = p_order_id_in
                       AND vol_partner_id = p_partner_id_in
                       AND vol_order_status = 'Processing')
         LOOP
            BEGIN
               v_resp_msg_out := 'OK';
               l_count := 0;

               BEGIN
                  SELECT cattype.cpc_prod_code,
                         cattype.cpc_card_type,
                         cattype.cpc_profile_code,
                         cattype.cpc_proxy_length,
                         cattype.cpc_program_id,
                         cattype.cpc_check_digit_req,
                         cattype.cpc_programid_req,
                         NVL(cattype.cpc_ccf_serial_flag, 'N'),
                         NVL(cattype.cpc_startercard_dispname, 'INSTANT CARD'),
                         NVL(cattype.CPC_ENCRYPT_ENABLE,'N')
                    INTO l_prod_code,
                         l_card_type,
                         l_profile_code,
                         l_prxy_length,
                         l_progm_id,
                         l_check_digit_req,
                         l_programid_req,
                         l_serl_flag,
                         l_display_name,
                         l_encryption_flag
                    FROM cms_prod_cattype cattype , cms_prod_mast prod
                   WHERE     cattype.cpc_product_id = l_idx.vol_product_id
                         AND prod.cpm_inst_code = cattype.cpc_inst_code
                         AND prod.cpm_prod_code = cattype.cpc_prod_code;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_resp_msg_out :=
                        'Error while selecting product dtls:'
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_error;
               END;

               BEGIN
                  SELECT cbp_param_value
                    INTO l_prod_type
                    FROM cms_bin_param
                   WHERE cbp_profile_code = l_profile_code
                         AND cbp_param_name = 'Card Type';
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     v_resp_msg_out :=
                        'Error while selecting product type:'
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_error;
               END;

               IF l_prod_type = 'V'
               THEN
                  BEGIN
                     SELECT cbp_param_value
                       INTO l_encr_key
                       FROM cms_bin_param
                      WHERE cbp_profile_code = l_profile_code
                            AND cbp_param_name = 'Virtual Card EncrKey';
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        v_resp_msg_out :=
                           'Error while selecting Virtual Card EncrKey:'
                           || SUBSTR (SQLERRM, 1, 200);
                        RAISE excp_error;
                  END;
               END IF;

               IF l_idx.vol_embossedline IS NULL
               THEN
                  BEGIN
                     SELECT DECODE(l_encryption_flag,'N',NVL (vpd_field_value, l_display_name),FN_EMAPS_MAIN(NVL (vpd_field_value, l_display_name)))
                       INTO l_disp_name
                       FROM vms_packageid_detl
                      WHERE vpd_package_id = l_idx.vol_package_id
                            AND vpd_field_key = 'embossLine3';
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        l_disp_name := l_display_name;
                  END;
               ELSE
                  l_disp_name := l_idx.vol_embossedline;
               END IF;

               BEGIN
                  vmsfunutilities.get_expiry_date (p_inst_code_in,
                                                   l_prod_code,
                                                   l_card_type,
                                                   l_profile_code,
                                                   l_expry_date,
                                                   v_resp_msg_out);

                  IF v_resp_msg_out <> 'OK'
                  THEN
                     RAISE excp_error;
                  END IF;
               EXCEPTION
                  WHEN excp_error
                  THEN
                     RAISE;
                  WHEN OTHERS
                  THEN
                     v_resp_msg_out :=
                        'Error while calling vmsfunutilities.get_expiry_date'
                        || SUBSTR (SQLERRM, 1, 200);
                     RAISE excp_error;
               END;

                   SELECT TRUNC (DBMS_RANDOM.VALUE (1000000000, 9999999999)) num
                     BULK COLLECT INTO l_pins
                     FROM DUAL
               CONNECT BY LEVEL <= l_idx.vol_quantity;

               OPEN cur_cards (l_prod_code, l_card_type, l_idx.vol_quantity);

               LOOP
                  FETCH cur_cards
                  BULK COLLECT INTO cards
                  LIMIT 1000;

                  EXIT WHEN cards.COUNT = 0;
                  
                  l_count := l_count + cards.count;

                  BEGIN
                     FORALL i IN 1 .. cards.COUNT
                        INSERT ALL
                          INTO cms_appl_pan (cap_appl_code,
                                             cap_prod_code,
                                             cap_prod_catg,
                                             cap_card_type,
                                             cap_cust_catg,
                                             cap_pan_code,
                                             cap_cust_code,
                                             cap_expry_date,
                                             cap_acct_id,
                                             cap_acct_no,
                                             cap_bill_addr,
                                             cap_pan_code_encr,
                                             cap_mask_pan,
                                             cap_appl_bran,
                                             cap_inst_code,
                                             cap_asso_code,
                                             cap_inst_type,
                                             cap_mbr_numb,
                                             cap_disp_name,
                                             cap_addon_stat,
                                             cap_addon_link,
                                             cap_mbr_link,
                                             cap_tot_acct,
                                             cap_pangen_date,
                                             cap_pangen_user,
                                             cap_ins_user,
                                             cap_lupd_user,
                                             cap_issue_flag,
                                             cap_card_stat,
                                             cap_active_date,
                                             cap_startercard_flag,
                                             cap_activation_code,
                                             CAP_FIRSTTIME_TOPUP,
                                             CAP_ORDER_TYPE)
                        VALUES (cards (i).cap_appl_code,
                                cards (i).cap_prod_code,
                                cards (i).cap_prod_catg,
                                cards (i).cap_card_type,
                                cards (i).cap_cust_catg,
                                cards (i).cap_pan_code,
                                cards (i).cap_cust_code,
                                l_expry_date,
                                cards (i).cap_acct_id,
                                cards (i).cap_acct_no,
                                cards (i).cap_bill_addr,
                                cards (i).cap_pan_code_encr,
                                cards (i).cap_mask_pan,
                                cards (i).cap_appl_bran,
                                p_inst_code_in,
                                l_const,
                                l_const,
                                l_mbr_numb,
                                l_disp_name,
                                'P',
                                cards (i).cap_pan_code,
                                l_mbr_numb,
                                l_const,
                                SYSDATE,
                                p_user_code_in,
                                p_user_code_in,
                                p_user_code_in,
                                'Y',
                                l_card_stat,
                                DECODE (l_card_stat, '1', SYSDATE),
                                'Y',
                                l_activation_code,
                                decode(l_idx.VOL_PRODUCT_FUNDING,'1','Y','N'),
                                l_print_order)
                          INTO cms_cardissuance_status (ccs_inst_code,
                                                        ccs_pan_code,
                                                        ccs_card_status,
                                                        ccs_ins_user,
                                                        ccs_lupd_user,
                                                        ccs_pan_code_encr,
                                                        ccs_lupd_date,
                                                        ccs_appl_code)
                        VALUES (p_inst_code_in,
                                cards (i).cap_pan_code,
                                DECODE (l_prod_type, 'V', '15', '2'),
                                p_user_code_in,
                                p_user_code_in,
                                cards (i).cap_pan_code_encr,
                                SYSDATE,
                                cards (i).cap_appl_code)
                           SELECT * FROM DUAL;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        v_resp_msg_out :=
                           'Error While Inserting Cards :'
                           || SUBSTR (SQLERRM, 1, 200);
                        EXIT;
                  END;

                  BEGIN
                     FORALL i IN 1 .. cards.COUNT
                        UPDATE cms_appl_mast
                           SET cam_appl_stat = 'O',
                               cam_lupd_user = p_user_code_in,
                               cam_process_msg = 'SUCCESSFUL'
                         WHERE cam_inst_code = p_inst_code_in
                               AND cam_appl_code = cards (i).cap_appl_code;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        v_resp_msg_out :=
                           'Error While Updating Appl Stat:'
                           || SUBSTR (SQLERRM, 1, 200);
                        EXIT;
                  END;

                  BEGIN
                     FORALL i IN 1 .. cards.COUNT
                        UPDATE cms_appl_pan_inv
                           SET cap_issue_stat = 'I'
                         WHERE cap_pan_code = cards (i).cap_pan_code;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        v_resp_msg_out :=
                           'Error While Updating Cards Issue Stat:'
                           || SUBSTR (SQLERRM, 1, 200);
                        EXIT;
                  END;

                  IF l_prod_type = 'V'
                  THEN
                     lp_virtual_process (l_idx.vol_line_item_id,
                                         l_idx.vol_product_id,
                                         l_encr_key,
                                         cards,
                                         l_pins,
                                         v_resp_msg_out);

                     IF v_resp_msg_out <> 'OK'
                     THEN
                        v_resp_msg_out :=
                           'Error from lp_virtual_process: '
                           || v_resp_msg_out;
                        EXIT;
                     END IF;
                  ELSE
                     BEGIN
                        FORALL i IN 1 .. cards.COUNT
                           INSERT INTO vms_line_item_dtl (vli_pan_code,
                                                          vli_order_id,
                                                          vli_partner_id,
                                                          vli_lineitem_id,
                                                          vli_pin,
                                                          vli_proxy_pin_encr,
                                                          vli_parent_oid)
                                VALUES (cards (i).cap_pan_code,
                                        p_order_id_in,
                                        p_partner_id_in,
                                        l_idx.vol_line_item_id,
                                        NULL,--l_pins (i),
                                        NULL,
                                        l_parent_id);
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           v_resp_msg_out :=
                              'Error While line item dtls :'
                              || SUBSTR (SQLERRM, 1, 200);
                           EXIT;
                     END;
                  END IF;                    

                 IF l_idx.VOL_PRODUCT_FUNDING ='1' 
                 THEN
                 
                  BEGIN
                     FORALL i IN 1 .. cards.COUNT
                        UPDATE cms_acct_mast
                           SET cam_acct_bal = l_idx.vol_denomination,
                               cam_ledger_bal = l_idx.vol_denomination,
			                          CAM_INITIALLOAD_AMT = l_idx.vol_denomination,
                                cam_first_load_date = sysdate
                         WHERE cam_inst_code = p_inst_code_in
                               AND cam_acct_no = cards (i).cap_acct_no;
                  EXCEPTION
                     WHEN OTHERS
                     THEN
                        v_resp_msg_out :=
                           'Error While updating acct mast:'
                           || SUBSTR (SQLERRM, 1, 200);
                        EXIT;
                  END;

                  FOR i IN 1 .. cards.COUNT
                  LOOP
                     BEGIN
                        l_auth_id := LPAD (seq_auth_id.NEXTVAL, 6, '0');
                        l_rrn :=
                           TO_CHAR (SYSTIMESTAMP, 'yymmddHH24MISS')
                           || seq_passivestatupd_rrn.NEXTVAL;
                        l_business_time := TO_CHAR (SYSDATE, 'hh24miss');
                        l_timestamp := SYSTIMESTAMP;
                        l_hashkey_id :=
                           gethash (
                                 l_delivery_channel
                              || l_txn_code
                              || fn_dmaps_main (cards (i).cap_pan_code_encr)
                              || l_rrn
                              || TO_CHAR (l_timestamp, 'YYYYMMDDHH24MISSFF5'));
                        l_narration :=
                              l_tran_desc
                           || '/'
                           || TO_CHAR (SYSDATE, 'yyyymmdd')
                           || '/'
                           || l_auth_id;

                        INSERT INTO cms_statements_log (csl_pan_no,
                                                        csl_opening_bal,
                                                        csl_trans_amount,
                                                        csl_trans_type,
                                                        csl_trans_date,
                                                        csl_closing_balance,
                                                        csl_trans_narrration,
                                                        csl_pan_no_encr,
                                                        csl_rrn,
                                                        csl_auth_id,
                                                        csl_business_date,
                                                        csl_business_time,
                                                        txn_fee_flag,
                                                        csl_delivery_channel,
                                                        csl_inst_code,
                                                        csl_txn_code,
                                                        csl_ins_date,
                                                        csl_ins_user,
                                                        csl_acct_no,
                                                        csl_panno_last4digit,
                                                        csl_time_stamp,
                                                        csl_prod_code,
                                                        csl_card_type)
                             VALUES (
                                       cards (i).cap_pan_code,
                                       0,
                                       l_idx.vol_denomination,
                                       l_drcr_flag,
                                       SYSDATE,
                                       l_idx.vol_denomination,
                                       l_narration,
                                       cards (i).cap_pan_code_encr,
                                       l_rrn,
                                       l_auth_id,
                                       TO_CHAR (SYSDATE, 'yyyymmdd'),
                                       l_business_time,
                                       'N',
                                       l_delivery_channel,
                                       p_inst_code_in,
                                       l_txn_code,
                                       SYSDATE,
                                       1,
                                       cards (i).cap_acct_no,
                                       SUBSTR (
                                          fn_dmaps_main (
                                             cards (i).cap_pan_code_encr),
                                          -4),
                                       l_timestamp,
                                       cards (i).cap_prod_code,
                                       cards (i).cap_card_type);

                        INSERT INTO transactionlog (msgtype,
                                                    rrn,
                                                    delivery_channel,
                                                    date_time,
                                                    txn_code,
                                                    txn_type,
                                                    txn_mode,
                                                    txn_status,
                                                    response_code,
                                                    business_date,
                                                    business_time,
                                                    customer_card_no,
                                                    total_amount,
                                                    productid,
                                                    categoryid,
                                                    auth_id,
                                                    trans_desc,
                                                    amount,
                                                    instcode,
                                                    tranfee_amt,
                                                    cr_dr_flag,
                                                    customer_card_no_encr,
                                                    reversal_code,
                                                    customer_acct_no,
                                                    acct_balance,
                                                    ledger_balance,
                                                    response_id,
                                                    add_ins_date,
                                                    add_ins_user,
                                                    cardstatus,
                                                    error_msg,
                                                    time_stamp)
                             VALUES ('0200',
                                     l_rrn,
                                     l_delivery_channel,
                                     SYSDATE,
                                     l_txn_code,
                                     1,
                                     '0',
                                     'C',
                                     '00',
                                     TO_CHAR (SYSDATE, 'yyyymmdd'),
                                     l_business_time,
                                     cards (i).cap_pan_code,
                                     l_idx.vol_denomination,
                                     cards (i).cap_prod_code,
                                     cards (i).cap_card_type,
                                     l_auth_id,
                                     l_tran_desc,
                                     l_idx.vol_denomination,
                                     p_inst_code_in,
                                     '0.00',
                                     l_drcr_flag,
                                     cards (i).cap_pan_code_encr,
                                     0,
                                     cards (i).cap_acct_no,
                                     l_idx.vol_denomination,
                                     l_idx.vol_denomination,
                                     1,
                                     SYSDATE,
                                     1,
                                     l_card_stat,
                                     'OK',
                                     l_timestamp);

                        INSERT
                          INTO cms_transaction_log_dtl (
                                  ctd_delivery_channel,
                                  ctd_txn_code,
                                  ctd_txn_type,
                                  ctd_txn_mode,
                                  ctd_business_date,
                                  ctd_business_time,
                                  ctd_customer_card_no,
                                  ctd_txn_amount,
                                  ctd_actual_amount,
                                  ctd_bill_amount,
                                  ctd_process_flag,
                                  ctd_process_msg,
                                  ctd_rrn,
                                  ctd_customer_card_no_encr,
                                  ctd_msg_type,
                                  ctd_cust_acct_number,
                                  ctd_inst_code,
                                  ctd_hashkey_id)
                        VALUES (l_delivery_channel,
                                l_txn_code,
                                1,
                                '0',
                                TO_CHAR (SYSDATE, 'yyyymmdd'),
                                l_business_time,
                                cards (i).cap_pan_code,
                                l_idx.vol_denomination,
                                l_idx.vol_denomination,
                                l_idx.vol_denomination,
                                'Y',
                                'Successful',
                                l_rrn,
                                cards (i).cap_pan_code_encr,
                                '0200',
                                cards (i).cap_acct_no,
                                p_inst_code_in,
                                l_hashkey_id);
                     EXCEPTION
                        WHEN OTHERS
                        THEN
                           v_resp_msg_out :=
                              'Error While logging initial_load txn :'
                              || SUBSTR (SQLERRM, 1, 200);
                           EXIT;
                     END;
                  END LOOP;
                                
                  END IF;  

                  IF v_resp_msg_out <> 'OK'
                  THEN
                     EXIT;
                  END IF;

                  IF l_card_stat = 1
                  THEN
                     FOR i IN 1 .. cards.COUNT
                     LOOP
                        l_auth_id := LPAD (seq_auth_id.NEXTVAL, 6, '0');
                        l_rrn :=
                           TO_CHAR (SYSTIMESTAMP, 'yymmddHH24MISS')
                           || seq_passivestatupd_rrn.NEXTVAL;
                        l_business_time := TO_CHAR (SYSDATE, 'hh24miss');

                        BEGIN
                           INSERT INTO transactionlog (msgtype,
                                                       rrn,
                                                       delivery_channel,
                                                       txn_code,
                                                       trans_desc,
                                                       customer_card_no,
                                                       customer_card_no_encr,
                                                       business_date,
                                                       business_time,
                                                       txn_status,
                                                       response_code,
                                                       auth_id,
                                                       instcode,
                                                       add_ins_date,
                                                       response_id,
                                                       date_time,
                                                       customer_acct_no,
                                                       acct_balance,
                                                       ledger_balance,
                                                       cardstatus)
                                VALUES ('0200',
                                        l_rrn,
                                        '05',
                                        '01',
                                        'Card Status update to Active',
                                        cards (i).cap_pan_code,
                                        cards (i).cap_pan_code_encr,
                                        TO_CHAR (SYSDATE, 'yyyymmdd'),
                                        l_business_time,
                                        'C',
                                        '00',
                                        l_auth_id,
                                        p_inst_code_in,
                                        SYSDATE,
                                        '1',
                                        SYSDATE,
                                        cards (i).cap_acct_no,
                                        l_idx.vol_denomination,
                                        l_idx.vol_denomination,
                                        l_card_stat);
                        EXCEPTION
                           WHEN OTHERS
                           THEN
                              v_resp_msg_out :=
                                 'Error While inserting into transactionlog :'
                                 || SUBSTR (SQLERRM, 1, 200);
                              EXIT;
                        END;

                        BEGIN
                           INSERT
                             INTO cms_transaction_log_dtl (
                                     ctd_delivery_channel,
                                     ctd_txn_code,
                                     ctd_txn_type,
                                     ctd_msg_type,
                                     ctd_txn_mode,
                                     ctd_business_date,
                                     ctd_business_time,
                                     ctd_customer_card_no,
                                     ctd_process_flag,
                                     ctd_process_msg,
                                     ctd_rrn,
                                     ctd_inst_code,
                                     ctd_customer_card_no_encr,
                                     ctd_cust_acct_number)
                           VALUES ('05',
                                   '01',
                                   '0',
                                   '0200',
                                   0,
                                   TO_CHAR (SYSDATE, 'YYYYMMDD'),
                                   l_business_time,
                                   cards (i).cap_pan_code,
                                   'Y',
                                   'Successful',
                                   l_rrn,
                                   p_inst_code_in,
                                   cards (i).cap_pan_code_encr,
                                   cards (i).cap_acct_no);
                        EXCEPTION
                           WHEN OTHERS
                           THEN
                              v_resp_msg_out :=
                                 'Error While inserting into cms_transaction_log_dtl :'
                                 || SUBSTR (SQLERRM, 1, 200);
                              EXIT;
                        END;
                     END LOOP;
                  END IF;

                  IF v_resp_msg_out <> 'OK'
                  THEN
                     EXIT;                    
                  END IF;
               END LOOP;

               CLOSE cur_cards;

               IF v_resp_msg_out <> 'OK'
               THEN
                  RAISE excp_error;
               ELSIF l_count = l_idx.vol_quantity THEN
                  l_succ_count := l_succ_count + 1;
               ELSIF l_count <> l_idx.vol_quantity THEN
                  v_resp_msg_out := 'Required card numbers not available';
                  l_reject_flag := 'Y';
               END IF;
            EXCEPTION
               WHEN excp_error
               THEN
                  ROLLBACK;
               WHEN OTHERS
               THEN
                  ROLLBACK;
                  v_resp_msg_out :=
                     'Error while processing lineitem:'
                     || SUBSTR (SQLERRM, 1, 200);
            END;
            
            UPDATE vms_order_lineitem
               SET vol_order_status =
                      DECODE (
                         v_resp_msg_out,
                         'OK', DECODE (l_prod_type,
                                       'V', 'Completed',
                                       'Processed'),
                         'Rejected'),
                   vol_ccf_flag =
                      DECODE (v_resp_msg_out, 'OK', DECODE (l_prod_type, 'V',2,1), vol_ccf_flag),
                   vol_error_msg = v_resp_msg_out
             WHERE     vol_line_item_id = l_idx.vol_line_item_id
                   AND vol_order_id = l_idx.vol_order_id
                   AND vol_partner_id = l_idx.vol_partner_id;

            IF v_resp_msg_out <> 'OK'
            THEN
               UPDATE vms_pangen_summary
                  SET vps_avail_cards = vps_avail_cards + nvl(l_idx.vol_quantity,0)
                WHERE vps_prod_code = l_prod_code
                      AND vps_card_type = l_card_type;
            END IF;

            COMMIT;
         END LOOP;

         IF l_succ_count = 0 OR (l_reject_flag = 'Y' and l_accept_partial = 'N')
         THEN
            IF l_reject_flag = 'Y' THEN
                v_resp_msg_out:= 'Required card numbers not available';
            
            BEGIN
                UPDATE  vms_order_lineitem
                SET
                        vol_order_status = 'Rejected',
                        vol_error_msg = v_resp_msg_out
                WHERE
                        vol_order_id = p_order_id_in
                AND     vol_partner_id = p_partner_id_in;

                COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
                ROLLBACK;
                v_resp_msg_out := 'Error while Updating lineitems:'
                          || substr(sqlerrm, 1, 200);
             END;
            
            END IF;
            p_resp_msg_out := v_resp_msg_out;
            l_proc_stat := 'R';
         ELSIF l_prod_type = 'V'
         THEN
            l_proc_stat := 'C';
         ELSE
            l_proc_stat := 'Y';
         END IF;
      EXCEPTION
         WHEN excp_error
         THEN
            NULL;
      END;

      lp_update_orderstat (p_order_id_in,
                           p_partner_id_in,
                           l_proc_stat,
                           p_resp_msg_out);
   END process_order_request;

   PROCEDURE get_serials (p_productid_in   IN     VARCHAR2,
                          p_quantity_in    IN     NUMBER,
                          p_serials_out       OUT shuffle_array_typ,
                          p_respmsg_out       OUT VARCHAR2)
   AS
      l_rowid        ROWID;
      l_cntrl_numb   vms_product_serial_cntrl.vps_serl_numb%TYPE;
   BEGIN
      p_respmsg_out := 'OK';

      BEGIN
         SELECT rd, serial
           INTO l_rowid, l_cntrl_numb
           FROM (  SELECT ROWID rd, vps_serl_numb serial
                     FROM vms_product_serial_cntrl
                    WHERE vps_product_id = p_productid_in
                          AND (vps_serl_numb-1) + p_quantity_in <= vps_end_serl
                 ORDER BY vps_end_serl - vps_serl_numb)
          WHERE ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            p_respmsg_out := 'Sufficient serials not available';
            RETURN;
         WHEN OTHERS
         THEN
            p_respmsg_out :=
               'Error While fetching product_serial_cntrl :'
               || SUBSTR (SQLERRM, 1, 200);
            RETURN;
      END;

      BEGIN
         UPDATE vms_product_serial_cntrl
            SET vps_serl_numb = vps_serl_numb + p_quantity_in
          WHERE ROWID = l_rowid;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_respmsg_out :=
               'Error While fetching product_serial_cntrl :'
               || SUBSTR (SQLERRM, 1, 200);
            RETURN;
      END;

          SELECT l_cntrl_numb + (LEVEL - 1)
            BULK COLLECT INTO p_serials_out
            FROM DUAL
      CONNECT BY LEVEL <= p_quantity_in;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_respmsg_out := 'Main Excp :' || SUBSTR (SQLERRM, 1, 200);
   END get_serials;

   PROCEDURE delete_cards (p_card_nos_in    IN     shuffle_array_typ,
                           p_resp_msg_out      OUT VARCHAR2)
   AS
      excp_reject_orderprocess   EXCEPTION;
      v_cap_pan_code_encr        cms_appl_pan.cap_pan_code_encr%TYPE;
      v_tran_date                VARCHAR2 (50);
      v_tran_time                VARCHAR2 (50);
      l_ccs_tran_code            cms_card_stat.ccs_tran_code%TYPE;
      l_auth_id                  transactionlog.auth_id%TYPE;
      l_err_msg                  transactionlog.error_msg%TYPE;
      l_resp_cde                 transactionlog.response_code%TYPE;
      v_hash_pan                 vms_line_item_dtl.vli_pan_code%TYPE;
      v_cap_acct_no              cms_appl_pan.cap_acct_no%TYPE;
      l_drcr_flag                cms_statements_log.csl_trans_type%TYPE
                                                                      := 'DR';
      l_cam_acct_bal             cms_acct_mast.cam_acct_bal%TYPE;
      l_cam_ledger_bal           cms_acct_mast.cam_ledger_bal%TYPE;
      l_cap_prod_code            cms_appl_pan.cap_prod_code%TYPE;
      l_cap_card_type            cms_appl_pan.cap_card_type%TYPE;
      v_card_stat                cms_appl_pan.cap_card_stat%TYPE;
      l_delivery_channel         transactionlog.delivery_channel%TYPE := '17';
      l_txn_code                 transactionlog.txn_code%TYPE         := '04';
      l_timestamp                transactionlog.time_stamp%TYPE;
      l_rrn                      transactionlog.rrn%TYPE;
      l_business_time            transactionlog.business_time%TYPE;
      l_hashkey_id               cms_transaction_log_dtl.ctd_hashkey_id%TYPE;
      l_narration                cms_statements_log.csl_trans_narrration%TYPE;
      l_tran_desc                cms_transaction_mast.ctm_tran_desc%TYPE := 'Initial Load';
   BEGIN
      p_resp_msg_out := 'OK';
      

      FOR i IN 1 .. p_card_nos_in.COUNT
      LOOP
      v_hash_pan:=p_card_nos_in (i);
        /* BEGIN
            DELETE FROM transactionlog
                  WHERE customer_card_no = p_card_nos_in (i);
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                  'Error While deleting  card txns:'
                  || SUBSTR (SQLERRM, 1, 200);
               EXIT;
         END;

         BEGIN
            DELETE FROM cms_transaction_log_dtl
                  WHERE ctd_customer_card_no = p_card_nos_in (i);
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                  'Error While deleting  card txns dtls:'
                  || SUBSTR (SQLERRM, 1, 200);
               EXIT;
         END;

         BEGIN
            DELETE FROM cms_statements_log
                  WHERE csl_pan_no = p_card_nos_in (i);
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                  'Error While deleting  card txns dtls:'
                  || SUBSTR (SQLERRM, 1, 200);
               EXIT;
         END;

         BEGIN
            DELETE FROM cms_cardissuance_status
                  WHERE ccs_pan_code = p_card_nos_in (i);
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                  'Error While deleting Cards Issuance:'
                  || SUBSTR (SQLERRM, 1, 200);
               EXIT;
         END;

         BEGIN
            DELETE FROM cms_appl_pan
                  WHERE     cap_inst_code = 1
                        AND cap_mbr_numb = '000'
                        AND cap_pan_code = p_card_nos_in (i);
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                  'Error While deleting Cards:' || SUBSTR (SQLERRM, 1, 200);
               EXIT;
         END;

         BEGIN
--            DELETE FROM vms_line_item_dtl
--                  WHERE vli_pan_code = p_card_nos_in (i);
              update vms_line_item_dtl
              set vli_pan_code=null,
                  VLI_PIN=null,
                  VLI_PROXY_PIN_ENCR=null,
                  VLI_PROXY_PIN_HASH=null,
                  VLI_SHIPPING_DATETIME=null,
                  VLI_STATUS=null,
                  VLI_TRACKING_NO=null
              where
                  vli_pan_code = p_card_nos_in (i);
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                  'Error While deleting line_item_dtl:'
                  || SUBSTR (SQLERRM, 1, 200);
               EXIT;
         END;

         BEGIN
            UPDATE cms_appl_pan_inv
               SET cap_issue_stat = 'N'
             WHERE cap_pan_code = p_card_nos_in (i);
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                  'Error While Updating Cards Issue Stat:'
                  || SUBSTR (SQLERRM, 1, 200);
               EXIT;
         END;*/
         
          BEGIN
             p_resp_msg_out := 'OK';
            IF v_hash_pan IS NOT NULL
            THEN
                        BEGIN
                           l_auth_id := LPAD (seq_auth_id.NEXTVAL, 6, '0');
                           l_rrn :=
                                 TO_CHAR (SYSTIMESTAMP, 'yymmddHH24MISS')
                              || seq_passivestatupd_rrn.NEXTVAL;
                           l_business_time := TO_CHAR (SYSDATE, 'hh24miss');
                           l_timestamp := SYSTIMESTAMP;

                           SELECT cap_pan_code_encr, cap_acct_no,cap_card_stat,
                                  cap_prod_code, cap_card_type
                             INTO v_cap_pan_code_encr, v_cap_acct_no,v_card_stat,
                                  l_cap_prod_code, l_cap_card_type
                             FROM cms_appl_pan
                            WHERE cap_pan_code = v_hash_pan
			    and cap_mbr_numb='000'
			    and cap_inst_code=1;

                           BEGIN
                              SELECT cam_acct_bal, cam_ledger_bal
                                INTO l_cam_acct_bal, l_cam_ledger_bal
                                FROM cms_acct_mast
                               WHERE cam_acct_no = v_cap_acct_no
			       and cam_inst_code=1;
                               
                               if l_cam_acct_bal > 0 Then 

                              UPDATE cms_acct_mast
                                 SET cam_acct_bal = 0,
                                     cam_ledger_bal = 0
                               WHERE cam_acct_no = v_cap_acct_no
			       and cam_inst_code=1;

                              IF SQL%ROWCOUNT = 1
                              THEN
                                 BEGIN
                                    l_hashkey_id :=
                                       gethash
                                          (   l_delivery_channel
                                           || l_txn_code
                                           || fn_dmaps_main
                                                          (v_cap_pan_code_encr)
                                           || l_rrn
                                           || TO_CHAR (l_timestamp,
                                                       'YYYYMMDDHH24MISSFF5'
                                                      )
                                          );
                                    l_narration :=
                                          l_tran_desc
                                       || '/'
                                       || TO_CHAR (SYSDATE, 'yyyymmdd')
                                       || '/'
                                       || l_auth_id;

                                    BEGIN
                                       INSERT INTO cms_statements_log
                                                   (csl_pan_no,
                                                    csl_opening_bal,
                                                    csl_trans_amount,
                                                    csl_trans_type,
                                                    csl_trans_date,
                                                    csl_closing_balance,
                                                    csl_trans_narrration,
                                                    csl_pan_no_encr,
                                                    csl_rrn, csl_auth_id,
                                                    csl_business_date,
                                                    csl_business_time,
                                                    txn_fee_flag,
                                                    csl_delivery_channel,
                                                    csl_inst_code,
                                                    csl_txn_code,
                                                    csl_ins_date,
                                                    csl_ins_user,
                                                    csl_acct_no,
                                                    csl_panno_last4digit,
                                                    csl_time_stamp,
                                                    csl_prod_code,
                                                    csl_card_type
                                                   )
                                            VALUES (v_hash_pan,
                                                    l_cam_acct_bal,
                                                    l_cam_acct_bal,
                                                    l_drcr_flag,
                                                    SYSDATE,
                                                    0,
                                                    l_narration,
                                                    v_cap_pan_code_encr,
                                                    l_rrn, l_auth_id,
                                                    TO_CHAR (SYSDATE,
                                                             'yyyymmdd'
                                                            ),
                                                    l_business_time,
                                                    'N',
                                                    l_delivery_channel,
                                                    '1',
                                                    l_txn_code,
                                                    SYSDATE,
                                                    1,
                                                    v_cap_acct_no,
                                                    SUBSTR
                                                       (fn_dmaps_main
                                                           (v_cap_pan_code_encr
                                                           ),
                                                        -4
                                                       ),
                                                    l_timestamp,
                                                    l_cap_prod_code,
                                                    l_cap_card_type
                                                   );
                                    EXCEPTION
                                       WHEN OTHERS
                                       THEN
                                          
                                          p_resp_msg_out :=
                                                'Error While logging statements_log txn :'
                                             || SUBSTR (SQLERRM, 1, 200);
                                          RAISE excp_reject_orderprocess;
                                    END;

                                    BEGIN
                                       INSERT INTO transactionlog
                                                   (msgtype, rrn,
                                                    delivery_channel,
                                                    date_time, txn_code,
                                                    txn_type, txn_mode,
                                                    txn_status,
                                                    response_code,
                                                    business_date,
                                                    business_time,
                                                    customer_card_no,
                                                    total_amount,
                                                    productid,
                                                    categoryid,
                                                    auth_id, trans_desc,
                                                    amount,
                                                    instcode, tranfee_amt,
                                                    cr_dr_flag,
                                                    customer_card_no_encr,
                                                    reversal_code,
                                                    customer_acct_no,
                                                    acct_balance,
                                                    ledger_balance,
                                                    response_id,
                                                    add_ins_date,
                                                    add_ins_user,
                                                    cardstatus, error_msg,
                                                    time_stamp
                                                   )
                                            VALUES ('0400', l_rrn,
                                                    l_delivery_channel,
                                                    SYSDATE, l_txn_code,
                                                    1, '0',
                                                    'C',
                                                    '00',
                                                    TO_CHAR (SYSDATE,
                                                             'yyyymmdd'
                                                            ),
                                                    l_business_time,
                                                    v_hash_pan,
                                                    l_cam_acct_bal,
                                                    l_cap_prod_code,
                                                    l_cap_card_type,
                                                    l_auth_id, l_tran_desc,
                                                    l_cam_acct_bal,
                                                    1, '0.00',
                                                    l_drcr_flag,
                                                    v_cap_pan_code_encr,
                                                    '69',
                                                    v_cap_acct_no,
                                                    '0',
                                                    '0',
                                                    1,
                                                    SYSDATE,
                                                    1,
                                                    v_card_stat, 'OK',
                                                    l_timestamp
                                                   );
                                    EXCEPTION
                                       WHEN OTHERS
                                       THEN
                                          
                                          p_resp_msg_out :=
                                                'Error While logging transactionlog txn :'
                                             || SUBSTR (SQLERRM, 1, 200);
                                          RAISE excp_reject_orderprocess;
                                    END;

                                    BEGIN
                                       INSERT INTO cms_transaction_log_dtl
                                                   (ctd_delivery_channel,
                                                    ctd_txn_code,
                                                    ctd_txn_type,
                                                    ctd_txn_mode,
                                                    ctd_business_date,
                                                    ctd_business_time,
                                                    ctd_customer_card_no,
                                                    ctd_txn_amount,
                                                    ctd_actual_amount,
                                                    ctd_bill_amount,
                                                    ctd_process_flag,
                                                    ctd_process_msg,
                                                    ctd_rrn,
                                                    ctd_customer_card_no_encr,
                                                    ctd_msg_type,
                                                    ctd_cust_acct_number,
                                                    ctd_inst_code,
                                                    ctd_hashkey_id
                                                   )
                                            VALUES (l_delivery_channel,
                                                    l_txn_code,
                                                    1,
                                                    '0',
                                                    TO_CHAR (SYSDATE,
                                                             'yyyymmdd'
                                                            ),
                                                    l_business_time,
                                                    v_hash_pan,
                                                    l_cam_acct_bal,
                                                    l_cam_acct_bal,
                                                    l_cam_acct_bal,
                                                    'Y',
                                                    'Successful',
                                                    l_rrn,
                                                    v_cap_pan_code_encr,
                                                    '0400',
                                                    v_cap_acct_no,
                                                    '1',
                                                    l_hashkey_id
                                                   );
                                    EXCEPTION
                                       WHEN OTHERS
                                       THEN
                                        
                                          p_resp_msg_out :=
                                                'Error While logging log_dtl txn :'
                                             || SUBSTR (SQLERRM, 1, 200);
                                          RAISE excp_reject_orderprocess;
                                    END;
                                 EXCEPTION
                                    WHEN excp_reject_orderprocess
                                    THEN
                                       RAISE;
                                    WHEN OTHERS
                                    THEN
                                      
                                       p_resp_msg_out :=
                                             'Error While logging cancel order txn :'
                                          || SUBSTR (SQLERRM, 1, 200);
                                       RAISE excp_reject_orderprocess;
                                 END;
                              ELSE
                                 p_resp_msg_out :=
                                       'Account balance is not updated:'
                                    || v_cap_acct_no;
                                
                                 RAISE excp_reject_orderprocess;
                              END IF;
                        End If;
                           EXCEPTION
                              WHEN excp_reject_orderprocess
                              THEN
                                 RAISE;
                              WHEN OTHERS
                              THEN
                                 p_resp_msg_out :=
                                       'Error While close card acct no:'
                                    || SUBSTR (SQLERRM, 1, 200);
                                
                                 RAISE excp_reject_orderprocess;
                           END;
                        EXCEPTION
                           WHEN excp_reject_orderprocess
                           THEN
                              RAISE;
                           WHEN OTHERS
                           THEN
                              p_resp_msg_out :=
                                    'Error While closing txn code :'
                                 || SUBSTR (SQLERRM, 1, 200);
                            
                              RAISE excp_reject_orderprocess;
                        END;
                     
                  
               
            ELSE
                     p_resp_msg_out := 'Card NO IS NULL' || v_hash_pan;
                    
                     RAISE excp_reject_orderprocess;

            END IF;
         EXCEPTION
            WHEN excp_reject_orderprocess
            THEN
               NULL;
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                    'Error While closing cards :' || SUBSTR (SQLERRM, 1, 200);
              
         END;
         IF p_resp_msg_out = 'OK'
      THEN
         COMMIT;
      ELSE
         ROLLBACK;
      END IF;
      END LOOP;

      
   EXCEPTION
      WHEN OTHERS
      THEN
         p_resp_msg_out := 'Main Excp:' || SUBSTR (SQLERRM, 1, 200);
   END delete_cards;

      PROCEDURE cancel_order_request (
      p_inst_code_in    IN       NUMBER,
      p_order_id_in     IN       VARCHAR2,
      p_partner_id_in   IN       VARCHAR2,
      p_resp_code_out   OUT      VARCHAR2,
      p_resp_msg_out    OUT      VARCHAR2
   )
   AS
      excp_reject_order    EXCEPTION;
      l_order_count        NUMBER (5) := 0;
      l_cancel_order_cnt   NUMBER (5) := 0;
      l_activation_cnt     NUMBER (5) := 0;
   BEGIN
      p_resp_msg_out := 'SUCCESS';
      p_resp_code_out := '00';

      BEGIN
         SELECT COUNT (1)
           INTO l_order_count
           FROM vms_order_details
          WHERE vod_order_id = p_order_id_in
            AND vod_partner_id = p_partner_id_in;

         IF l_order_count = 0
         THEN
            p_resp_msg_out :=
                  'NO ORDER EXISTS FOR ORDER ID AND PARTNER ID COMBINATION:Order ID:'
               || p_order_id_in
               || ':ParnerID:'
               || p_partner_id_in;
            p_resp_code_out := '40';
            RAISE excp_reject_order;
         END IF;
      EXCEPTION
         WHEN excp_reject_order
         THEN
            RAISE;
         WHEN OTHERS
         THEN
            p_resp_msg_out :=
                  'Error While getting   ORDER_COUNT  :'
               || SUBSTR (SQLERRM, 1, 200);
            p_resp_code_out := '89';
      END;

      BEGIN
         SELECT COUNT (1)
           INTO l_cancel_order_cnt
           FROM vms_order_details
          WHERE vod_order_id = p_order_id_in
            AND vod_partner_id = p_partner_id_in
            AND UPPER (vod_order_status) = 'CANCELLED';

         IF l_cancel_order_cnt <> 0
         THEN
            p_resp_msg_out := 'ORDER ALREADY CANCELLED:';
            p_resp_code_out := '41';
            RAISE excp_reject_order;
         END IF;
      EXCEPTION
         WHEN excp_reject_order
         THEN
            RAISE;
         WHEN OTHERS
         THEN
            p_resp_msg_out :=
                  'Error While getting ORDER ALREADY CANCELLED check :'
               || SUBSTR (SQLERRM, 1, 200);
            p_resp_code_out := '89';
      END;

      BEGIN
         SELECT COUNT (1)
           INTO l_activation_cnt
           FROM vms_line_item_dtl, cms_appl_pan
          WHERE vli_order_id = p_order_id_in
            AND vli_partner_id = p_partner_id_in
            AND cap_pan_code = vli_pan_code
            AND cap_active_date IS NOT NULL;

         IF l_activation_cnt <> 0
         THEN
            p_resp_msg_out :=
                  l_activation_cnt
               || ' CARDS ALREADY ACTIVATED IN ORDER ID:'
               || p_order_id_in;
            p_resp_code_out := '42';
            RAISE excp_reject_order;
         END IF;
      EXCEPTION
         WHEN excp_reject_order
         THEN
            RAISE;
         WHEN OTHERS
         THEN
            p_resp_msg_out :=
                  'Error While getting CARDS ALREADY ACTIVATED check :'
               || SUBSTR (SQLERRM, 1, 200);
            p_resp_code_out := '89';
      END;

      BEGIN
         UPDATE vms_order_lineitem
            SET vol_ccf_flag = 3,
                vol_order_status = 'CANCELLED'
          WHERE vol_order_id = p_order_id_in
            AND vol_partner_id = p_partner_id_in;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_resp_msg_out :=
                  'Error While UPDATE ORDER STATUS AS CANCELLED IN OREDR LINE ITEM :'
               || SUBSTR (SQLERRM, 1, 200);
            p_resp_code_out := '89';
      END;

      BEGIN
         UPDATE vms_order_details
            SET vod_order_status = 'CANCELLED'
          WHERE vod_order_id = p_order_id_in
            AND vod_partner_id = p_partner_id_in;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_resp_msg_out :=
                  'Error While UPDATE OREDR DETAILS STATUS AS CANCELLED :'
               || SUBSTR (SQLERRM, 1, 200);
            p_resp_code_out := '89';
      END;
   EXCEPTION
      WHEN excp_reject_order
      THEN
         NULL;
      WHEN OTHERS
      THEN
         p_resp_msg_out :=
             'Error While cancel_order_request :' || SUBSTR (SQLERRM, 1, 200);
         p_resp_code_out := '89';
   END cancel_order_request;

   PROCEDURE cancel_order_process (
      p_inst_code_in       IN       NUMBER,
      p_order_id_in        IN       VARCHAR2,
      p_partner_id_in      IN       VARCHAR2,
      p_resp_code_out      OUT      VARCHAR2,
      p_resp_msg_out       OUT      VARCHAR2,
      p_postback_url_out   OUT      VARCHAR2
   )
   AS
      excp_reject_orderprocess   EXCEPTION;
      v_cap_pan_code_encr        cms_appl_pan.cap_pan_code_encr%TYPE;
      v_tran_date                VARCHAR2 (50);
      v_tran_time                VARCHAR2 (50);
      l_ccs_tran_code            cms_card_stat.ccs_tran_code%TYPE;
      l_auth_id                  transactionlog.auth_id%TYPE;
      l_err_msg                  transactionlog.error_msg%TYPE;
      l_resp_cde                 transactionlog.response_code%TYPE;
      v_hash_pan                 vms_line_item_dtl.vli_pan_code%TYPE;
      v_cap_acct_no              cms_appl_pan.cap_acct_no%TYPE;
      l_drcr_flag                cms_statements_log.csl_trans_type%TYPE
                                                                      := 'DR';
      l_cam_acct_bal             cms_acct_mast.cam_acct_bal%TYPE;
      l_cam_ledger_bal           cms_acct_mast.cam_ledger_bal%TYPE;
      l_cap_prod_code            cms_appl_pan.cap_prod_code%TYPE;
      l_cap_card_type            cms_appl_pan.cap_card_type%TYPE;
      l_delivery_channel         transactionlog.delivery_channel%TYPE := '05';
      l_txn_code                 transactionlog.txn_code%TYPE         := '77';
      l_timestamp                transactionlog.time_stamp%TYPE;
      l_rrn                      transactionlog.rrn%TYPE;
      l_business_time            transactionlog.business_time%TYPE;
      l_hashkey_id               cms_transaction_log_dtl.ctd_hashkey_id%TYPE;
      l_narration                cms_statements_log.csl_trans_narrration%TYPE;
      l_tran_desc                cms_transaction_mast.ctm_tran_desc%TYPE;

      CURSOR cur_cards (l_order_id VARCHAR2, l_partner_id VARCHAR2)
      IS
         SELECT linedtl.vli_pan_code
           FROM vms_line_item_dtl LINEDTL, vms_order_details ORDDTL
          WHERE linedtl.vli_order_id = l_order_id
            AND linedtl.vli_partner_id = l_partner_id
            AND UPPER (orddtl.vod_order_status) = 'CANCELLED'
            AND linedtl.vli_order_id = orddtl.vod_order_id
            AND linedtl.vli_partner_id = orddtl.vod_partner_id;
   BEGIN
      p_resp_code_out := '00';
      p_resp_msg_out := 'Success';

      BEGIN
         SELECT ctm_tran_desc
           INTO l_tran_desc
           FROM cms_transaction_mast
          WHERE ctm_delivery_channel = l_delivery_channel
            AND ctm_tran_code = l_txn_code;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_resp_code_out := '89';
            p_resp_msg_out :=
                  'Error While getting transaction details :'
               || SUBSTR (SQLERRM, 1, 200);
            RAISE excp_reject_orderprocess;
      END;

      OPEN cur_cards (p_order_id_in, p_partner_id_in);

      LOOP
         FETCH cur_cards
          INTO v_hash_pan;

         EXIT WHEN cur_cards%NOTFOUND;

         BEGIN
            IF v_hash_pan IS NOT NULL
            THEN
               BEGIN
                  UPDATE cms_appl_pan
                     SET cap_card_stat = '9'
                   WHERE cap_pan_code = v_hash_pan;

                  IF SQL%ROWCOUNT = 1
                  THEN
                     BEGIN
                        SELECT ccs_tran_code
                          INTO l_ccs_tran_code
                          FROM cms_card_stat
                         WHERE ccs_stat_code = '9';

                        BEGIN
                           l_auth_id := LPAD (seq_auth_id.NEXTVAL, 6, '0');
                           l_rrn :=
                                 TO_CHAR (SYSTIMESTAMP, 'yymmddHH24MISS')
                              || seq_passivestatupd_rrn.NEXTVAL;
                           l_business_time := TO_CHAR (SYSDATE, 'hh24miss');
                           l_timestamp := SYSTIMESTAMP;

                           SELECT cap_pan_code_encr, cap_acct_no,
                                  cap_prod_code, cap_card_type
                             INTO v_cap_pan_code_encr, v_cap_acct_no,
                                  l_cap_prod_code, l_cap_card_type
                             FROM cms_appl_pan
                            WHERE cap_pan_code = v_hash_pan;

                           sp_log_cardstat_chnge (1,
                                                  v_hash_pan,
                                                  v_cap_pan_code_encr,
                                                  l_auth_id,
                                                  l_ccs_tran_code,
                                                  '',
                                                  v_tran_date,
                                                  v_tran_time,
                                                  l_resp_cde,
                                                  l_err_msg
                                                 );

                           BEGIN
                              SELECT cam_acct_bal, cam_ledger_bal
                                INTO l_cam_acct_bal, l_cam_ledger_bal
                                FROM cms_acct_mast
                               WHERE cam_acct_no = v_cap_acct_no;

                              UPDATE cms_acct_mast
                                 SET cam_acct_bal = 0,
                                     cam_ledger_bal = 0
                               WHERE cam_acct_no = v_cap_acct_no;

                              IF SQL%ROWCOUNT = 1
                              THEN
                                 BEGIN
                                    l_hashkey_id :=
                                       gethash
                                          (   l_delivery_channel
                                           || l_txn_code
                                           || fn_dmaps_main
                                                          (v_cap_pan_code_encr)
                                           || l_rrn
                                           || TO_CHAR (l_timestamp,
                                                       'YYYYMMDDHH24MISSFF5'
                                                      )
                                          );
                                    l_narration :=
                                          l_tran_desc
                                       || '/'
                                       || TO_CHAR (SYSDATE, 'yyyymmdd')
                                       || '/'
                                       || l_auth_id;

                                    BEGIN
                                       INSERT INTO cms_statements_log
                                                   (csl_pan_no,
                                                    csl_opening_bal,
                                                    csl_trans_amount,
                                                    csl_trans_type,
                                                    csl_trans_date,
                                                    csl_closing_balance,
                                                    csl_trans_narrration,
                                                    csl_pan_no_encr,
                                                    csl_rrn, csl_auth_id,
                                                    csl_business_date,
                                                    csl_business_time,
                                                    txn_fee_flag,
                                                    csl_delivery_channel,
                                                    csl_inst_code,
                                                    csl_txn_code,
                                                    csl_ins_date,
                                                    csl_ins_user,
                                                    csl_acct_no,
                                                    csl_panno_last4digit,
                                                    csl_time_stamp,
                                                    csl_prod_code,
                                                    csl_card_type
                                                   )
                                            VALUES (v_hash_pan,
                                                    0,
                                                    l_cam_acct_bal,
                                                    l_drcr_flag,
                                                    SYSDATE,
                                                    0,
                                                    l_narration,
                                                    v_cap_pan_code_encr,
                                                    l_rrn, l_auth_id,
                                                    TO_CHAR (SYSDATE,
                                                             'yyyymmdd'
                                                            ),
                                                    l_business_time,
                                                    'N',
                                                    l_delivery_channel,
                                                    p_inst_code_in,
                                                    l_txn_code,
                                                    SYSDATE,
                                                    1,
                                                    v_cap_acct_no,
                                                    SUBSTR
                                                       (fn_dmaps_main
                                                           (v_cap_pan_code_encr
                                                           ),
                                                        -4
                                                       ),
                                                    l_timestamp,
                                                    l_cap_prod_code,
                                                    l_cap_card_type
                                                   );
                                    EXCEPTION
                                       WHEN OTHERS
                                       THEN
                                          p_resp_code_out := '89';
                                          p_resp_msg_out :=
                                                'Error While logging statements_log txn :'
                                             || SUBSTR (SQLERRM, 1, 200);
                                          RAISE excp_reject_orderprocess;
                                    END;

                                    BEGIN
                                       INSERT INTO transactionlog
                                                   (msgtype, rrn,
                                                    delivery_channel,
                                                    date_time, txn_code,
                                                    txn_type, txn_mode,
                                                    txn_status,
                                                    response_code,
                                                    business_date,
                                                    business_time,
                                                    customer_card_no,
                                                    total_amount,
                                                    productid,
                                                    categoryid,
                                                    auth_id, trans_desc,
                                                    amount,
                                                    instcode, tranfee_amt,
                                                    cr_dr_flag,
                                                    customer_card_no_encr,
                                                    reversal_code,
                                                    customer_acct_no,
                                                    acct_balance,
                                                    ledger_balance,
                                                    response_id,
                                                    add_ins_date,
                                                    add_ins_user,
                                                    cardstatus, error_msg,
                                                    time_stamp
                                                   )
                                            VALUES ('0200', l_rrn,
                                                    l_delivery_channel,
                                                    SYSDATE, l_txn_code,
                                                    1, '0',
                                                    'C',
                                                    '00',
                                                    TO_CHAR (SYSDATE,
                                                             'yyyymmdd'
                                                            ),
                                                    l_business_time,
                                                    v_hash_pan,
                                                    l_cam_acct_bal,
                                                    l_cap_prod_code,
                                                    l_cap_card_type,
                                                    l_auth_id, l_tran_desc,
                                                    l_cam_acct_bal,
                                                    p_inst_code_in, '0.00',
                                                    l_drcr_flag,
                                                    v_cap_pan_code_encr,
                                                    0,
                                                    v_cap_acct_no,
                                                    '0',
                                                    '0',
                                                    1,
                                                    SYSDATE,
                                                    1,
                                                    '9', 'OK',
                                                    l_timestamp
                                                   );
                                    EXCEPTION
                                       WHEN OTHERS
                                       THEN
                                          p_resp_code_out := '89';
                                          p_resp_msg_out :=
                                                'Error While logging transactionlog txn :'
                                             || SUBSTR (SQLERRM, 1, 200);
                                          RAISE excp_reject_orderprocess;
                                    END;

                                    BEGIN
                                       INSERT INTO cms_transaction_log_dtl
                                                   (ctd_delivery_channel,
                                                    ctd_txn_code,
                                                    ctd_txn_type,
                                                    ctd_txn_mode,
                                                    ctd_business_date,
                                                    ctd_business_time,
                                                    ctd_customer_card_no,
                                                    ctd_txn_amount,
                                                    ctd_actual_amount,
                                                    ctd_bill_amount,
                                                    ctd_process_flag,
                                                    ctd_process_msg,
                                                    ctd_rrn,
                                                    ctd_customer_card_no_encr,
                                                    ctd_msg_type,
                                                    ctd_cust_acct_number,
                                                    ctd_inst_code,
                                                    ctd_hashkey_id
                                                   )
                                            VALUES (l_delivery_channel,
                                                    l_txn_code,
                                                    1,
                                                    '0',
                                                    TO_CHAR (SYSDATE,
                                                             'yyyymmdd'
                                                            ),
                                                    l_business_time,
                                                    v_hash_pan,
                                                    l_cam_acct_bal,
                                                    l_cam_acct_bal,
                                                    l_cam_acct_bal,
                                                    'Y',
                                                    'Successful',
                                                    l_rrn,
                                                    v_cap_pan_code_encr,
                                                    '0200',
                                                    v_cap_acct_no,
                                                    p_inst_code_in,
                                                    l_hashkey_id
                                                   );
                                    EXCEPTION
                                       WHEN OTHERS
                                       THEN
                                          p_resp_code_out := '89';
                                          p_resp_msg_out :=
                                                'Error While logging log_dtl txn :'
                                             || SUBSTR (SQLERRM, 1, 200);
                                          RAISE excp_reject_orderprocess;
                                    END;
                                 EXCEPTION
                                    WHEN excp_reject_orderprocess
                                    THEN
                                       RAISE;
                                    WHEN OTHERS
                                    THEN
                                       p_resp_code_out := '89';
                                       p_resp_msg_out :=
                                             'Error While logging cancel order txn :'
                                          || SUBSTR (SQLERRM, 1, 200);
                                       RAISE excp_reject_orderprocess;
                                 END;
                              ELSE
                                 p_resp_msg_out :=
                                       'Account balance is not updated:'
                                    || v_cap_acct_no;
                                 p_resp_code_out := '89';
                                 RAISE excp_reject_orderprocess;
                              END IF;
                           EXCEPTION
                              WHEN excp_reject_orderprocess
                              THEN
                                 RAISE;
                              WHEN OTHERS
                              THEN
                                 p_resp_msg_out :=
                                       'Error While close card acct no:'
                                    || SUBSTR (SQLERRM, 1, 200);
                                 p_resp_code_out := '89';
                                 RAISE excp_reject_orderprocess;
                           END;
                        EXCEPTION
                           WHEN excp_reject_orderprocess
                           THEN
                              RAISE;
                           WHEN OTHERS
                           THEN
                              p_resp_msg_out :=
                                    'Error While closing txn code :'
                                 || SUBSTR (SQLERRM, 1, 200);
                              p_resp_code_out := '89';
                              RAISE excp_reject_orderprocess;
                        END;
                     EXCEPTION
                        WHEN excp_reject_orderprocess
                        THEN
                           RAISE;
                        WHEN OTHERS
                        THEN
                           p_resp_msg_out :=
                                 'Error While getting closed card txn code :'
                              || SUBSTR (SQLERRM, 1, 200);
                           p_resp_code_out := '89';
                           RAISE excp_reject_orderprocess;
                     END;
                  ELSE
                     p_resp_msg_out := 'Card Not Closed:' || v_hash_pan;
                     p_resp_code_out := '89';
                     RAISE excp_reject_orderprocess;
                  END IF;
               EXCEPTION
                  WHEN excp_reject_orderprocess
                  THEN
                     RAISE;
                  WHEN OTHERS
                  THEN
                     p_resp_msg_out :=
                           'Error While closinappl_pan closing cards :'
                        || SUBSTR (SQLERRM, 1, 200);
                     p_resp_code_out := '89';
                     RAISE excp_reject_orderprocess;
               END;
            ELSE
                     p_resp_msg_out := 'Card NO IS NULL' || v_hash_pan;
                     p_resp_code_out := '89';
                     RAISE excp_reject_orderprocess;

            END IF;
         EXCEPTION
            WHEN excp_reject_orderprocess
            THEN
               NULL;
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                    'Error While closing cards :' || SUBSTR (SQLERRM, 1, 200);
               p_resp_code_out := '89';
         END;
      END LOOP;

            IF p_resp_code_out = '00'
      THEN
     
     BEGIN
      
         SELECT DECODE (UPPER (vod_postback_response),
                        '1', vod_postback_url,
                        'TRUE', vod_postback_url,
                        ''
                       )
           INTO p_postback_url_out
           FROM vms_order_details
          WHERE vod_order_id = p_order_id_in
            AND vod_partner_id = p_partner_id_in;
      EXCEPTION        
       WHEN OTHERS 
            THEN
            p_postback_url_out := NULL;  
     END;
            
      END IF;
   END cancel_order_process;
END vmsb2bapi;
/
show error;