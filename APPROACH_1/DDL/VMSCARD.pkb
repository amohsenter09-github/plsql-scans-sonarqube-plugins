create or replace PACKAGE BODY               vmscms.VMSCARD
IS
   -- Private type declarations

   -- Private constant declarations
   l_dummy         VARCHAR2 (1) := '*';
   l_const         NUMBER := 1;
   l_appl_status   VARCHAR (1) := 'A';
   l_state_data    gen_state_mast.gsm_switch_state_code%TYPE := 'GA';
   l_seg31_typ     cms_acct_type.cat_switch_type%TYPE := 11;
   l_seg31_stat    cms_acct_stat.cas_switch_statcode%TYPE := '3';
   l_CCFGEN_stat    cms_cardissuance_status.CCS_CARD_STATUS%TYPE := '3';
   l_card_seq         NUMBER := 1;

   -- Private variable declarations

   -- Function and procedure implementations
   PROCEDURE transfer_pan_data (p_file_name_in       VARCHAR2,
                                p_resp_msg_out   OUT VARCHAR2)
   IS
      l_errmsg     VARCHAR2 (1000);
      l_excption   EXCEPTION;
   BEGIN
      p_resp_msg_out := 'OK';

      BEGIN
         INSERT INTO cms_appl_pan (cap_appl_code,
                                   cap_inst_code,
                                   cap_asso_code,
                                   cap_inst_type,
                                   cap_prod_code,
                                   cap_prod_catg,
                                   cap_card_type,
                                   cap_cust_catg,
                                   cap_pan_code,
                                   cap_mbr_numb,
                                   cap_card_stat,
                                   cap_cust_code,
                                   cap_disp_name,
                                   cap_limit_amt,
                                   cap_use_limit,
                                   cap_appl_bran,
                                   cap_expry_date,
                                   cap_addon_stat,
                                   cap_addon_link,
                                   cap_mbr_link,
                                   cap_acct_id,
                                   cap_acct_no,
                                   cap_tot_acct,
                                   cap_bill_addr,
                                   cap_chnl_code,
                                   cap_pangen_date,
                                   cap_pangen_user,
                                   cap_cafgen_flag,
                                   cap_pin_flag,
                                   cap_embos_flag,
                                   cap_phy_embos,
                                   cap_join_feecalc,
                                   cap_next_bill_date,
                                   cap_next_mb_date,
                                   cap_request_id,
                                   cap_issue_flag,
                                   cap_ins_user,
                                   cap_lupd_user,
                                   cap_firsttime_topup,
                                   cap_panmast_param1,
                                   cap_panmast_param2,
                                   cap_panmast_param3,
                                   cap_panmast_param4,
                                   cap_panmast_param5,
                                   cap_panmast_param6,
                                   cap_panmast_param7,
                                   cap_panmast_param8,
                                   cap_panmast_param9,
                                   cap_panmast_param10,
                                   cap_pan_code_encr,
                                   cap_proxy_number,
                                   cap_proxy_msg,
                                   cap_startercard_flag,
                                   cap_inactive_feecalc_date,
                                   cap_mask_pan,
                                   cap_pin_off,
                                   cap_ipin_offset,
                                   cap_pingen_date,
                                   cap_pingen_user,
                                   cap_cardpack_id,
                                   cap_user_identify_type)
            SELECT a.cap_appl_code,
                   a.cap_inst_code,
                   a.cap_asso_code,
                   a.cap_inst_type,
                   a.cap_prod_code,
                   a.cap_prod_catg,
                   a.cap_card_type,
                   a.cap_cust_catg,
                   a.cap_pan_code,
                   a.cap_mbr_numb,
                   a.cap_card_stat,
                   a.cap_cust_code,
                   a.cap_disp_name,
                   a.cap_limit_amt,
                   a.cap_use_limit,
                   a.cap_appl_bran,
                   a.cap_expry_date,
                   a.cap_addon_stat,
                   a.cap_addon_link,
                   a.cap_mbr_link,
                   a.cap_acct_id,
                   a.cap_acct_no,
                   a.cap_tot_acct,
                   a.cap_bill_addr,
                   a.cap_chnl_code,
                   a.cap_pangen_date,
                   a.cap_pangen_user,
                   a.cap_cafgen_flag,
                   a.cap_pin_flag,
                   a.cap_embos_flag,
                   a.cap_phy_embos,
                   a.cap_join_feecalc,
                   a.cap_next_bill_date,
                   a.cap_next_mb_date,
                   a.cap_request_id,
                   a.cap_issue_flag,
                   a.cap_ins_user,
                   a.cap_lupd_user,
                   a.cap_firsttime_topup,
                   a.cap_panmast_param1,
                   a.cap_panmast_param2,
                   a.cap_panmast_param3,
                   a.cap_panmast_param4,
                   a.cap_panmast_param5,
                   a.cap_panmast_param6,
                   a.cap_panmast_param7,
                   a.cap_panmast_param8,
                   a.cap_panmast_param9,
                   a.cap_panmast_param10,
                   a.cap_pan_code_encr,
                   a.cap_proxy_number,
                   a.cap_proxy_msg,
                   a.cap_startercard_flag,
                   a.cap_inactive_feecalc_date,
                   a.cap_mask_pan,
                   a.cap_pin_off,
                   a.cap_ipin_offset,
                   a.cap_pingen_date,
                   a.cap_pingen_user,
                   a.cap_cardpack_id,
                   a.cap_user_identify_type
 FROM cms_appl_pan_temp a,cms_cardissuance_status cis
             WHERE a.cap_file_name IN
                      (    SELECT REGEXP_SUBSTR (p_file_name_in,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL)
                             FROM DUAL
                       CONNECT BY REGEXP_SUBSTR (p_file_name_in,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL)
                                     is not null)
             AND a.cap_pan_code=cis.ccs_pan_code and cis.ccs_Card_status=l_CCFGEN_stat;
      EXCEPTION
         WHEN OTHERS
         THEN
            l_errmsg :=
               'Error while bulk-inserts:' || SUBSTR (SQLERRM, 1, 200);
            RAISE l_excption;
      END;

      BEGIN
         DELETE FROM vmscms.cms_appl_pan_temp
               where (cap_file_name,cap_pan_code) in (  select  a.cap_file_name,a.cap_pan_code
                        FROM cms_appl_pan_temp a,cms_cardissuance_status cis
                        WHERE a.cap_file_name IN
                                  (    SELECT REGEXP_SUBSTR (p_file_name_in,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL)
                                    FROM DUAL
                                    CONNECT BY REGEXP_SUBSTR (p_file_name_in,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL)
                                               is not null)
            AND a.cap_pan_code=cis.ccs_pan_code and cis.ccs_Card_status=l_CCFGEN_stat);
      EXCEPTION
         WHEN OTHERS
         THEN
            l_errmsg :=
                  'Error while delete-data for file -'
               || p_file_name_in
               || ' :'
               || SUBSTR (SQLERRM, 1, 200);
            RAISE l_excption;
      END;

      COMMIT;
   EXCEPTION
      WHEN l_excption
      THEN
         ROLLBACK;
         p_resp_msg_out := l_errmsg;
      WHEN OTHERS
      THEN
         ROLLBACK;
         l_errmsg := 'Main excption:' || SUBSTR (SQLERRM, 1, 200);
         p_resp_msg_out := l_errmsg;
   END;

   PROCEDURE get_card_no (p_prod_code_in   IN     VARCHAR2,
                          p_prod_catg_in   IN     NUMBER,
                          p_card_no_out       OUT VARCHAR2,
                          p_resp_msg_out      OUT VARCHAR2)
   IS

/*************************************************

     * Modified By      : Ubaidur Rahman H
     * Modified Date    : 29-AUG-2019
     * Purpose          : VMS-1084 (Pan genaration process from sequential to shuffled - B2B and Retail)
     * Reviewer         : Saravanakumar A
     * Release Number   : VMSGPRHOSTR20_B1    

     * Modified By      : Ubaidur Rahman H
     * Modified Date    : 16-OCT-2019
     * Purpose          : To improve performance.
     * Reviewer         : Saravanakumar A
     * Release Number   : VMS_RSI0219

     * Modified By      : Ubaidur Rahman H
     * Modified Date    : 30-OCT-2019
     * Purpose          : VMS-1248 (Improve Query performance for BOL SQL for card creation)
     * Reviewer         : Saravanakumar A 
*************************************************/      
      l_pan_code      cms_appl_pan_inv.cap_pan_code%TYPE;
      resource_busy   EXCEPTION;
      l_exp     EXCEPTION;
      PRAGMA EXCEPTION_INIT (resource_busy, -54);
      PRAGMA AUTONOMOUS_TRANSACTION;
      l_start_control_number VMS_INVENTORY_CONTROL.VIC_CONTROL_NUMBER%TYPE;

   BEGIN
      p_resp_msg_out := 'OK';
      
    BEGIN
            SELECT VIC_CONTROL_NUMBER 
            INTO l_start_control_number
            FROM VMS_INVENTORY_CONTROL
            WHERE VIC_PROD_CODE=p_prod_code_in
            AND VIC_CARD_TYPE=p_prod_catg_in
            FOR UPDATE;
     EXCEPTION
        WHEN OTHERS THEN
            p_resp_msg_out:= 'Error while selecting VMS_INVENTORY_CONTROL '||substr(sqlerrm,1,200);
            raise l_exp;
     END;
 
  
      BEGIN
        UPDATE VMS_INVENTORY_CONTROL
        SET VIC_CONTROL_NUMBER =l_start_control_number+1
        WHERE VIC_PROD_CODE=p_prod_code_in
        AND VIC_CARD_TYPE=p_prod_catg_in;
     EXCEPTION
        WHEN OTHERS THEN
            p_resp_msg_out:= 'Error while updating VMS_INVENTORY_CONTROL '||substr(sqlerrm,1,200);
            raise l_exp;
     END;

          SELECT cap_pan_code, fn_dmaps_main (cap_pan_code_encr)
            INTO l_pan_code, p_card_no_out
            FROM cms_appl_pan_inv
           WHERE cap_prod_code = p_prod_code_in              --VMS-1084 (Pan genaration process from sequential to shuffled - B2B and Retail)
                 AND cap_card_type = p_prod_catg_in
                 AND cap_issue_stat = 'N'
                 AND cap_card_seq  =l_start_control_number ;
			  /*(SELECT cap_card_seq
			  FROM
			    (SELECT a.cap_card_seq
			    FROM cms_appl_pan_inv a
			    WHERE a.cap_prod_code= p_prod_code_in
			    AND a.cap_card_type  = p_prod_catg_in
			    AND a.cap_issue_stat ='N'
			    AND ROWNUM < 10000
			    ORDER BY dbms_random.value
			    )
			  WHERE ROWNUM = 1
			  )
      FOR UPDATE WAIT 1;*/

      UPDATE cms_appl_pan_inv
         SET cap_issue_stat = 'I'
       WHERE cap_pan_code = l_pan_code;

      COMMIT;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         p_resp_msg_out := 'No cards available in inventory.!';
         ROLLBACK;
      WHEN resource_busy
      THEN
         p_resp_msg_out := 'Please try after some time.!';
         ROLLBACK;
      WHEN  l_exp
      THEN
        ROLLBACK;
      WHEN OTHERS
      THEN
         ROLLBACK;
         p_resp_msg_out := 'Main Excp:' || SUBSTR (SQLERRM, 1, 200);
   END get_card_no;

   PROCEDURE process_card_order (p_prod_code_in   IN     VARCHAR2,
                                 p_prod_catg_in   IN     NUMBER,
                                 p_card_stat_in   IN     VARCHAR2,
                                 p_disp_name_in   IN     VARCHAR2,
                                 p_stock_cnt_in   IN     NUMBER,
                                 p_user_code_in   IN     NUMBER,
                                 p_resp_msg_out      OUT VARCHAR2)
   IS

