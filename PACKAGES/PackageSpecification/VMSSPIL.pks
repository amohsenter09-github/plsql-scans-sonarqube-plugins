create or replace PACKAGE     vmscms.vmsspil
IS
   -- Author  : Pankaj S.
   -- Created : 31/10/2017 03:20:00 PM
   -- Purpose : SPIL enhancements

   -- Public type declarations

   -- Public constant declarations

   -- Public variable declarations

   -- Public function and procedure declarations
   PROCEDURE card_redemption (p_inst_code_in               IN   NUMBER,
                              p_msg_typ_in                 IN   VARCHAR2,
                              p_rrn_in                     IN   VARCHAR2,
                              p_delivery_channel_in        IN   VARCHAR2,
                              p_term_id_in                 IN   VARCHAR2,
                              p_txn_code_in                IN   VARCHAR2,
                              p_txn_mode_in                IN  VARCHAR2,
                              p_business_date_in           IN  VARCHAR2,
                              p_business_time_in           IN  VARCHAR2,
                              p_card_no_in                 IN  VARCHAR2,
                              p_txn_amt_in                 IN  NUMBER,
                              p_merchant_name_in           IN  VARCHAR2,
                              p_curr_code_in               IN  VARCHAR2,
                              p_stan_in                    IN  VARCHAR2,
                              p_mbr_numb_in                IN  VARCHAR2,
                              p_rvsl_code_in               IN  VARCHAR2,
                              p_lupduser_in                IN  NUMBER,
                              p_store_id_in                IN  VARCHAR2,
                              p_product_id_in              IN  VARCHAR2,
                              p_fee_amt_in                 IN  NUMBER,
                              p_upc_in                     IN  VARCHAR2,
                              p_mercrefnum_in              IN  VARCHAR2,
                              p_reqtimezone_in             IN  VARCHAR2,
                              p_localcountry_in            IN  VARCHAR2,
                              p_localcurrency_in           IN  VARCHAR2,
                              p_loclanguage_in             IN  VARCHAR2,
                              p_posentry_in                IN  VARCHAR2,
                              p_poscond_in                 IN  VARCHAR2,
                              p_address1_in                IN VARCHAR2,
                              p_address2_in                IN VARCHAR2,
                              p_city_in                    IN VARCHAR2,
                              p_state_in                   IN VARCHAR2,
                              p_zip_in                     IN VARCHAR2,
                              p_resp_code_out              OUT VARCHAR2,
                              p_resp_msg_out               OUT VARCHAR2,
                              p_auth_id_out                OUT VARCHAR2,
                              p_autherized_amount_out      OUT VARCHAR2,
                              p_balance_out                OUT VARCHAR2,
                              p_curr_out                   OUT VARCHAR2);

   PROCEDURE card_redemption_reversal (
      p_inst_code_in             IN      NUMBER,
      p_msg_typ_in               IN       VARCHAR2,
      p_rvsl_code_in             IN      VARCHAR2,
      p_rrn_in                   IN      VARCHAR2,
      p_delivery_channel_in      IN      VARCHAR2,
      p_terminal_id_in           IN      VARCHAR2,
      p_merc_id_in               IN      VARCHAR2,
      p_txn_code_in              IN      VARCHAR2,
      p_txn_type_in              IN      VARCHAR2,
      p_txn_mode_in              IN      VARCHAR2,
      p_business_date_in         IN      VARCHAR2,
      p_business_time_in         IN      VARCHAR2,
      p_card_no_in               IN      VARCHAR2,
      p_actual_amt_in            IN      NUMBER,
      p_stan_in                  IN      VARCHAR2,
      p_mbr_numb_in              IN      VARCHAR2,
      p_curr_code_in             IN      VARCHAR2,
      p_merchant_name_in         IN      VARCHAR2,
      p_store_id_in              IN      VARCHAR2,
      p_lupduser_in              IN      NUMBER,
      p_product_id_in            IN      VARCHAR2,
      p_fee_amt_in               IN      NUMBER,
      p_upc_in                   IN      VARCHAR2,
      p_mercrefnum_in            IN      VARCHAR2,
      p_reqtimezone_in           IN      VARCHAR2,
      p_localcountry_in          IN      VARCHAR2,
      p_localcurrency_in         IN      VARCHAR2,
      p_loclanguage_in           IN      VARCHAR2,
      p_posentry_in              IN      VARCHAR2,
      p_poscond_in               IN      VARCHAR2,
      p_address1_in              IN      VARCHAR2,
      p_address2_in              IN      VARCHAR2,
      p_city_in                  IN      VARCHAR2,
      p_state_in                 IN      VARCHAR2,
      p_zip_in                   IN      VARCHAR2,
      p_resp_code_out              OUT VARCHAR2,
      p_resp_msg_out               OUT VARCHAR2,
      p_auth_id_out                OUT VARCHAR2,
      p_autherized_amount_out      OUT VARCHAR2,
      p_balance_out                OUT VARCHAR2,
      p_curr_out                   OUT VARCHAR2);

   PROCEDURE redemption_lock (p_inst_code_in             IN      NUMBER,
                              p_msg_typ_in               IN      VARCHAR2,
                              p_rrn_in                   IN      VARCHAR2,
                              p_delivery_channel_in      IN      VARCHAR2,
                              p_term_id_in               IN      VARCHAR2,
                              p_txn_code_in              IN      VARCHAR2,
                              p_txn_mode_in              IN      VARCHAR2,
                              p_business_date_in         IN      VARCHAR2,
                              p_business_time_in         IN      VARCHAR2,
                              p_card_no_in               IN      VARCHAR2,
                              p_txn_amt_in               IN      NUMBER,
                              p_merchant_name_in         IN      VARCHAR2,
                              p_mcc_code_in              IN      VARCHAR2,
                              p_curr_code_in             IN      VARCHAR2,
                              p_pos_verfication_in       IN      VARCHAR2,
                              p_stan_in                  IN      VARCHAR2,
                              p_rvsl_code_in             IN      VARCHAR2,
                              p_international_ind_in     IN      VARCHAR2,
                              p_store_id_in              IN      VARCHAR2,
                              p_product_id_in            IN      VARCHAR2,
                              p_fee_amt_in               IN      NUMBER,
                              p_upc_in                   IN      VARCHAR2,
                              p_mercrefnum_in            IN      VARCHAR2,
                              p_reqtimezone_in           IN      VARCHAR2,
                              p_localcountry_in          IN      VARCHAR2,
                              p_localcurrency_in         IN      VARCHAR2,
                              p_loclanguage_in           IN      VARCHAR2,
                              p_posentry_in              IN      VARCHAR2,
                              p_poscond_in               IN      VARCHAR2,
                              p_address1_in              IN      VARCHAR2,
                              p_address2_in              IN      VARCHAR2,
                              p_city_in                  IN      VARCHAR2,
                              p_state_in                 IN      VARCHAR2,
                              p_zip_in                   IN      VARCHAR2,
                              p_resp_code_out              OUT VARCHAR2,
                              p_resp_msg_out               OUT VARCHAR2,
                              p_auth_id_out                OUT VARCHAR2,
                              p_autherized_amount_out      OUT VARCHAR2,
                              p_balance_out                OUT VARCHAR2,
                              p_proxyno_out                   OUT VARCHAR2);

   PROCEDURE redemption_lock_reversal (
      p_inst_code_in             IN      NUMBER,
      p_msg_typ_in               IN      VARCHAR2,
      p_rvsl_code_in             IN      VARCHAR2,
      p_rrn_in                   IN      VARCHAR2,
      p_delivery_channel_in      IN      VARCHAR2,
      p_terminal_id_in           IN      VARCHAR2,
      p_merc_id_in               IN      VARCHAR2,
      p_txn_code_in              IN      VARCHAR2,
      p_txn_type_in              IN      VARCHAR2,
      p_txn_mode_in              IN      VARCHAR2,
      p_business_date_in         IN      VARCHAR2,
      p_business_time_in         IN      VARCHAR2,
      p_card_no_in               IN      VARCHAR2,
      p_actual_amt_in            IN      NUMBER,
      p_stan_in                  IN      VARCHAR2,
      p_curr_code_in             IN      VARCHAR2,
      p_merchant_name_in         IN      VARCHAR2,
      p_store_id_in              IN      VARCHAR2,
      p_product_id_in            IN      VARCHAR2,
      p_fee_amt_in               IN      NUMBER,
      p_upc_in                   IN      VARCHAR2,
      p_mercrefnum_in            IN      VARCHAR2,
      p_reqtimezone_in           IN      VARCHAR2,
      p_localcountry_in          IN      VARCHAR2,
      p_localcurrency_in         IN      VARCHAR2,
      p_loclanguage_in           IN      VARCHAR2,
      p_posentry_in              IN      VARCHAR2,
      p_poscond_in               IN      VARCHAR2,
      p_address1_in              IN      VARCHAR2,
      p_address2_in              IN      VARCHAR2,
      p_city_in                  IN      VARCHAR2,
      p_state_in                 IN      VARCHAR2,
      p_zip_in                   IN      VARCHAR2,
      p_resp_code_out              OUT VARCHAR2,
      p_resp_msg_out               OUT VARCHAR2,
      p_auth_id_out                OUT VARCHAR2,
      p_autherized_amount_out      OUT VARCHAR2,
      p_balance_out                OUT VARCHAR2,
      p_proxyno_out                   OUT VARCHAR2);

      PROCEDURE Store_credit_reversal (
      p_inst_code_in            IN    NUMBER,
      p_msg_typ_in              IN    VARCHAR2,
      p_rvsl_code_in            IN    VARCHAR2,
      p_rrn_in                  IN    VARCHAR2,
      p_delivery_channel_in     IN    VARCHAR2,
      p_terminal_id_in          IN    VARCHAR2,
      p_merc_id_in              IN    VARCHAR2,
      p_txn_code_in             IN    VARCHAR2,
      p_txn_type_in             IN    VARCHAR2,
      p_txn_mode_in             IN    VARCHAR2,
      p_business_date_in        IN    VARCHAR2,
      p_business_time_in        IN    VARCHAR2,
      p_card_no_in              IN    VARCHAR2,
      p_actual_amt_in           IN    NUMBER,
      p_stan_in                 IN    VARCHAR2,
      p_curr_code_in            IN    VARCHAR2,
      p_merchant_name_in        IN    VARCHAR2,
      p_store_id_in             IN    VARCHAR2,
      P_serial_number_in        IN    VARCHAR2,
      P_ADDRESS1_IN             IN    VARCHAR2,
      P_ADDRESS2_IN             IN    VARCHAR2,
      P_CITY_IN                 IN    VARCHAR2,
      P_STATE_IN                IN    VARCHAR2,
      P_ZIP_IN                  IN    VARCHAR2,
      P_SPIL_PROD_ID_IN         IN    VARCHAR2,
      P_SPIL_FEE_IN             IN    NUMBER,
      P_SPIL_UPC_IN             IN    VARCHAR2,
      P_SPIL_MERREF_NUM_IN      IN    VARCHAR2,
      P_SPIL_REQ_TMZM_IN        IN    VARCHAR2,
      P_SPIL_LOC_CNTRY_IN       IN    VARCHAR2,
      P_SPIL_LOC_CRCY_IN        IN    VARCHAR2,
      P_SPIL_LOC_LANG_IN        IN    VARCHAR2,
      P_SPIL_POS_ENTRY_IN       IN    VARCHAR2,
      P_SPIL_POS_COND_IN        IN    VARCHAR2,
      p_resp_code_out           OUT   VARCHAR2,
      p_resp_msg_out            OUT   VARCHAR2,
      p_auth_id_out             OUT   VARCHAR2,
      p_autherized_amount_out   OUT   VARCHAR2,
      p_balance_out             OUT   VARCHAR2,
      p_curr_out                OUT   VARCHAR2);