/*************************************************

 	   * Modified By      : Ubaidur Rahman H
     * Modified Date    : 29-AUG-2019
     * Purpose          : VMS-1084 (Pan genaration process from sequential to shuffled - B2B and Retail)
     * Reviewer         : Saravanakumar A
     * Release Number   : VMSGPRHOSTR20_B1   

     * Modified By      : Ubaidur Rahman H
     * Modified Date    : 30-OCT-2019
     * Purpose          : VMS-1248 (Improve Query performance for BOL SQL for card creation)
     * Reviewer         : Saravanakumar A 	 	 
*************************************************/     
      l_profile_code      cms_prod_cattype.cpc_profile_code%TYPE;
      l_expry_param       cms_bin_param.cbp_param_value%TYPE;
      l_validity_period   cms_bin_param.cbp_param_value%TYPE;
      l_expdt_exemption   cms_prod_cattype.cpc_exp_date_exemption%TYPE;
      l_expry_date        cms_appl_pan.cap_expry_date%TYPE;
      l_mbr_numb          VARCHAR2 (5) := '000';
      l_start_control_number VMS_INVENTORY_CONTROL.VIC_CONTROL_NUMBER%TYPE;
      l_end_control_number VMS_INVENTORY_CONTROL.VIC_CONTROL_NUMBER%TYPE;

      CURSOR cur_cards
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
                cap_appl_bran,
                cap_user_identify_type
           FROM cms_appl_pan_inv
           WHERE cap_prod_code = p_prod_code_in                      --VMS-1084 (Pan genaration process from sequential to shuffled - B2B and Retail)
                 AND cap_card_type = p_prod_catg_in
                 AND cap_issue_stat = 'N'
                 AND cap_card_seq  between l_start_control_number and l_end_control_number;
			  /*(SELECT cap_card_seq
			  FROM
			    (SELECT a.cap_card_seq 
			    FROM cms_appl_pan_inv a
			    WHERE a.cap_prod_code= p_prod_code_in
			    AND a.cap_card_type  = p_prod_catg_in
			    AND a.cap_issue_stat ='N'
			    AND ROWNUM <= p_stock_cnt_in + 10000 /*Performance Issue Fix
			    ORDER BY dbms_random.value
			    )
			  WHERE ROWNUM <= p_stock_cnt_in
			  ) FOR UPDATE;*/

      TYPE t_cards IS TABLE OF cur_cards%ROWTYPE;

      cards               t_cards;
   BEGIN

      p_resp_msg_out := 'OK';

      SELECT cpc_profile_code, cpc_exp_date_exemption
        INTO l_profile_code, l_expdt_exemption
        FROM cms_prod_cattype
       WHERE     cpc_inst_code = l_const
             AND cpc_prod_code = p_prod_code_in
             AND cpc_card_type = p_prod_catg_in;

      BEGIN


            vmsfunutilities.get_expiry_date(l_const,p_prod_code_in,
            p_prod_catg_in,l_profile_code,l_expry_date,p_resp_msg_out);

            if p_resp_msg_out<>'OK' then
            RETURN;

      END IF;

         EXCEPTION
            when others then
                p_resp_msg_out:='Error while calling vmsfunutilities.get_expiry_date'||substr(sqlerrm,1,200);
               RETURN;
         END;

            BEGIN
                vmsb2bapi.get_inventory_control_number(p_prod_code_in,
                                      p_prod_catg_in,
                                      p_stock_cnt_in,
                                      l_start_control_number ,
                                      l_end_control_number ,
                                      p_resp_msg_out );
                 IF p_resp_msg_out <> 'OK' THEN
                    return;
                 END IF;
                 
              EXCEPTION
                WHEN OTHERS THEN
                 p_resp_msg_out :=
                        'Error while calling get_inventory_control_number '
                        || SUBSTR (SQLERRM, 1, 200);
                     return;
              END;
      OPEN cur_cards;

      LOOP
         FETCH cur_cards
         BULK COLLECT INTO cards
         LIMIT 1000;

         EXIT WHEN cards.COUNT = 0;

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
                                    cap_startercard_flag,
                                    cap_user_identify_type)
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
                       l_const,
                       l_const,
                       l_const,
                       l_mbr_numb,
                       p_disp_name_in,
                       'P',
                       cards (i).cap_pan_code,
                       l_mbr_numb,
                       l_const,
                       SYSDATE,
                       p_user_code_in,
                       p_user_code_in,
                       p_user_code_in,
                       'Y',
                       p_card_stat_in,
                       'Y',
                       cards (i).cap_user_identify_type)
                 INTO cms_cardissuance_status (ccs_inst_code,
                                               ccs_pan_code,
                                               ccs_card_status,
                                               ccs_ins_user,
                                               ccs_lupd_user,
                                               ccs_pan_code_encr,
                                               ccs_lupd_date,
                                               ccs_appl_code)
               VALUES (l_const,
                       cards (i).cap_pan_code,
                       2,
                       p_user_code_in,
                       p_user_code_in,
                       cards (i).cap_pan_code_encr,
                       SYSDATE,
                       cards (i).cap_appl_code)
                 INTO cms_smsandemail_alert (csa_inst_code,
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
               VALUES (l_const,
                       cards (i).cap_pan_code,
                       cards (i).cap_pan_code_encr,
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
                       SYSDATE)
                 INTO cms_pan_acct (cpa_inst_code,
                                    cpa_cust_code,
                                    cpa_acct_id,
                                    cpa_acct_posn,
                                    cpa_pan_code,
                                    cpa_mbr_numb,
                                    cpa_ins_user,
                                    cpa_lupd_user,
                                    cpa_pan_code_encr)
               VALUES (l_const,
                       cards (i).cap_cust_code,
                       cards (i).cap_acct_id,
                       l_const,
                       cards (i).cap_pan_code,
                       l_mbr_numb,
                       p_user_code_in,
                       p_user_code_in,
                       cards (i).cap_pan_code_encr)
                  SELECT * FROM DUAL;
         EXCEPTION
		 WHEN DUP_VAL_ON_INDEX THEN null;
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
                  'Error While Inserting Cards :' || SUBSTR (SQLERRM, 1, 200);
               EXIT;
         END;

         BEGIN
            FORALL i IN 1 .. cards.COUNT
               UPDATE cms_appl_mast
                  SET cam_appl_stat = 'O',
                      cam_lupd_user = p_user_code_in,
                      cam_process_msg = 'SUCCESSFUL'
                WHERE cam_inst_code = l_const
                      AND cam_appl_code = cards (i).cap_appl_code;
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_msg_out :=
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
               p_resp_msg_out :=
                  'Error While Updating Cards Issue Stat:'
                  || SUBSTR (SQLERRM, 1, 200);
               EXIT;
         END;
      END LOOP;

      CLOSE cur_cards;

      IF p_resp_msg_out <> 'OK'
      THEN
         ROLLBACK;
      ELSE
         COMMIT;
      END IF;

   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         p_resp_msg_out := 'Main excption:' || SUBSTR (SQLERRM, 1, 200);
   END process_card_order;

   PROCEDURE get_shuffle_serials (p_minval_in              NUMBER,
                                  p_maxval_in              NUMBER,
                                  p_shufflearray_out   OUT shuffle_array_typ)
   AS
      LANGUAGE JAVA
      NAME 'GenShuffle.generateShuffledList(long,long,oracle.sql.ARRAY[])';

   PROCEDURE generate_serial_numbers (
      p_inst_code_in     IN     NUMBER,
      p_prod_code_in     IN     VARCHAR2,
      p_prod_catg_in     IN     NUMBER,
      p_prod_prefix_in   IN     VARCHAR2,
      p_minval_in        IN     NUMBER,
      p_maxval_in        IN     NUMBER,
      p_serlno_out          OUT shuffle_array_typ,
      p_errmsg_out          OUT VARCHAR2)
   AS
      l_serl_no       shuffle_array_typ;
 --   l_serl_flag     cms_prod_cattype.cpc_serl_flag%TYPE;
      l_min_serlno    NUMBER;
      l_max_serlno    NUMBER;
      l_insert_serl   VARCHAR2 (1) := 'N';
      excp_error      EXCEPTION;
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      p_errmsg_out := 'OK';

      BEGIN
         SELECT vpc_ctrl_numb, vpc_max_serlno
           INTO l_min_serlno, l_max_serlno
           FROM vms_pan_ctrl_inv
          WHERE     vpc_inst_code = p_inst_code_in
                AND vpc_prod_code = p_prod_code_in
                AND vpc_prod_catg = p_prod_catg_in
                AND vpc_prod_prefix = p_prod_prefix_in;

         IF l_max_serlno = l_min_serlno
         THEN
            l_min_serlno := 0;
            l_max_serlno := 0;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_insert_serl := 'Y';
if p_minval_in =0 then
            l_min_serlno :=1;
            l_max_serlno := p_maxval_in+1;
else
            l_min_serlno := p_minval_in;
            l_max_serlno := p_maxval_in;
end if;
         WHEN OTHERS
         THEN
            p_errmsg_out :=
               'Error while selecting serials dtls:'
               || SUBSTR (SQLERRM, 1, 200);
            RAISE excp_error;
      END;

      IF  l_max_serlno >0
      THEN
         SELECT serials
           BULK COLLECT INTO p_serlno_out
           FROM (    SELECT ROWNUM serials
                       FROM DUAL
                 CONNECT BY LEVEL <= l_max_serlno)
          WHERE serials >= l_min_serlno;
      END IF;

      IF l_insert_serl = 'Y'
      THEN
         BEGIN
            INSERT INTO vms_pan_ctrl_inv (vpc_inst_code,
                                          vpc_prod_code,
                                          vpc_prod_catg,
                                          vpc_prod_prefix,
                                          vpc_ctrl_numb,
                                          vpc_min_serlno,
                                          vpc_max_serlno,
                                          vpc_ins_date,
                                          vpc_ins_user)
                 VALUES (p_inst_code_in,
                         p_prod_code_in,
                         p_prod_catg_in,
                         p_prod_prefix_in,
                         l_min_serlno,
                         l_min_serlno,
                         l_max_serlno,
                         SYSDATE,
                         1);
         EXCEPTION
            WHEN OTHERS
            THEN
               p_errmsg_out :=
                  'Error while inserting serials:'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_error;
         END;

  END IF;
  
  --commented for VMS-1084(Pan genaration process from sequential to shuffled - B2B and Retail)
 /*         BEGIN
              SELECT cpc_serl_flag
              INTO l_serl_flag
              FROM cms_prod_cattype
              WHERE cpc_prod_code = p_prod_code_in
              AND cpc_card_type = p_prod_catg_in
              AND cpc_inst_code = p_inst_code_in;
         EXCEPTION
            WHEN OTHERS
            THEN
               p_errmsg_out :=
                  'Error while selecting serl_flag dtls:'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE excp_error;
         END;

         IF l_serl_flag = 1
         THEN*/
            BEGIN
               get_shuffle_serials (l_min_serlno, l_max_serlno, l_serl_no); 

             FORALL i IN 1 .. p_serlno_out.COUNT
                INSERT INTO vms_shfl_serl_inv (vss_inst_code,
                                               vss_prod_code,
                                               vss_prod_catg,
                                               vss_prod_prefix,
                                               vss_serl_numb,
                                               vss_shfl_cntrl,
                                               vss_ins_user,
                                               vss_ins_date)
                     VALUES (p_inst_code_in,
                             p_prod_code_in,
                             p_prod_catg_in,
                             p_prod_prefix_in,
                             l_serl_no (i),
                             p_serlno_out (i),
                             1,
                             SYSDATE);
          EXCEPTION
             WHEN OTHERS
             THEN
                p_errmsg_out :=
                   'Error while inserting shuffle serials:'
                   || SUBSTR (SQLERRM, 1, 200);
                RAISE excp_error;
          END;
       -- END IF;
      --END IF;

      COMMIT;
   EXCEPTION
      WHEN excp_error
      THEN
         ROLLBACK;
      WHEN OTHERS
      THEN
         ROLLBACK;
         p_errmsg_out := 'Main Excp:' || SUBSTR (SQLERRM, 1, 200);
   END generate_serial_numbers;

   PROCEDURE get_acct_srno (p_instcode_in   IN     NUMBER,
                            p_tmpacct_in    IN     VARCHAR2,
                            p_max_length    IN     NUMBER,
                            p_srno_out         OUT VARCHAR2,
                            p_errmsg_out       OUT VARCHAR2)
   IS
      resource_busy   EXCEPTION;
      PRAGMA EXCEPTION_INIT (resource_busy, -54);
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      p_errmsg_out := 'OK';

          SELECT cac_ctrl_numb
            INTO p_srno_out
            FROM cms_acct_ctrl
           WHERE cac_bran_code = p_tmpacct_in AND cac_inst_code = p_instcode_in
      FOR UPDATE WAIT 1;

      IF p_srno_out > LPAD ('9', p_max_length, 9)
      THEN
         p_srno_out := NULL;
         p_errmsg_out := 'Maximum serial number reached for account';
         RETURN;
      END IF;

      UPDATE cms_acct_ctrl
         SET cac_ctrl_numb = cac_ctrl_numb + 1
       WHERE cac_bran_code = p_tmpacct_in AND cac_inst_code = p_instcode_in;

      COMMIT;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         BEGIN
            INSERT INTO cms_acct_ctrl (cac_inst_code,
                                       cac_bran_code,
                                       cac_ctrl_numb,
                                       cac_max_serial_no)
                 VALUES (p_instcode_in,
                         p_tmpacct_in,
                         2,
                         LPAD ('9', p_max_length, 9));

            p_srno_out := 1;
            COMMIT;
         EXCEPTION
            WHEN OTHERS
            THEN
               p_errmsg_out :=
                  'While Inserting into cms_acct_ctrl: '
                  || SUBSTR (SQLERRM, 1, 200);
               ROLLBACK;
         END;
      WHEN resource_busy
      THEN
         p_errmsg_out := 'Please try after some time.!';
         ROLLBACK;
      WHEN OTHERS
      THEN
         p_errmsg_out :=
            'Main Excp get_acct_srno: ' || SUBSTR (SQLERRM, 1, 200);
         ROLLBACK;
   END get_acct_srno;

   PROCEDURE get_pan_srno (p_inst_code_in     IN     NUMBER,
                           p_prod_code_in     IN     VARCHAR2,
                           p_prod_catg_in     IN     NUMBER,
                           p_prod_prefix_in   IN     VARCHAR2,
                           p_serl_flag        IN     NUMBER,
                           p_serial_no_out       OUT NUMBER,
                           p_err_msg_out         OUT VARCHAR2)
   AS
      l_max_serlno   vms_pan_ctrl_inv.vpc_max_serlno%TYPE;
      l_serlno       vms_pan_ctrl_inv.vpc_ctrl_numb%TYPE;
   BEGIN
      p_err_msg_out := 'OK';

      BEGIN
         SELECT vpc_ctrl_numb, vpc_max_serlno
           INTO l_serlno, l_max_serlno
           FROM vms_pan_ctrl_inv
          WHERE     vpc_inst_code = p_inst_code_in
                AND vpc_prod_code = p_prod_code_in
                AND vpc_prod_catg = p_prod_catg_in
                AND vpc_prod_prefix = p_prod_prefix_in;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            p_err_msg_out :=
               'Serial number not found for product and product catg :';
            RETURN;
         WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while selecting current Serial : '
               || SUBSTR (SQLERRM, 1, 200);
            RETURN;
      END;

--commented for VMS-1084 (Pan genaration process from sequential to shuffled - B2B )
    -- IF p_serl_flag = 1
      --THEN
         BEGIN
            SELECT vss_serl_numb
              INTO p_serial_no_out
              FROM vms_shfl_serl_inv
             WHERE     vss_inst_code = p_inst_code_in
                   AND vss_prod_code = p_prod_code_in
                   AND vss_prod_catg = p_prod_catg_in
                   AND vss_prod_prefix = p_prod_prefix_in
                   AND vss_shfl_cntrl = l_serlno
                   AND vss_serl_flag = 0;

            UPDATE vms_shfl_serl_inv
               SET vss_serl_flag = 1
             WHERE     vss_inst_code = p_inst_code_in
                   AND vss_prod_code = p_prod_code_in
                   AND vss_prod_catg = p_prod_catg_in
                   AND vss_prod_prefix = p_prod_prefix_in
                   AND vss_shfl_cntrl = l_serlno;

            IF SQL%ROWCOUNT = 0
            THEN
               p_err_msg_out := 'Shuffle serial number not updated';
               RETURN;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p_err_msg_out :=
                  'Shuffle serial number not found for product and product catg :';
               RETURN;
            WHEN OTHERS
            THEN
               p_err_msg_out :=
                  'Error while selecting current shuffle serial : '
                  || SUBSTR (SQLERRM, 1, 200);
               RETURN;
         END;
     -- ELSE
     --    p_serial_no_out := l_serlno;
   --   END IF;

      IF l_max_serlno > l_serlno
      THEN
         UPDATE vms_pan_ctrl_inv
            SET vpc_ctrl_numb = vpc_ctrl_numb + 1
          WHERE     vpc_inst_code = p_inst_code_in
                AND vpc_prod_code = p_prod_code_in
                AND vpc_prod_catg = p_prod_catg_in
                AND vpc_prod_prefix = p_prod_prefix_in;

         IF SQL%ROWCOUNT = 0
         THEN
            p_err_msg_out := 'Serial number not updated';
         END IF;
      END IF;
   END get_pan_srno;

   FUNCTION get_chkdig (p_tmp_val_in IN VARCHAR2)
      RETURN NUMBER
   IS
      l_ceilable_sum   NUMBER := 0;
      l_ceiled_sum     NUMBER;
      l_res            NUMBER (3);
      l_mult_ind       NUMBER (1) := 2;
      l_dig_sum        NUMBER (2);
      l_dig_len        NUMBER (1);
      l_chkdigt_out    NUMBER;
   BEGIN
      FOR i IN REVERSE 1 .. LENGTH (p_tmp_val_in)
      LOOP
         l_res := SUBSTR (p_tmp_val_in, i, 1) * l_mult_ind;
         l_dig_len := LENGTH (l_res);

         IF l_dig_len = 2
         THEN
            l_dig_sum := SUBSTR (l_res, 1, 1) + SUBSTR (l_res, 2, 1);
         ELSE
            l_dig_sum := l_res;
         END IF;

         l_ceilable_sum := l_ceilable_sum + l_dig_sum;

         IF l_mult_ind = 2
         THEN
            l_mult_ind := 1;
         ELSE
            l_mult_ind := 2;
         END IF;
      END LOOP;

      l_ceiled_sum := l_ceilable_sum;

      IF MOD (l_ceilable_sum, 10) != 0
      THEN
         LOOP
            l_ceiled_sum := l_ceiled_sum + 1;
            EXIT WHEN MOD (l_ceiled_sum, 10) = 0;
         END LOOP;
      END IF;

      l_chkdigt_out := l_ceiled_sum - l_ceilable_sum;
      RETURN l_chkdigt_out;
   END get_chkdig;

   PROCEDURE get_ranges (p_start_bin_in      IN     VARCHAR2,
                         p_end_bin_in        IN     VARCHAR2,
                         p_start_range_in    IN     VARCHAR2,
                         p_end_range_in      IN     VARCHAR2,
                         p_ranges_dtls_out   OUT    SYS_REFCURSOR)
   AS
   BEGIN
      OPEN p_ranges_dtls_out FOR
         SELECT s_bin,
                CASE
                   WHEN p_start_bin_in = s_bin THEN p_start_range_in
                   ELSE LPAD ('1', LENGTH (p_start_range_in), '0')
                END
                   strt,
                CASE
                   WHEN p_end_bin_in = s_bin THEN p_end_range_in
                   ELSE LPAD ('9', LENGTH (p_start_range_in), '9')
                END
                   end
           FROM (    SELECT p_start_bin_in + (LEVEL - 1) s_bin
                       FROM DUAL
                 CONNECT BY LEVEL <= (p_end_bin_in - p_start_bin_in) + 1);
   END get_ranges;

   PROCEDURE generate_inventory (p_inst_code_in     IN NUMBER,
                                 p_user_code_in     IN NUMBER,
                                 p_prod_code_in     IN VARCHAR2,
                                 p_prod_catg_in     IN NUMBER,
                                 p_prod_prefix_in   IN VARCHAR2,
                                 p_prod_sufix_in    IN VARCHAR2,
                                 p_start_range_in   IN VARCHAR2,
                                 p_end_range_in     IN VARCHAR2)
   AS

/*************************************************
 	   * Modified By      : Ubaidur Rahman H
     * Modified Date    : 29-AUG-2019
     * Purpose          : VMS-1084 (Pan genaration process from sequential to shuffled - B2B and Retail)
     * Reviewer         : Saravanakumar A
     * Release Number   : VMSGPRHOSTR20_B1    
*************************************************/      
      c_card_ranges      SYS_REFCURSOR;
      l_prod_prefix      cms_prod_cattype.cpc_prod_prefix%TYPE;
      l_cardrange_from   cms_prod_cattype.cpc_start_card_no%TYPE;
      l_cardrange_to     cms_prod_cattype.cpc_end_card_no%TYPE;
      l_error_msg        VARCHAR2 (1000);
      l_proc_stat        VARCHAR2 (1) := 'Y';
      l_serl_no          shuffle_array_typ;
	    l_gen_cards        vms_pangen_summary.vps_avail_cards%type;
	  l_avail_cards		 vms_pangen_summary.vps_avail_cards%type;
      l_product_id       cms_prod_cattype.cpc_product_id%TYPE;
      l_profile_code     cms_prod_cattype.cpc_profile_code%TYPE;
      l_prod_type          cms_bin_param.cbp_param_value%TYPE;
      l_count_prodid     NUMBER;
      l_pin_loop_count   NUMBER := 0;
      
   BEGIN
      UPDATE vms_pangen_summary
         SET vps_process_status = 'I'
       WHERE vps_prod_code = p_prod_code_in
             AND vps_card_type = p_prod_catg_in;

      COMMIT;
      
      BEGIN
        INSERT INTO VMS_INVENTORY_CONTROL
                    (VIC_PROD_CODE,
                    VIC_CARD_TYPE  ,    
                    VIC_CONTROL_NUMBER   ,    
                    VIC_INS_DATE   ,         
                    VIC_INS_USER ,
					vic_max_seqno )
        VALUES
                (p_prod_code_in,
                p_prod_catg_in,
                1,
                sysdate,
                1,
				0);
      EXCEPTION
		WHEN DUP_VAL_ON_INDEX THEN
			Null;
        WHEN OTHERS THEN
            l_error_msg:=' Error while inserting VMS_INVENTORY_CONTROL '||substr(sqlerrm,1,200);     
            l_proc_stat := 'E';
            return;
      END;
      
      get_ranges (p_prod_prefix_in,
                  p_prod_sufix_in,
                  P_start_range_in,
                  P_end_range_in,
                  c_card_ranges);

      LOOP
         FETCH c_card_ranges
         INTO l_prod_prefix, l_cardrange_from, l_cardrange_to;

         EXIT WHEN c_card_ranges%NOTFOUND;
         l_pin_loop_count := l_pin_loop_count + l_cardrange_to - l_cardrange_from + 1;
         generate_serial_numbers (p_inst_code_in,
                                  p_prod_code_in,
                                  p_prod_catg_in,
                                  l_prod_prefix,
                                  l_cardrange_from,
                                  l_cardrange_to,
                                  l_serl_no,
                                  l_error_msg);

         IF l_error_msg <> 'OK'
         THEN
            l_error_msg :=
               'Error From generate_serial_numbers: ' || l_error_msg;
            l_proc_stat := 'E';
            EXIT;
         END IF;

         IF l_serl_no IS NOT NULL
         THEN
            generate_cards (p_inst_code_in,
                            p_user_code_in,
                            p_prod_code_in,
                            p_prod_catg_in,
                            l_prod_prefix,
                            l_serl_no,
                            l_error_msg);

            IF l_error_msg <> 'OK'
            THEN
               l_proc_stat := 'E';
               EXIT;
            END IF;
         END IF;
      END LOOP;

      BEGIN
          SELECT cpc_product_id,
                 cpc_profile_code
            INTO l_product_id,
                 l_profile_code
            FROM cms_prod_cattype
           WHERE cpc_inst_code = p_inst_code_in
             AND cpc_prod_code = p_prod_code_in
             AND cpc_card_type = p_prod_catg_in;
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
               l_error_msg :=
                  'Error while selecting product type:'
                  || SUBSTR (SQLERRM, 1, 200);
         END;

      BEGIN
          IF l_prod_type = 'V' THEN
              SELECT COUNT(1) 
                INTO l_count_prodid
                FROM vms_prodid_pin_cntrl
               WHERE vpp_product_id = l_product_id;

                IF l_count_prodid = 0 THEN
                   INSERT INTO vms_prodid_pin_cntrl(VPP_INST_CODE,
                                                    VPP_PRODUCT_ID,
                                                    VPP_CNTRL_NO,
                                                    VPP_INS_USER,
                                                    VPP_INS_DATE)
                                            VALUES (1,
                                                    l_product_id,
                                                    1,
                                                    1,
                                                    SYSDATE);
                  FOR i in 1..l_pin_loop_count
                  LOOP
                     DBMS_RANDOM.seed (val => TO_CHAR(SYSTIMESTAMP,'YYYYDDMMHH24MISSFFFF'));
                     INSERT INTO vms_shfl_pinno (vsp_inst_code,
                                                 vsp_product_id,
                                                 vsp_shfl_cntrl,
                                                 vsp_pin_numb,
                                                 vsp_ins_user,
                                                 vsp_ins_date
                                                    )
                          VALUES (1,
                                  l_product_id,
                                  i,
                                  lpad(SEQ_PINNO.NEXTVAL,3,0) || TRUNC(DBMS_RANDOM.value(low => 1000000, high => 9999999)),
                                  1,
                                  SYSDATE);
                  END LOOP;
                END IF;

                IF l_error_msg <> 'OK'
                THEN
                    l_error_msg :=
                       'Error while generating shuffle proxy numbers: ' || l_error_msg;
                    l_proc_stat := 'E';
                END IF;                                     
          END IF;      
      END;

      SELECT COUNT (*),
			 SUM(DECODE(CAP_ISSUE_STAT,'N',1,0)) 
	  into l_gen_cards,l_avail_cards
                      FROM cms_appl_pan_inv
                     WHERE cap_prod_code = p_prod_code_in
                           AND cap_card_type = p_prod_catg_in;

      UPDATE vms_pangen_summary
         SET vps_process_msg = l_error_msg,
             vps_process_status = l_proc_stat,
             vps_pending_cards =vps_total_cards - l_gen_cards,
              vps_avail_cards= l_avail_cards
       WHERE vps_prod_code = p_prod_code_in
             AND vps_card_type = p_prod_catg_in;

      COMMIT;
   END generate_inventory;

   PROCEDURE generate_cards (p_inst_code_in     IN     NUMBER,
                             p_user_code_in     IN     NUMBER,
                             p_prod_code_in     IN     VARCHAR2,
                             p_prod_catg_in     IN     NUMBER,
                             p_prod_prefix_in   IN     VARCHAR2,
                             p_stock_cnt_in     IN     shuffle_array_typ,
                             p_err_msg_out      OUT    VARCHAR2)
   AS
      l_file_name            cms_caf_info_temp.cci_file_name%TYPE
                                := TO_CHAR (SYSDATE, 'YYYYMMDDHH24MISS') || '.txt';
      l_grpcode              cms_cust_group.ccg_group_code%TYPE;
      l_acct_type            cms_acct_type.cat_type_code%TYPE;
      l_acct_stat            cms_acct_stat.cas_stat_code%TYPE;
      l_cntry_code           gen_cntry_mast.gcm_cntry_code%TYPE;
      l_state_code           gen_state_mast.gsm_state_code%TYPE;
      l_display_name         cms_prod_cattype.cpc_startercard_dispname%TYPE;
      l_serl_flag            cms_prod_cattype.cpc_serl_flag%TYPE;
      l_profile_code         cms_prod_cattype.cpc_profile_code%TYPE;
      l_bin                  cms_prod_bin.cpb_inst_bin%TYPE;
      l_fiid                 cms_bin_fiid.cbf_fiid%TYPE;
      l_catg_code            cms_prod_mast.cpm_catg_code%TYPE;
      l_catg_appl            cms_appl_mast.cam_appl_code%TYPE;
      l_partner_id           cms_product_param.cpp_partner_id%TYPE;
      l_cust_code            cms_cust_mast.ccm_cust_code%TYPE;
      l_addr_code            cms_addr_mast.cam_addr_code%TYPE;
      l_acct_no              cms_acct_mast.cam_acct_no%TYPE;
      l_acct_id              cms_acct_mast.cam_acct_id%TYPE;
      l_appl_code            cms_appl_mast.cam_appl_code%TYPE;
      l_temp_acct            cms_acct_mast.cam_acct_no%TYPE;
      l_tbl_acct_construct   pkg_stock.table_acct_construct;
      l_tbl_panconstruct     pkg_stock.table_pan_construct;
      l_tmp_pan              cms_appl_pan.cap_pan_code%TYPE;
      l_hash_pan             cms_appl_pan.cap_pan_code%TYPE;
      l_serial_no            PLS_INTEGER;
      l_max_length           PLS_INTEGER;
      l_acctserial_index     PLS_INTEGER;
      l_panserial_indx       PLS_INTEGER;
      l_counter              PLS_INTEGER := 0;
      l_chk_digit            PLS_INTEGER := 0;
      l_cust_catg            cms_prod_ccc.cpc_cust_catg%TYPE;
      l_user_identify_type   cms_prod_cattype.cpc_user_identify_type%type;
      l_encrypt_enable       cms_prod_cattype.cpc_encrypt_enable%TYPE;
      L_ENCR_DUMMY           cms_addr_mast.CAM_PIN_CODE%type;
      l_encr_first_name      cms_cust_mast.CCM_FIRST_NAME%type;
      exp_reject_request     EXCEPTION;
   BEGIN
      p_err_msg_out := 'OK';

      BEGIN
      	SELECT nvl(vic_max_seqno,0) + 1 INTO l_card_seq FROM VMS_INVENTORY_CONTROL
		WHERE VIC_PROD_CODE = p_prod_code_in
		AND VIC_CARD_TYPE = p_prod_catg_in;
      EXCEPTION
      	WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while selecting max sequence number:'
               || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;
      BEGIN
         SELECT cattype.cpc_startercard_dispname,
                cattype.cpc_profile_code,
                prod.cpm_catg_code,
                cattype.cpc_serl_flag,
                cattype.cpc_encrypt_enable,
                cattype.cpc_user_identify_type
           INTO l_display_name,
                l_profile_code,
                l_catg_code,
                l_serl_flag,
                l_encrypt_enable,
                l_user_identify_type
           FROM cms_prod_cattype cattype, cms_prod_mast prod
          WHERE cattype.cpc_prod_code = p_prod_code_in
                AND cattype.cpc_card_type = p_prod_catg_in
                AND cattype.cpc_inst_code = p_inst_code_in
                AND prod.cpm_inst_code = cattype.cpc_inst_code
                AND prod.cpm_prod_code = cattype.cpc_prod_code;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            p_err_msg_out :=
                  'Profile code not defined for product code- '
               || p_prod_code_in
               || ' and card type - '
               || p_prod_catg_in;
            RAISE exp_reject_request;
         WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while selecting product catg dtls:'
               || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;
      BEGIN
        SELECT CPC_CUST_CATG
        INTO   l_CUST_CATG
        FROM CMS_PROD_CCC
        WHERE CPC_PROD_CODE=P_PROD_CODE_IN
        AND CPC_CARD_TYPE=P_PROD_CATG_IN
        AND CPC_INST_CODE=P_INST_CODE_IN and rownum=1;
      EXCEPTION
       WHEN NO_DATA_FOUND
         THEN
          BEGIN
              SELECT CCC_CATG_CODE
              INTO   l_CUST_CATG
              FROM CMS_CUST_CATG
              where CCC_CATG_SNAME='DEF'
              AND CCC_INST_CODE=P_INST_CODE_IN;
              exception
          WHEN OTHERS
         THEN
             L_CUST_CATG:=1;
             end;
         WHEN OTHERS
         THEN
            P_ERR_MSG_OUT :=
               'Error while selecting customer catg dtls:'
               || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;

      BEGIN
         SELECT prodbin.cpb_inst_bin, fiid.cbf_fiid
           INTO l_bin, l_fiid
           FROM cms_prod_bin prodbin, cms_bin_fiid fiid
          WHERE     prodbin.cpb_inst_code = p_inst_code_in
                AND prodbin.cpb_prod_code = p_prod_code_in
                AND fiid.cbf_inst_code = prodbin.cpb_inst_code
                AND fiid.cbf_bin = prodbin.cpb_inst_bin;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while selecting prod-bin dtls:'
               || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;

      IF l_display_name IS NULL
      THEN
         BEGIN
            SELECT cbm_interchange_code
              INTO l_display_name
              FROM cms_bin_mast
             WHERE cbm_inst_bin = l_bin AND cbm_inst_code = p_inst_code_in;

            IF l_display_name IS NULL
            THEN
               l_display_name := 'No Record for the selected Bin';
            ELSE
               IF l_display_name = 'M'
               THEN
                  l_display_name := 'INSTANT MASTERCARD';
               ELSIF l_display_name = 'V'
               THEN
                  l_display_name := 'INSTANT VISA CARD';
               ELSE
                  l_display_name := 'No Record for the selected Bin';
               END IF;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               p_err_msg_out :=
                  'Error while selecting bin dtls:'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_request;
         END;
      END IF;

      BEGIN
         SELECT cpp_partner_id
           INTO l_partner_id
           FROM cms_product_param
          WHERE cpp_prod_code = p_prod_code_in
                AND cpp_inst_code = p_inst_code_in;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            p_err_msg_out :=
                  'Product code '
               || p_prod_code_in
               || ' is not defined in the product param master';
            RAISE exp_reject_request;
         WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while selecting partner dtls: '
               || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;

      SELECT MIN (ccg_group_code)
        INTO l_grpcode
        FROM cms_cust_group
       WHERE ccg_inst_code = p_inst_code_in;

      IF l_grpcode IS NULL
      THEN
         l_grpcode := l_const;

         BEGIN
            INSERT INTO cms_cust_group (ccg_inst_code,
                                        ccg_group_code,
                                        ccg_group_desc,
                                        ccg_ins_user,
                                        ccg_ins_date,
                                        ccg_lupd_user,
                                        ccg_lupd_date)
                 VALUES (p_inst_code_in,
                         l_grpcode,
                         'DEFAULT GROUP',
                         p_user_code_in,
                         SYSDATE,
                         p_user_code_in,
                         SYSDATE);
         EXCEPTION
            WHEN OTHERS
            THEN
               p_err_msg_out :=
                  'Error while inserting customer group:'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_request;
         END;
      END IF;

      BEGIN
         SELECT gcm_cntry_code
           INTO l_cntry_code
           FROM gen_cntry_mast
          WHERE gcm_curr_code =
                   (SELECT cip_param_value
                      FROM cms_inst_param
                     WHERE cip_inst_code = p_inst_code_in
                           AND cip_param_key = 'CURRENCY')
                AND gcm_inst_code = p_inst_code_in;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while selecting cntry_code:'
               || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;

      BEGIN
         SELECT gsm_state_code
           INTO l_state_code
           FROM gen_state_mast
          WHERE     gsm_switch_state_code = l_state_data
                AND gsm_inst_code = p_inst_code_in
                AND gsm_cntry_code = l_cntry_code;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while inserting selecting state code:'
               || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;

      BEGIN
         FOR i
            IN (  SELECT cac_profile_code,
                         cac_field_name,
                         cac_start_from,
                         cac_length,
                         cac_start,
                         cac_tot_length
                    FROM cms_acct_construct
                   WHERE cac_profile_code = l_profile_code
                         AND cac_inst_code = p_inst_code_in
                ORDER BY cac_start_from DESC)
         LOOP
            l_counter := l_counter + 1;
            l_tbl_acct_construct (l_counter).cac_profile_code :=
               i.cac_profile_code;
            l_tbl_acct_construct (l_counter).cac_field_name :=
               i.cac_field_name;
            l_tbl_acct_construct (l_counter).cac_start_from :=
               i.cac_start_from;
            l_tbl_acct_construct (l_counter).cac_length := i.cac_length;
            l_tbl_acct_construct (l_counter).cac_start := i.cac_start;
            l_tbl_acct_construct (l_counter).cac_tot_length :=
               i.cac_tot_length;

            IF i.cac_field_name = 'Branch'
            THEN
               l_tbl_acct_construct (l_counter).cac_field_value :=
                  LPAD (SUBSTR (TRIM (l_fiid), i.cac_start, i.cac_length),
                        i.cac_length,
                        '0');
            ELSIF i.cac_field_name = 'Product Prefix'
            THEN
               l_tbl_acct_construct (l_counter).cac_field_value :=
                  LPAD (
                     SUBSTR (TRIM (p_prod_prefix_in),
                             i.cac_start,
                             i.cac_length),
                     i.cac_length,
                     '0');
            ELSIF i.cac_field_name = 'Check Digit'
            THEN
               l_chk_digit := 1;
            ELSIF i.cac_field_name = 'Serial Number'
            THEN
               l_acctserial_index := l_counter;
               l_max_length := i.cac_length;
            ELSE
               p_err_msg_out :=
                     'Account Number construct '
                  || i.cac_field_name
                  || ' not exist ';
               RAISE exp_reject_request;
            END IF;
         END LOOP;

         FOR i IN 1 .. l_tbl_acct_construct.COUNT
         LOOP
            FOR j IN 1 .. l_tbl_acct_construct.COUNT
            LOOP
               IF l_tbl_acct_construct (j).cac_start_from = i
                  AND l_tbl_acct_construct (j).cac_field_name <>
                         'Serial Number'
               THEN
                  l_temp_acct :=
                     l_temp_acct || l_tbl_acct_construct (j).cac_field_value;
                  EXIT;
               END IF;
            END LOOP;
         END LOOP;
      EXCEPTION
         WHEN exp_reject_request
         THEN
            RAISE;
         WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while get_temp_acct::' || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;

      BEGIN
         SELECT cat_type_code
           INTO l_acct_type
           FROM cms_acct_type
          WHERE cat_inst_code = p_inst_code_in
                AND cat_switch_type = l_seg31_typ;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while selecting accttype:' || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;

      BEGIN
         SELECT cas_stat_code
           INTO l_acct_stat
           FROM cms_acct_stat
          WHERE cas_inst_code = p_inst_code_in
                AND cas_switch_statcode = l_seg31_stat;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while selecting acctstat:' || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;

      BEGIN
         SELECT TO_CHAR (SYSDATE, 'yyyy') || cpc_catg_appl
           INTO l_catg_appl
           FROM cms_prod_catg
          WHERE cpc_inst_code = p_inst_code_in
                AND cpc_catg_code = l_catg_code;
      EXCEPTION
         WHEN OTHERS
         THEN
            p_err_msg_out :=
               'Error while selecting catg_appl:' || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;

      l_counter := 0;

      FOR i
         IN (SELECT cpc_profile_code,
                    cpc_field_name,
                    cpc_start_from,
                    cpc_length,
                    cpc_start
               FROM cms_pan_construct
              WHERE cpc_profile_code = l_profile_code
                    AND cpc_inst_code = p_inst_code_in)
      LOOP
         l_counter := l_counter + 1;
         l_tbl_panconstruct (l_counter).cpc_profile_code := i.cpc_profile_code;
         l_tbl_panconstruct (l_counter).cpc_field_name := i.cpc_field_name;
         l_tbl_panconstruct (l_counter).cpc_start_from := i.cpc_start_from;
         l_tbl_panconstruct (l_counter).cpc_length := i.cpc_length;
         l_tbl_panconstruct (l_counter).cpc_start := i.cpc_start;

         IF i.cpc_field_name = 'Card Type'
         THEN
            l_tbl_panconstruct (l_counter).cpc_field_value :=
               LPAD (
                  SUBSTR (TRIM (p_prod_catg_in), i.cpc_start, i.cpc_length),
                  i.cpc_length,
                  '0');
         ELSIF i.cpc_field_name = 'Branch'
         THEN
            l_tbl_panconstruct (l_counter).cpc_field_value :=
               LPAD (SUBSTR (TRIM (l_fiid), i.cpc_start, i.cpc_length),
                     i.cpc_length,
                     '0');
         ELSIF i.cpc_field_name = 'BIN / PREFIX'
         THEN
            l_tbl_panconstruct (l_counter).cpc_field_value :=
               LPAD (SUBSTR (TRIM (l_bin), i.cpc_start, i.cpc_length),
                     i.cpc_length,
                     '0');
         ELSIF i.cpc_field_name = 'PAN Product Category Prefix'
         THEN
            l_tbl_panconstruct (l_counter).cpc_field_value :=
               LPAD (
                  SUBSTR (TRIM (p_prod_prefix_in), i.cpc_start, i.cpc_length),
                  i.cpc_length,
                  '0');
         ELSIF i.cpc_field_name = 'Serial Number'
         THEN
            l_panserial_indx := l_counter;
         ELSE
            p_err_msg_out :=
               'PAN construct ' || i.cpc_field_name || ' not exist ';
            RAISE exp_reject_request;
         END IF;
      END LOOP;

      FOR l_idx IN 1 .. p_stock_cnt_in.COUNT
      LOOP
         BEGIN
                  IF L_ENCRYPT_ENABLE = 'Y' THEN
                      l_encr_first_name := fn_emaps_main(l_display_name);
                      l_ENCR_DUMMY := fn_emaps_main(l_dummy);
                   else
                      l_encr_first_name := l_display_name;
                      l_ENCR_DUMMY := l_dummy;
      END IF;
            BEGIN
               SELECT seq_custcode.NEXTVAL INTO l_cust_code FROM DUAL;

               INSERT INTO cms_cust_mast (ccm_inst_code,
                                          ccm_cust_code,
                                          ccm_group_code,
                                          ccm_cust_type,
                                          ccm_cust_stat,
                                          ccm_salut_code,
                                          ccm_first_name,
                                          ccm_last_name,
                                          ccm_birth_date,
                                          ccm_gender_type,
                                          ccm_ins_user,
                                          ccm_lupd_user,
                                          ccm_cust_id,
                                          ccm_partner_id,
                                          ccm_prod_code,
                                          ccm_card_type,
										  CCM_FIRST_NAME_ENCR, 
                                          CCM_LAST_NAME_ENCR)
                    VALUES (p_inst_code_in,
                            l_cust_code,
                            l_grpcode,
                            l_const,
                            'Y',
                            l_dummy,
                            l_encr_first_name,
                            ' ',
                            TO_DATE ('01-JAN-1900', 'DD-MON-YYYY'),
                            'M',
                            p_user_code_in,
                            p_user_code_in,
                            seq_cust_id.NEXTVAL,
                            l_partner_id,
                            p_prod_code_in,
                            p_prod_catg_in,
							fn_emaps_main(l_display_name),
                            fn_emaps_main(' '));
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_msg_out :=
                     'Error while inserting customer dtls:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RAISE exp_reject_request;
            END;

            BEGIN
               SELECT seq_addr_code.NEXTVAL INTO l_addr_code FROM DUAL;

               INSERT INTO cms_addr_mast (cam_inst_code,
                                          cam_cust_code,
                                          cam_addr_code,
                                          cam_add_one,
                                          cam_add_two,
                                          cam_add_three,
                                          cam_pin_code,
                                          cam_cntry_code,
                                          cam_city_name,
                                          cam_addr_flag,
                                          cam_state_code,
                                          cam_ins_user,
                                          cam_lupd_user,
                                          cam_comm_type,
                                          cam_state_switch,
										  CAM_ADD_ONE_ENCR,
                                          CAM_ADD_TWO_ENCR,
                                          CAM_CITY_NAME_ENCR,
                                          CAM_PIN_CODE_ENCR)
                    VALUES (p_inst_code_in,
                            l_cust_code,
                            l_addr_code,
                            l_ENCR_DUMMY,
                            l_ENCR_DUMMY,
                            l_ENCR_DUMMY,
                            l_ENCR_DUMMY,
                            l_cntry_code,
                            l_ENCR_DUMMY,
                            'P',
                            l_state_code,
                            p_user_code_in,
                            p_user_code_in,
                            'R',
                            l_state_data,
							fn_emaps_main(l_dummy),
                            fn_emaps_main(l_dummy),
                            fn_emaps_main(l_dummy),
                            fn_emaps_main(l_dummy)
                            );
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_msg_out :=
                     'Error while inserting address dtls:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RAISE exp_reject_request;
            END;

            get_acct_srno (p_inst_code_in,
                           l_temp_acct,
                           l_max_length,
                           l_serial_no,
                           p_err_msg_out);

            IF p_err_msg_out <> 'OK'
            THEN
               p_err_msg_out := 'Error from get_acct_srno :' || p_err_msg_out;
               RAISE exp_reject_request;
            END IF;

            l_tbl_acct_construct (l_acctserial_index).cac_field_value :=
               LPAD (
                  SUBSTR (
                     TRIM (l_serial_no),
                     l_tbl_acct_construct (l_acctserial_index).cac_start,
                     l_tbl_acct_construct (l_acctserial_index).cac_length),
                  l_tbl_acct_construct (l_acctserial_index).cac_length,
                  '0');
            l_acct_no := NULL;

            FOR i IN 1 .. l_tbl_acct_construct.COUNT
            LOOP
               FOR j IN 1 .. l_tbl_acct_construct.COUNT
               LOOP
                  IF l_tbl_acct_construct (j).cac_start_from = i
                  THEN
                     l_acct_no :=
                        l_acct_no || l_tbl_acct_construct (j).cac_field_value;
                     EXIT;
                  END IF;
               END LOOP;
            END LOOP;

            IF l_chk_digit = 1
            THEN
               l_acct_no := l_acct_no || get_chkdig (l_acct_no);
            END IF;

            BEGIN
               SELECT seq_acct_id.NEXTVAL INTO l_acct_id FROM DUAL;

               INSERT INTO cms_acct_mast (cam_inst_code,
                                          cam_acct_id,
                                          cam_acct_no,
                                          cam_hold_count,
                                          cam_curr_bran,
                                          cam_bill_addr,
                                          cam_type_code,
                                          cam_stat_code,
                                          cam_prod_code,
                                          cam_card_type,
                                          cam_ins_user,
                                          cam_lupd_user)
                    VALUES (p_inst_code_in,
                            l_acct_id,
                            l_acct_no,
                            l_const,
                            l_fiid,
                            l_addr_code,
                            l_acct_type,
                            l_acct_stat,
                            p_prod_code_in,
                            p_prod_catg_in,
                            p_user_code_in,
                            p_user_code_in);
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_msg_out :=
                     'Error while inserting acct dtls:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RAISE exp_reject_request;
            END;

            BEGIN
               INSERT INTO cms_cust_acct (cca_inst_code,
                                          cca_cust_code,
                                          cca_acct_id,
                                          cca_hold_posn,
                                          cca_rel_stat,
                                          cca_ins_user,
                                          cca_lupd_user)
                    VALUES (p_inst_code_in,
                            l_cust_code,
                            l_acct_id,
                            l_const,
                            'Y',
                            p_user_code_in,
                            p_user_code_in);
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_msg_out :=
                     'Error while inserting cust-acct dtls:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RAISE exp_reject_request;
            END;

            BEGIN
               SELECT l_catg_appl || LPAD (seq_appl_code.NEXTVAL, 8, 0)
                 INTO l_appl_code
                 FROM DUAL;

               INSERT INTO cms_appl_mast (cam_inst_code,
                                          cam_asso_code,
                                          cam_inst_type,
                                          cam_appl_code,
                                          cam_appl_date,
                                          cam_reg_date,
                                          cam_cust_code,
                                          cam_appl_bran,
                                          cam_prod_code,
                                          cam_card_type,
                                          cam_cust_catg,
                                          cam_active_date,
                                          cam_expry_date,
                                          cam_disp_name,
                                          cam_limit_amt,
                                          cam_addon_issu,
                                          cam_tot_acct,
                                          cam_addon_stat,
                                          cam_addon_link,
                                          cam_bill_addr,
                                          cam_appl_stat,
                                          cam_appl_user,
                                          cam_lupd_user,
                                          cam_ins_date,
                                          cam_ins_user)
                    VALUES (p_inst_code_in,
                            l_const,
                            l_const,
                            l_appl_code,
                            SYSDATE,
                            SYSDATE,
                            l_cust_code,
                            l_fiid,
                            p_prod_code_in,
                            p_prod_catg_in,
                            l_CUST_CATG,                              --custcatg_code
                            SYSDATE,
                            NULL,                                  --exprydate
                            l_encr_first_name,
                            0,
                            'N',
                            l_const,
                            'P',
                            l_appl_code,
                            l_addr_code,
                            l_appl_status,
                            p_user_code_in,
                            p_user_code_in,
                            SYSDATE,
                            p_user_code_in);
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_msg_out :=
                     'Error while inserting appl dtls:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RAISE exp_reject_request;
            END;

            BEGIN
               INSERT INTO cms_appl_det (cad_inst_code,
                                         cad_appl_code,
                                         cad_acct_id,
                                         cad_acct_posn,
                                         cad_ins_user,
                                         cad_lupd_user)
                    VALUES (p_inst_code_in,
                            l_appl_code,
                            l_acct_id,
                            l_const,
                            p_user_code_in,
                            p_user_code_in);
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_msg_out :=
                     'Error while inserting appl detls:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RAISE exp_reject_request;
            END;

            BEGIN
               INSERT INTO cms_caf_info_entry (cci_file_name,
                                               cci_row_id,
                                               cci_inst_code,
                                               cci_pan_code,
                                               cci_crd_typ,
                                               cci_fiid,
                                               cci_seg12_name_line1,
                                               cci_seg12_name_line2,
                                               cci_seg12_addr_line1,
                                               cci_seg12_addr_line2,
                                               cci_seg12_city,
                                               cci_seg12_state,
                                               cci_seg12_postal_code,
                                               cci_seg12_country_code,
                                               cci_ins_user,
                                               cci_ins_date,
                                               cci_lupd_date,
                                               cci_cust_catg,
                                               cci_prod_code,
                                               cci_card_type,
                                               cci_appl_code,
                                               cci_upld_stat,
                                               cci_approved,
											   CCI_SEG12_NAME_LINE1_ENCR,
                                               CCI_SEG12_NAME_LINE2_ENCR, 
                                               CCI_SEG12_ADDR_LINE1_ENCR, 
                                               CCI_SEG12_ADDR_LINE2_ENCR, 
                                               CCI_SEG12_CITY_ENCR, 	  	
                                               CCI_SEG12_POSTAL_CODE_ENCR
                                               )
                    VALUES (l_file_name,
                            seq_dirupld_rowid.NEXTVAL,
                            p_inst_code_in,
                            l_bin,
                            NULL,                                  --prod_b24,
                            l_fiid,
                            l_encr_first_name,
                            L_ENCR_DUMMY,
                            L_ENCR_DUMMY,
                            L_ENCR_DUMMY,
                            L_ENCR_DUMMY,
                            l_state_data,
                            L_ENCR_DUMMY,
                            l_cntry_code,
                            p_user_code_in,
                            SYSDATE,
                            SYSDATE,
                            NULL,                                   --custcatg
                            p_prod_code_in,
                            p_prod_catg_in,
                            l_appl_code,
                            'P',
                            'A',
							fn_emaps_main(l_display_name),
                            fn_emaps_main(l_dummy),
                            fn_emaps_main(l_dummy),
                            fn_emaps_main(l_dummy),
                            fn_emaps_main(l_dummy),
                            fn_emaps_main(l_dummy)
                            );
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_msg_out :=
                     'Error while inserting into caf_info_entry:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RAISE exp_reject_request;
            END;

            l_serial_no := NULL;
            get_pan_srno (p_inst_code_in,
                          p_prod_code_in,
                          p_prod_catg_in,
                          p_prod_prefix_in,
                          l_serl_flag,
                          l_serial_no,
                          p_err_msg_out);

            IF p_err_msg_out <> 'OK'
            THEN
               RAISE exp_reject_request;
            END IF;

            l_tbl_panconstruct (l_panserial_indx).cpc_field_value :=
               LPAD (
                  SUBSTR (TRIM (l_serial_no),
                          l_tbl_panconstruct (l_panserial_indx).cpc_start,
                          l_tbl_panconstruct (l_panserial_indx).cpc_length),
                  l_tbl_panconstruct (l_panserial_indx).cpc_length,
                  '0');

            l_tmp_pan := NULL;

            FOR i IN 1 .. l_tbl_panconstruct.COUNT
            LOOP
               FOR j IN 1 .. l_tbl_panconstruct.COUNT
               LOOP
                  IF l_tbl_panconstruct (j).cpc_start_from = i
                  THEN
                     l_tmp_pan :=
                        l_tmp_pan || l_tbl_panconstruct (j).cpc_field_value;
                     EXIT;
                  END IF;
               END LOOP;
            END LOOP;

            l_tmp_pan := l_tmp_pan || get_chkdig (l_tmp_pan);
            l_hash_pan := gethash (l_tmp_pan);

            BEGIN
               INSERT INTO cms_appl_pan_inv (cap_appl_code,
                                             cap_prod_code,
                                             cap_prod_catg,
                                             cap_card_type,
                                             cap_cust_catg,
                                             cap_pan_code,
                                             cap_cust_code,
                                             cap_acct_id,
                                             cap_acct_no,
                                             cap_bill_addr,
                                             cap_appl_bran,
                                             cap_ins_date,
                                             cap_ins_user,
                                             cap_pan_code_encr,
                                             cap_mask_pan,
                                             cap_prod_prefix,
                                             cap_card_seq,
                                             cap_issue_stat,
                                              cap_user_identify_type)
                    VALUES (l_appl_code,
                            p_prod_code_in,
                            l_catg_code,
                            p_prod_catg_in,
                            NULL,                                   --custcatg
                            l_hash_pan,
                            l_cust_code,
                            l_acct_id,
                            l_acct_no,
                            l_addr_code,
                            l_fiid,
                            SYSDATE,
                            p_user_code_in,
                            fn_emaps_main (l_tmp_pan),
                            fn_getmaskpan (l_tmp_pan),
                            p_prod_prefix_in,
                            l_card_seq,
                            --seq_card_order.NEXTVAL,
                            'N',
                            l_user_identify_type);
                            
                            l_card_seq:=l_card_seq+1;
                            
            EXCEPTION
               WHEN OTHERS
               THEN
                  p_err_msg_out :=
                     'Error while inserting PAN detls:'
                     || SUBSTR (SQLERRM, 1, 200);
                  RAISE exp_reject_request;
            END;
         EXCEPTION
            WHEN exp_reject_request
            THEN
               RAISE;
            WHEN OTHERS
            THEN
               p_err_msg_out :=
                  'Error in Bulk Cards Loop:' || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_request;
         END;

         COMMIT;
      END LOOP;
   	BEGIN
	   UPDATE VMS_INVENTORY_CONTROL
	   	SET vic_max_seqno = l_card_seq - 1
	   WHERE VIC_PROD_CODE = p_prod_code_in
		AND VIC_CARD_TYPE = p_prod_catg_in;
	EXCEPTION
	 WHEN OTHERS THEN
            p_err_msg_out :=
               'Error while updating max sequence number:'
               || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_request;
      END;
   EXCEPTION
      WHEN exp_reject_request
      THEN
         ROLLBACK;
      WHEN OTHERS
      THEN
         ROLLBACK;
         p_err_msg_out := 'Main Excp:' || SUBSTR (SQLERRM, 1, 200);
   END generate_cards;

   PROCEDURE inventory_job
   IS
   BEGIN
      FOR l_idx IN (SELECT *
                      FROM vms_pangen_summary
                     WHERE vps_process_status IN ('P', 'E'))
      LOOP
         generate_inventory (l_const,
                             l_const,
                             l_idx.vps_prod_code,
                             l_idx.vps_card_type,
                             l_idx.vps_subbin_from,
                             l_idx.vps_subbin_to,
                             l_idx.vps_start_range,
                             l_idx.vps_end_range);
      END LOOP;
   END inventory_job;

PROCEDURE log_consumed_status_change(
    p_inst_code_in       IN NUMBER,
    p_card_number_in   IN VARCHAR2,
    p_tran_date_in       IN VARCHAR2,
    p_tran_time_in       IN VARCHAR2,
    p_updted_cardstat_in IN VARCHAR2,
	p_delivery_channel in varchar2 ,
    p_updated_count OUT NUMBER
   )
IS
  /*************************************************************************************************************
  * Created Date     : 12-OCT-2017
  * Created By       : dhinakaran B
  * Reason     : FSS-5225( Change the card status to "Consumed" if transaction has decline with card status in InActive.)
  *************************************************************************************************************/
  l_inactive_Cardstat CMS_APPL_PAN.cap_card_stat%TYPE := '0';
  l_ccs_tran_code cms_card_stat.ccs_tran_code%TYPE;
  l_cap_active_date CMS_APPL_PAN.cap_active_date%TYPE;
  l_AUTH_ID transactionlog.auth_id%TYPE;
  l_hash_pan cms_appl_pan.cap_pan_code%TYPE;
  l_encr_pan cms_appl_pan.cap_pan_code_encr%TYPE;
  l_ERR_MSG  VARCHAR2(100);
  l_RESP_CDE VARCHAR2(10);
  l_reason_desc cms_spprt_reasons.csr_reasondesc%type;
  l_channel_desc cms_delchannel_mast.cdm_channel_desc%type;
  l_reason_cde cms_inst_param.cip_param_value%type;

  exp_reject_record exception;
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  BEGIN
    l_hash_pan := gethash (p_card_number_in);
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RETURN;
END;
  BEGIN
    l_encr_pan := fn_emaps_main (p_card_number_in);
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RETURN;
  END;
  BEGIN
    UPDATE cms_appl_pan
    SET cap_card_stat   = p_updted_cardstat_in
    WHERE cap_inst_code = p_inst_code_in
    AND cap_pan_code    = l_hash_pan
    and cap_active_date is null and cap_repl_flag = 0;

    p_updated_count := SQL%ROWCOUNT;
    IF   p_updated_count   = 1 THEN
      SELECT ccs_tran_code
      INTO l_ccs_tran_code
      FROM cms_card_stat
      WHERE ccs_stat_code=p_updted_cardstat_in;
   --   SELECT LPAD (SEQ_AUTH_ID.NEXTVAL, 6, '0') INTO l_AUTH_ID FROM DUAL;
      l_AUTH_ID:=LPAD (SEQ_AUTH_ID.NEXTVAL, 6, '0');
      if p_delivery_channel is not null then

         select cdm_channel_desc into l_channel_desc from cms_delchannel_mast where cdm_channel_code=p_delivery_channel;

         if p_delivery_channel <> '16' then 

             select cip_param_value,replace(csr_reasondesc,'{del_channel}',l_channel_desc) into l_reason_cde,l_reason_desc from  cms_inst_param,cms_spprt_reasons  where cip_param_key='CONSUMED' 
            and cip_param_value=csr_spprt_rsncode   and cip_inst_code=1;

        else 
             select cip_param_value,'Inactive Provision' into l_reason_cde,l_reason_desc from  cms_inst_param,cms_spprt_reasons  where cip_param_key='CONSUMED' 
            and cip_param_value=csr_spprt_rsncode   and cip_inst_code=1;

          end if;
      end if;



      sp_log_cardstat_chnge (p_inst_code_in, l_hash_pan, l_encr_pan, l_AUTH_ID, l_ccs_tran_code, '', p_tran_date_in, p_tran_time_in, l_RESP_CDE, l_err_msg,'',l_reason_cde,l_reason_desc);
      if l_err_msg<>'OK' then
          raise exp_reject_record;
      end if;
      COMMIT;
    ELSE
  COMMIT;
     --ROLLBACK;
     -- RETURN;
    END IF;
  EXCEPTION
  when exp_reject_record then
      rollback;
      return;
  WHEN OTHERS THEN
    ROLLBACK;
    RETURN;
  END;
EXCEPTION
WHEN OTHERS THEN
  ROLLBACK;
  RETURN;
END;

PROCEDURE get_pan_srno (p_inst_code_in      IN     NUMBER,
                           p_prod_code_in      IN     VARCHAR2,
                           p_prod_catg_in      IN     NUMBER,
                           p_prod_prefix_in    IN     VARCHAR2,
                           p_prod_sufix_in     IN     VARCHAR2,
                           p_start_range_in    IN     VARCHAR2,
                           p_end_range_in      IN     VARCHAR2,
                           p_serl_flag         IN     NUMBER,
                           p_prod_prefix_out      OUT VARCHAR2,
                           p_serial_no_out        OUT VARCHAR2,
                           p_err_msg_out          OUT VARCHAR2)
   AS
      c_card_ranges      SYS_REFCURSOR;
      l_prod_prefix      cms_prod_cattype.cpc_prod_prefix%TYPE;
      l_cardrange_from   cms_prod_cattype.cpc_start_card_no%TYPE;
      l_cardrange_to     cms_prod_cattype.cpc_end_card_no%TYPE;
      l_max_serlno       vms_pan_ctrl_inv.vpc_max_serlno%TYPE;
      l_serlno           vms_pan_ctrl_inv.vpc_ctrl_numb%TYPE;
      l_ctrl_numb        vms_pan_ctrl_inv.vpc_ctrl_numb%TYPE;
      l_errmsg           VARCHAR2 (1000);
      l_starter_card     cms_prod_cattype.cpc_starter_card%TYPE; 

/*************************************************

     * Modified By      : Ubaidur Rahman H
     * Modified Date    : 29-AUG-2019
     * Purpose          : VMS-1084 (Pan genaration process from sequential to shuffled - B2B and Retail)
     * Reviewer         : Saravanakumar A
     * Release Number   : VMSGPRHOSTR20_B1    

	 * Modified By      : Ubaidur Rahman H
     * Modified Date    : 13-SEP-2019
     * Purpose          : VMS-1114 PAN generation logic change sequential to shuffled 
										for existing sequential product categories - For GPR
     * Reviewer         : Saravanakumar A
     * Release Number   : VMSGPRHOSTR20_B4
*************************************************/       

   BEGIN
      l_errmsg := 'OK';

        BEGIN                                        --- Modified for VMS-1114
           SELECT CPC_STARTER_CARD
             INTO l_starter_card
             FROM CMS_PROD_CATTYPE
            WHERE CPC_INST_CODE = p_inst_code_in
              AND CPC_PROD_CODE = p_prod_code_in
              AND CPC_CARD_TYPE = p_prod_catg_in;

         EXCEPTION
            WHEN OTHERS
            THEN
               l_errmsg :=
                  'Error while selecting the starter card: '
                  || SUBSTR (SQLERRM, 1, 200);   
            RETURN; 		              
         END;




      vmscard.get_ranges (p_prod_prefix_in,
                          p_prod_sufix_in,
                          p_start_range_in,
                          p_end_range_in,
                          c_card_ranges);

      LOOP

         FETCH c_card_ranges
         INTO l_prod_prefix, l_cardrange_from, l_cardrange_to;

         EXIT WHEN c_card_ranges%NOTFOUND;
         l_errmsg := 'OK';
         BEGIN
            SELECT vpc_ctrl_numb, vpc_max_serlno
              INTO l_serlno, l_max_serlno
              FROM vms_pan_ctrl_inv
             WHERE     vpc_inst_code = p_inst_code_in
                   AND vpc_prod_code = p_prod_code_in
                   AND vpc_prod_catg = p_prod_catg_in
                   AND to_number(vpc_prod_prefix) = to_number(l_prod_prefix);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               generate_serial_numbers (p_inst_code_in,
                                        p_prod_code_in,
                                        p_prod_catg_in,
                                        l_prod_prefix,
                                        p_serl_flag,
                                        l_cardrange_from,
                                        l_cardrange_to,
                                        'Y',
                                        l_starter_card,
                                        l_errmsg);

               IF l_errmsg <> 'OK'
               THEN
                  l_errmsg := 'Error while generation serials-' || l_errmsg;
                  EXIT;
               END IF;

               IF l_cardrange_from = 0
               THEN
                  l_cardrange_from := 1;
                  l_cardrange_to := l_cardrange_to + 1;
               END IF;

               l_serlno := l_cardrange_from;
               l_max_serlno := l_cardrange_to;




            WHEN OTHERS
            THEN
               l_errmsg :=
                  'Error while selecting current Serial : '
                  || SUBSTR (SQLERRM, 1, 200);
               EXIT;
         END;

         IF l_serlno > l_max_serlno
         THEN
            l_errmsg := 'Maximum serial number reached';
            CONTINUE;
         END IF;

          IF p_serl_flag = 0 AND l_starter_card = 'Y'           --- Modified for VMS-1114
          THEN 

            generate_serial_numbers (p_inst_code_in,
                                        p_prod_code_in,
                                        p_prod_catg_in,
                                        l_prod_prefix,
                                        '0',
                                        l_serlno,
                                        l_max_serlno,
                                        'N',
                                        l_starter_card,
                                        l_errmsg);

               IF l_errmsg <> 'OK'
               THEN
                  l_errmsg := 'Error while generation serials-' || l_errmsg;
                  EXIT;
               END IF;
            END IF;   
         IF p_serl_flag = 1  OR l_starter_card = 'Y'      --- Modified for VMS-1114
         THEN     

            BEGIN
               l_ctrl_numb := l_serlno;
               SELECT vss_serl_numb
                 INTO l_serlno
                 FROM vms_shfl_serl_inv
                WHERE     vss_inst_code = p_inst_code_in
                      AND vss_prod_code = p_prod_code_in
                      AND vss_prod_catg = p_prod_catg_in
                      AND to_number(vss_prod_prefix) = to_number(l_prod_prefix)
                      AND vss_shfl_cntrl = l_ctrl_numb
                      AND vss_serl_flag = 0;

               UPDATE vms_shfl_serl_inv
                  SET vss_serl_flag = 1
                WHERE     vss_inst_code = p_inst_code_in
                      AND vss_prod_code = p_prod_code_in
                      AND vss_prod_catg = p_prod_catg_in
                      AND to_number(vss_prod_prefix) = to_number(l_prod_prefix)
                      AND vss_shfl_cntrl = l_ctrl_numb;

               IF SQL%ROWCOUNT = 0
               THEN
                  l_errmsg := 'Shuffle serial number not updated';
                  EXIT;
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  l_errmsg :=
                     'Shuffle serial number not found for product and product catg :';
                  EXIT;
               WHEN OTHERS
               THEN
                  l_errmsg :=
                     'Error while selecting current shuffle serial : '
                     || SUBSTR (SQLERRM, 1, 200);
                  EXIT;
            END;


         END IF;

         BEGIN
            UPDATE vms_pan_ctrl_inv
               SET vpc_ctrl_numb = vpc_ctrl_numb + 1
             WHERE     vpc_inst_code = p_inst_code_in
                   AND vpc_prod_code = p_prod_code_in
                   AND vpc_prod_catg = p_prod_catg_in
                   AND to_number(vpc_prod_prefix) = to_number(l_prod_prefix);

            IF SQL%ROWCOUNT = 0
            THEN
               l_errmsg := 'Serial number not updated';
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               l_errmsg :=
                  'Error while updating current serial : '
                  || SUBSTR (SQLERRM, 1, 200);
               RETURN;
         END;

         EXIT;
      END LOOP;

       p_prod_prefix_out := l_prod_prefix;
       p_serial_no_out := l_serlno;
      p_err_msg_out := l_errmsg;
   END get_pan_srno;

   PROCEDURE generate_serial_numbers (p_inst_code_in     IN     NUMBER,
                                      p_prod_code_in     IN     VARCHAR2,
                                      p_prod_catg_in     IN     NUMBER,
                                      p_prod_prefix_in   IN     VARCHAR2,
                                      p_serl_flag        IN     NUMBER,
                                      p_minval_in        IN     NUMBER,
                                      p_maxval_in        IN     NUMBER,
                                      p_first_time_flag  IN     VARCHAR2,
                                      p_starter_flag     IN     VARCHAR2,
                                      p_errmsg_out       OUT    VARCHAR2)
   AS
      l_serl_no          shuffle_array_typ;
      l_shuffle_serlno   shuffle_array_typ;
      l_min_serlno       NUMBER;
      l_max_serlno       NUMBER;
      excp_error         EXCEPTION;
      PRAGMA AUTONOMOUS_TRANSACTION;
      L_temp_Max_Serlno       Cms_Pan_Ctrl.Cpc_Max_Serial_No%Type;
      L_Temp_Serlno           Cms_Pan_Ctrl.Cpc_Max_Serial_No%Type;
      L_No_Serials_To_Gen     Cms_Pan_Ctrl.Cpc_Ctrl_Numb%Type;
      L_Serial_Limit          Cms_Pan_Ctrl.Cpc_Max_Serial_No%Type := 999999;
      l_serl_flag             cms_prod_cattype.cpc_serl_flag%type; 

      l_check_flag          VARCHAR2(1);

/*************************************************

     * Modified By      : Ubaidur Rahman H
     * Modified Date    : 29-AUG-2019
     * Purpose          : VMS-1084 (Pan genaration process from sequential to shuffled - B2B and Retail)
     * Reviewer         : Saravanakumar A
     * Release Number   : VMSGPRHOSTR20_B1    

	 * Modified By      : Ubaidur Rahman H
     * Modified Date    : 13-SEP-2019
     * Purpose          : VMS-1114 PAN generation logic change sequential to shuffled 
										for existing sequential product categories - For GPR
     * Reviewer         : Saravanakumar A
     * Release Number   : VMSGPRHOSTR20_B4
*************************************************/ 

   BEGIN
      p_errmsg_out := 'OK';

       l_check_flag := p_serl_flag;
      IF p_minval_in = 0
      THEN
         l_min_serlno := 1;
         l_max_serlno := p_maxval_in + 1;
      ELSE
         l_min_serlno := p_minval_in;
         l_max_serlno := p_maxval_in;
      END IF;


    IF p_serl_flag = '0' AND  p_starter_flag = 'Y'           --- Modified for VMS-1114
    THEN 

    BEGIN
    update cms_prod_cattype 
		  set cpc_serl_flag = 1
		  where cpc_inst_code = p_inst_code_in
		  and cpc_prod_code = p_prod_code_in
		  and cpc_card_type = p_prod_catg_in
          and cpc_serl_flag = '0';

        IF SQL%ROWCOUNT <> 0
        THEN
              l_check_flag := '1';    
        END IF;	



      EXCEPTION 
      WHEN OTHERS
         THEN
            p_errmsg_out :=
               'Error while updating cpc_serl_flag:' || SUBSTR (SQLERRM, 1, 200);
            RAISE excp_error;
      END;    
     END IF;     

      IF p_first_time_flag = 'Y'
      then 
      BEGIN
         INSERT INTO vms_pan_ctrl_inv (vpc_inst_code,
                                       vpc_prod_code,
                                       vpc_prod_catg,
                                       vpc_prod_prefix,
                                       vpc_ctrl_numb,
                                       vpc_min_serlno,
                                       vpc_max_serlno,
                                       vpc_ins_date,
                                       vpc_ins_user)
              VALUES (p_inst_code_in,
                      p_prod_code_in,
                      p_prod_catg_in,
                      p_prod_prefix_in,
                      l_min_serlno,
                      l_min_serlno,
                      l_max_serlno,
                      SYSDATE,
                      1);
      EXCEPTION

         WHEN OTHERS
         THEN
            p_errmsg_out :=
               'Error while inserting serials:' || SUBSTR (SQLERRM, 1, 200);
            RAISE excp_error;
      END;

      END IF;

      IF l_check_flag = '1'
      Then
           L_temp_Max_Serlno := L_Max_Serlno;
           Loop
                If L_Temp_Max_Serlno  > l_serial_limit Then
                   L_Temp_Serlno := L_Temp_Max_Serlno - l_serial_limit;  -- 89  -79 --19  -9
                   l_no_serials_to_gen := l_serial_limit;
                Else
                   L_Temp_Serlno := 0;
                   L_No_Serials_To_Gen := L_Temp_Max_Serlno;
                End If;

                IF l_min_serlno + L_No_Serials_To_Gen > L_Max_Serlno Then
                   L_No_Serials_To_Gen := L_Max_Serlno - l_min_serlno + 1; 
                End If;

                 BEGIN
                    SELECT serials
                      BULK COLLECT INTO l_serl_no
                      FROM (    SELECT ROWNUM + l_min_serlno - 1 serials
                                  FROM DUAL
                            CONNECT BY LEVEL <= l_no_serials_to_gen)
                     WHERE serials >= l_min_serlno;

                    get_shuffle_serials (l_min_serlno,
                                         l_min_serlno + l_no_serials_to_gen - 1,
                                         l_shuffle_serlno);

                    FORALL i IN 1 .. l_serl_no.COUNT
                       INSERT INTO vms_shfl_serl_inv (vss_inst_code,
                                                      vss_prod_code,
                                                      vss_prod_catg,
                                                      vss_prod_prefix,
                                                      vss_serl_numb,
                                                      vss_shfl_cntrl,
                                                      vss_ins_user,
                                                      vss_ins_date)
                            VALUES (p_inst_code_in,
                                    p_prod_code_in,
                                    p_prod_catg_in,
                                    p_prod_prefix_in,
                                    l_shuffle_serlno (i),
                                    l_serl_no (i),
                                    1,
                                    SYSDATE);
                 EXCEPTION
                    WHEN OTHERS
                    THEN
                       p_errmsg_out :=
                          'Error while inserting shuffle serials:'
                          || SUBSTR (SQLERRM, 1, 200);
                       RAISE excp_error;
                 END;

                l_min_serlno := l_min_serlno  + L_No_Serials_To_Gen;  -- 11  --21  -31 -41 -51-61-71-81  -91
                L_temp_Max_Serlno := L_temp_Serlno; --89 -79   -19  9


               If L_Temp_Serlno = 0  or  l_min_serlno >= l_max_serlno Then
                  Exit;
               End If;

           END LOOP;      

      END IF;

      COMMIT;
   EXCEPTION
      WHEN excp_error
      THEN
         ROLLBACK;
      WHEN OTHERS
      THEN
         ROLLBACK;
         p_errmsg_out := 'Main Excp:' || SUBSTR (SQLERRM, 1, 200);
   END generate_serial_numbers;
END;

/
show error;