PROCEDURE   Store_credit(
          P_INST_CODE_IN         IN NUMBER,
          P_RRN_IN               IN VARCHAR2,
          P_TERMINALID_IN        IN VARCHAR2,
          P_STAN_IN              IN VARCHAR2,
          P_TRANDATE_IN          IN VARCHAR2,
          P_TRANTIME_IN          IN VARCHAR2,
          P_PAN_CODE_IN          IN VARCHAR2,
          P_AMOUNT_IN            IN NUMBER,
          P_CURRCODE_IN          IN VARCHAR2,
          P_MSG_TYPE_IN          IN VARCHAR2,
          P_TXN_CODE_IN          IN VARCHAR2,
          P_TXN_MODE_IN          IN VARCHAR2,
          P_DELIVERY_CHANNEL_IN  IN VARCHAR2,
          P_RVSL_CODE_IN         IN VARCHAR2,
          P_Merchant_Name_IN     IN VARCHAR2,
          P_STORE_ID_IN          IN VARCHAR2,
          P_SERIAL_NUMBER_IN     IN VARCHAR2,
          P_ADDRESS1_IN          IN VARCHAR2,
          P_ADDRESS2_IN          IN VARCHAR2,
          P_CITY_IN              IN VARCHAR2,
          P_STATE_IN             IN VARCHAR2,
          P_ZIP_IN               IN VARCHAR2,
          P_SPIL_PROD_ID_IN      IN VARCHAR2,
          P_SPIL_FEE_IN          IN NUMBER,
          P_SPIL_UPC_IN          IN VARCHAR2,
          P_SPIL_MERREF_NUM_IN   IN VARCHAR2,
          P_SPIL_REQ_TMZM_IN     IN VARCHAR2,
          P_SPIL_LOC_CNTRY_IN    IN VARCHAR2,
          P_SPIL_LOC_CRCY_IN     IN VARCHAR2,
          P_SPIL_LOC_LANG_IN     IN VARCHAR2,
          P_SPIL_POS_ENTRY_IN    IN VARCHAR2,
          P_SPIL_POS_COND_IN     IN VARCHAR2,
          P_RESP_CODE_OUT         OUT VARCHAR2,
          P_ERRMSG_OUT            OUT VARCHAR2,
          P_RESP_MSG_TYPE_OUT     OUT varchar2,
          P_ACCT_BAL_OUT          OUT VARCHAR2,
          P_AUTH_ID_OUT           OUT VARCHAR2
          );

  PROCEDURE redemption_unlock (p_inst_code_in             IN     NUMBER,
                                p_msg_typ_in               IN     VARCHAR2,
                                p_rrn_in                   IN     VARCHAR2,
                                p_delivery_channel_in      IN     VARCHAR2,
                                p_term_id_in               IN     VARCHAR2,
                                p_txn_code_in              IN     VARCHAR2,
                                p_txn_mode_in              IN     VARCHAR2,
                                p_business_date_in         IN     VARCHAR2,
                                p_business_time_in         IN     VARCHAR2,
                                p_card_no_in               IN     VARCHAR2,
                                p_txn_amt_in               IN     NUMBER,
                                p_merchant_name_in         IN     VARCHAR2,
                                p_mcc_code_in              IN     VARCHAR2,
                                p_curr_code_in             IN     VARCHAR2,
                                p_stan_in                  IN     VARCHAR2,
                                p_rvsl_code_in             IN     VARCHAR2,
                                p_store_id_in              IN     VARCHAR2,
                                p_product_id_in            IN     VARCHAR2,
                                p_fee_amt_in               IN     NUMBER,
                                p_upc_in                   IN     VARCHAR2,
                                p_mercrefnum_in            IN     VARCHAR2,
                                p_reqtimezone_in           IN     VARCHAR2,
                                p_localcountry_in          IN     VARCHAR2,
                                p_localcurrency_in         IN     VARCHAR2,
                                p_loclanguage_in           IN     VARCHAR2,
                                p_posentry_in              IN     VARCHAR2,
                                p_poscond_in               IN     VARCHAR2,
                                p_address1_in              IN     VARCHAR2,
                                p_address2_in              IN     VARCHAR2,
                                p_city_in                  IN     VARCHAR2,
                                p_state_in                 IN     VARCHAR2,
                                p_zip_in                   IN     VARCHAR2,
                                p_resp_code_out               OUT VARCHAR2,
                                p_resp_msg_out                OUT VARCHAR2,
                                p_auth_id_out                 OUT VARCHAR2,
                                p_autherized_amount_out       OUT VARCHAR2,
                                p_balance_out                 OUT VARCHAR2);

    PROCEDURE spil_authorize_txn_cms_auth (
      p_inst_code           IN     NUMBER,
      p_msg                 IN     VARCHAR2,
      p_rrn                        VARCHAR2,
      p_delivery_channel           VARCHAR2,
      p_term_id                    VARCHAR2,
      p_txn_code                   VARCHAR2,
      p_txn_mode                   VARCHAR2,
      p_tran_date                  VARCHAR2,
      p_tran_time                  VARCHAR2,
      p_card_no                    VARCHAR2,
      p_txn_amt                    NUMBER,
      p_merchant_name              VARCHAR2,
      p_merchant_city              VARCHAR2,
      p_mcc_code                   VARCHAR2,
      p_curr_code                  VARCHAR2,
      p_tip_amt                    VARCHAR2,
      p_atmname_loc                VARCHAR2,
      p_mcccode_groupid            VARCHAR2,
      p_currcode_groupid           VARCHAR2,
      p_transcode_groupid          VARCHAR2,
      p_rules                      VARCHAR2,
      p_preauth_date               DATE,
      p_expry_date          IN     VARCHAR2,
      p_stan                IN     VARCHAR2,
      p_mbr_numb            IN     VARCHAR2,
      p_rvsl_code           IN     VARCHAR2,
      p_curr_convert_amnt   IN     VARCHAR2,
      p_partital_amt         OUT VARCHAR2,
      p_auth_id                OUT VARCHAR2,
      p_resp_code              OUT VARCHAR2,
      p_resp_msg               OUT VARCHAR2,
      p_capture_date           OUT DATE);
      
     
      procedure balance_transfer(p_instcode_in         IN NUMBER,
                 p_mbr_numb_in                  IN VARCHAR2,
                 p_msg_type_in                  IN VARCHAR2,
                 p_currcode_in                  IN VARCHAR2,
                 p_rrn_in                       IN VARCHAR2,
                 p_src_card_in                  IN VARCHAR2,
                 p_trg_card_in                  IN VARCHAR2,
                 p_delivery_channel_in          IN VARCHAR2,
                 p_txn_code_in                  IN VARCHAR2,
                 p_txn_mode_in                  IN VARCHAR2,
                 p_trandate_in                  IN VARCHAR2,
                 p_trantime_in                  IN VARCHAR2,
                 p_terminalid_in                IN VARCHAR2,
                 p_merchant_name_in             IN VARCHAR2,
                 p_rvsl_code_in                 IN VARCHAR2,
                 p_storeid_in                   IN VARCHAR2,
                 p_store_add1_in                IN VARCHAR2,
                 p_store_add2_in                IN VARCHAR2,
                 p_store_city_in                IN VARCHAR2,
                 p_store_state_in               IN VARCHAR2,
                 p_store_zip_in                 IN VARCHAR2,
                 P_Trans_Amt_In                 In Varchar2,
                 P_Merchantid_In                In Varchar2,
                 p_locationId_in                in varchar2,
                 p_trgt_bal_amt_out             OUT VARCHAR2,
                 p_src_bal_amt_out              OUT VARCHAR2,
                 p_trgt_card_stat_out           OUT VARCHAR2,
                 p_src_card_stat_out            OUT VARCHAR2,
                 p_trg_proxy_no_out             OUT VARCHAR2,
                 p_auth_amnt_out                OUT VARCHAR2,
                 p_errmsg_out                   OUT VARCHAR2,
                 p_resp_code_out                OUT VARCHAR2);

    PROCEDURE BALANCE_TRANSFER_REVERSAL(p_instcode_in         IN NUMBER,
                 p_mbr_numb_in         IN VARCHAR2, 
                 p_msg_type_in         IN VARCHAR2,
                 p_currcode_in         IN VARCHAR2,
                 p_rrn_in              IN VARCHAR2,
                 p_src_card_in         IN VARCHAR2,
                 p_trg_card_in         IN VARCHAR2,
                 p_delivery_channel_in IN VARCHAR2,
                 p_txn_code_in         IN VARCHAR2,
                 p_txn_mode_in         IN VARCHAR2,
                 p_trandate_in         IN VARCHAR2,
                 p_trantime_in         IN VARCHAR2,
                 p_terminalid_in       IN VARCHAR2,
                 p_merchant_name_in    IN VARCHAR2,
                 p_rvsl_code_in        IN VARCHAR2,
                 p_storeid_in          IN VARCHAR2,
                 p_store_add1_in       IN VARCHAR2,
                 p_store_add2_in       IN VARCHAR2,
                 P_Store_City_In       In Varchar2,
                 p_store_state_in      IN VARCHAR2,
                 P_Store_Zip_In        In Varchar2,
                 P_Trans_Amt_In        In Varchar2,
                 P_Merchantid_In       In Varchar2,
                 p_locationId_in       in varchar2,
                 p_trg_bal_amt_out     OUT VARCHAR2,
                 p_src_bal_amt_out     OUT VARCHAR2,
                 p_trgt_card_stat_out  OUT VARCHAR2,
                 p_src_card_stat_out   OUT VARCHAR2,
                 p_src_proxy_no_out    OUT VARCHAR2, 
                 p_auth_amnt_out       OUT VARCHAR2,
                 p_errmsg_out          OUT VARCHAR2,
                 p_resp_code_out       OUT VARCHAR2);                 

   procedure balance_transfer_virtual(p_instcode_in         IN NUMBER,
                    p_mbr_numb_in         IN VARCHAR2,
                    p_msg_type_in         IN VARCHAR2,
                    p_currcode_in         IN VARCHAR2,
                    p_rrn_in              IN VARCHAR2,
                    p_src_card_in         IN VARCHAR2,
                    p_trg_card_in         IN VARCHAR2,
                    p_delivery_channel_in IN VARCHAR2,
                    p_txn_code_in         IN VARCHAR2,
                    p_txn_mode_in         IN VARCHAR2,
                    p_trandate_in         IN VARCHAR2,
                    p_trantime_in         IN VARCHAR2,
                    p_terminalid_in       IN VARCHAR2,
                    p_merchant_name_in    IN VARCHAR2,
                    p_rvsl_code_in        IN VARCHAR2,
                    p_storeid_in          IN VARCHAR2,
                    p_store_add1_in       IN VARCHAR2,
                    p_store_add2_in       IN VARCHAR2,
                    p_store_city_in       IN VARCHAR2,
                    p_store_state_in      IN VARCHAR2,
                    p_store_zip_in        IN VARCHAR2,
                    P_Trans_Amt_In        In Varchar2,
                    P_Merchantid_In       In Varchar2,
                    p_locationId_in       in varchar2,
                    p_trgt_bal_amt_out    OUT VARCHAR2,
                    p_src_bal_amt_out     OUT VARCHAR2,
                    p_trgt_card_stat_out  OUT VARCHAR2,
                    p_src_card_stat_out   OUT VARCHAR2,
                    p_trg_proxy_no_out    OUT VARCHAR2,
                    p_auth_amnt_out       OUT VARCHAR2,
                    p_errmsg_out          OUT VARCHAR2,
                    p_resp_code_out       OUT VARCHAR2);

   PROCEDURE balance_transfer_v_revrsl(p_instcode_in         IN NUMBER,
                    p_mbr_numb_in         IN VARCHAR2,
                    p_msg_type_in         IN VARCHAR2,
                    p_currcode_in         IN VARCHAR2,
                    p_rrn_in              IN VARCHAR2,
                    p_src_card_in         IN VARCHAR2,
                    p_trg_card_in         IN VARCHAR2,
                    p_delivery_channel_in IN VARCHAR2,
                    p_txn_code_in         IN VARCHAR2,
                    p_txn_mode_in         IN VARCHAR2,
                    p_trandate_in         IN VARCHAR2,
                    p_trantime_in         IN VARCHAR2,
                    p_terminalid_in       IN VARCHAR2,
                    p_merchant_name_in    IN VARCHAR2,
                    p_rvsl_code_in        IN VARCHAR2,
                    p_storeid_in          IN VARCHAR2,
                    p_store_add1_in       IN VARCHAR2,
                    p_store_add2_in       IN VARCHAR2,
                    P_Store_City_In       In Varchar2,
                    p_store_state_in      IN VARCHAR2,
                    P_Store_Zip_In        In Varchar2,
                    P_Trans_Amt_In        In Varchar2,
                    P_Merchantid_In       In Varchar2,
                    p_locationId_in       in varchar2,
                    p_trg_bal_amt_out     OUT VARCHAR2,
                    p_src_bal_amt_out     OUT VARCHAR2,
                    p_trgt_card_stat_out  OUT VARCHAR2,
                    p_src_card_stat_out   OUT VARCHAR2,
                    p_src_proxy_no_out    OUT VARCHAR2,
                    p_auth_amnt_out       OUT VARCHAR2,
                    p_errmsg_out          OUT VARCHAR2,
                    p_resp_code_out       OUT VARCHAR2);
END;
/
show error