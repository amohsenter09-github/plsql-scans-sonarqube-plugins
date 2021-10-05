create or replace
PACKAGE BODY     VMSCMS.VMS_TRANSACTION
AS
   -- Private constant declarations
   PROCEDURE get_transaction_history (
      p_inst_code_in           IN       VARCHAR2,
      p_del_channel_in         IN       VARCHAR2,
      p_txn_code_in            IN       VARCHAR2,
      p_rrn_in                 IN       VARCHAR2,
      p_src_app_in             IN       VARCHAR2,
      p_partner_id_in          IN       VARCHAR2,
      p_business_date_in       IN       VARCHAR2,
      p_business_time_in       IN       VARCHAR2,
      p_curr_code_in           IN       VARCHAR2,
      p_reversal_code_in       IN       VARCHAR2,
      p_msg_type_in            IN       VARCHAR2,
      p_ip_addr_in             IN       VARCHAR2,
      p_ani_in                 IN       VARCHAR2,
      p_dni_in                 IN       VARCHAR2,
      p_dev_mob_no_in          IN       VARCHAR2,
      p_device_id_in           IN       VARCHAR2,
      p_uuid_in                IN       VARCHAR2,
      p_osname_in              IN       VARCHAR2,
      p_osversion_in           IN       VARCHAR2,
      p_gpscoordinates_in      IN       VARCHAR2,
      p_displayresolution_in   IN       VARCHAR2,
      p_physicalmemory_in      IN       VARCHAR2,
      p_appname_in             IN       VARCHAR2,
      p_appversion_in          IN       VARCHAR2,
      p_sessionid_in           IN       VARCHAR2,
      p_devicecountry_in       IN       VARCHAR2,
      p_deviceregion_in        IN       VARCHAR2,
      p_ipcountry_in           IN       VARCHAR2,
      p_proxy_in               IN       VARCHAR2,
      p_cust_id_in             IN       VARCHAR2,
      p_pan_code_in            IN       VARCHAR2,
      p_start_date_in          IN       VARCHAR2,
      p_end_date_in            IN       VARCHAR2,
      p_account_type_in        IN       VARCHAR2,
      p_tran_filter_in         IN       VARCHAR2,
      p_no_of_records_in       IN       VARCHAR2,
      p_resp_code_out          OUT      VARCHAR2,
      p_resp_msg_out           OUT      VARCHAR2,
      p_transaction_out        OUT      sys_refcursor
   )
   AS
      l_start_date        DATE;
      l_end_date          DATE;
      l_account_type      VARCHAR2 (100)
                               := NVL (UPPER (p_account_type_in), 'SPENDING');
      l_tran_filter       VARCHAR2 (100)
                                     := NVL (UPPER (p_tran_filter_in), 'ALL');
      l_no_of_records     VARCHAR2 (5)                  := p_no_of_records_in;
      l_select_query              VARCHAR2 (10000);
      l_query                     VARCHAR2 (10000);
      l_pending_select_query      VARCHAR2 (10000);
      l_pending_from_query        VARCHAR2 (10000);
      l_posted_select_query       VARCHAR2 (10000);
      l_posted_from_query         VARCHAR2 (10000);
      l_exec_query                VARCHAR2 (20000);
      l_err_msg                   VARCHAR2 (1000);
      l_txn_type                  VARCHAR2 (2);
      l_hash_pan          cms_appl_pan.cap_pan_code%TYPE;
      l_encr_pan          cms_appl_pan.cap_pan_code_encr%TYPE;
      l_acct_no           cms_appl_pan.cap_acct_no%TYPE;
      l_card_stat         cms_appl_pan.cap_card_stat%TYPE;
      l_prod_code         cms_appl_pan.cap_prod_code%TYPE;
      l_card_type         cms_appl_pan.cap_card_type%TYPE;
      l_expry_date        cms_appl_pan.cap_expry_date%TYPE;
      l_prfl_code         cms_appl_pan.cap_prfl_code%TYPE;
      l_proxy_number      cms_appl_pan.cap_proxy_number%TYPE;
      l_cr_dr_flag        cms_transaction_mast.ctm_credit_debit_flag%TYPE;
      l_tran_desc         cms_transaction_mast.ctm_tran_desc%TYPE;
      l_prfl_flag         cms_transaction_mast.ctm_prfl_flag%TYPE;
      l_preauth_flag      cms_transaction_mast.ctm_preauth_flag%TYPE;
      l_login_txn         cms_transaction_mast.ctm_login_txn%TYPE;
      l_preauth_type      cms_transaction_mast.ctm_preauth_type%TYPE;
      l_dup_rrn_check     cms_transaction_mast.ctm_rrn_check%TYPE;
      l_acct_bal          cms_acct_mast.cam_acct_bal%TYPE;
      l_ledger_bal        cms_acct_mast.cam_ledger_bal%TYPE;
      l_acct_type         cms_acct_mast.cam_type_code%TYPE;
      l_auth_id           transactionlog.auth_id%TYPE;
      l_fee_code          transactionlog.feecode%TYPE;
      l_fee_plan          transactionlog.fee_plan%TYPE;
      l_feeattach_type    transactionlog.feeattachtype%TYPE;
      l_tranfee_amt       transactionlog.tranfee_amt%TYPE;
      l_total_amt         transactionlog.total_amount%TYPE;
      l_hashkey_id        cms_transaction_log_dtl.ctd_hashkey_id%TYPE;
      l_tran_amt          cms_acct_mast.cam_acct_bal%TYPE;
      l_comb_hash         pkg_limits_check.type_hash;
      l_timestamp         TIMESTAMP;
      exp_reject_record   EXCEPTION;
       l_spending_acct_no  cms_acct_mast.cam_acct_no%TYPE;
       l_cust_code         cms_appl_pan.cap_cust_code%TYPE;
       
      l_status_chk        pls_integer;
      l_precheck_flag     pls_integer;
/*************************************************
  * Modified By       : Sivakumar M
  * Modified Date     : 07-Feb-2019 
  * Purpose           : VMS-780 
  * Reviewer          : Saravanakumar
  * Build Number      : VMSR12-B0003
  
  
  * Modified By      : Sivakumar M
  * Modified Date    : 23-May-2019
  * Purpose          : VMS-922
  * Reviewer         : Saravanan
  * Release Number   : VMSGPRHOST R16
*************************************************/
   BEGIN
      BEGIN
      p_resp_msg_out :='success';


-- SN Get PAN Details
         BEGIN
         SELECT cap_pan_code, cap_pan_code_encr, cap_acct_no,
                cap_card_stat, cap_prod_code, cap_card_type,
                cap_expry_date,  cap_prfl_code,  cap_proxy_number,cap_cust_code
           INTO l_hash_pan, l_encr_pan, l_acct_no,
                l_card_stat, l_prod_code, l_card_type,
                l_expry_date,  l_prfl_code, l_proxy_number,l_cust_code
           FROM cms_appl_pan
          WHERE cap_inst_code = p_inst_code_in
            AND cap_pan_code = gethash (p_pan_code_in)
            AND cap_mbr_numb = '000';


         EXCEPTION
            WHEN NO_DATA_FOUND    THEN
               p_resp_code_out := '21';
               l_err_msg := 'Invalid Card number ' || gethash (p_pan_code_in);
               RAISE exp_reject_record;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error while getting PAN details  '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;

-- EN Get PAN Details


 l_spending_acct_no := l_acct_no;
--Sn Validating Savings Account type
 IF upper(p_account_type_in) = 'SAVINGS'
 THEN
    BEGIN
         SELECT cam_acct_no
         INTO l_acct_no
         FROM CMS_ACCT_MAST
         WHERE cam_inst_code = p_inst_code_in
         AND cam_type_code = '2'
         AND cam_acct_id   in (select cca_acct_id from cms_cust_acct where cca_cust_code = l_cust_code);

    EXCEPTION
             WHEN NO_DATA_FOUND    THEN
                 p_resp_code_out := '21';
                 l_err_msg := 'Saving account not created ' ;
                 RAISE exp_reject_record;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                   'Error in getting savings account number' || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
    END;
 END IF;
--En Validating Account type

         -- SN Get Transaction details
         BEGIN
            vmscommon.get_transaction_details (p_inst_code_in,
                                               p_del_channel_in,
                                               p_txn_code_in,
                                               l_cr_dr_flag,
                                               l_txn_type,
                                               l_tran_desc,
                                               l_prfl_flag,
                                               l_preauth_flag,
                                               l_login_txn,
                                               l_preauth_type,
                                               l_dup_rrn_check,
                                               p_resp_code_out,
                                               l_err_msg
                                              );

            IF l_err_msg <> 'OK'
            THEN
               RAISE exp_reject_record;
            END IF;
         EXCEPTION
            WHEN exp_reject_record
            THEN
               RAISE;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error while getting Transaction details  '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;

-- EN Get Transaction details

         -- SN Validate date and RRN
         IF l_dup_rrn_check = 'Y' THEN
         BEGIN
            vmscommon.validate_date_rrn (p_inst_code_in,
                                         p_rrn_in,
                                         p_business_date_in,
                                         p_business_time_in,
                                         p_del_channel_in,
                                         l_err_msg,
                                         p_resp_code_out
                                        );

            IF l_err_msg <> 'OK'
            THEN
               RAISE exp_reject_record;
            END IF;
         EXCEPTION
            WHEN exp_reject_record
            THEN
               RAISE;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error while validating date and RRN  '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;
         END IF;
-- EN Validate date and RRN

-- SN Get start and end date
         BEGIN
            IF p_start_date_in IS NULL
            THEN
               IF p_end_date_in IS NULL
               THEN
                  l_end_date :=
                     TO_DATE ((   TO_CHAR (TRUNC (SYSDATE), 'YYYYMMDD')
                               || ' 235959'
                              ),
                              'YYYYMMDD HH24MISS'
                             );
               ELSE
                  l_end_date :=
                     TO_DATE ((p_end_date_in || ' 235959'),
                              'YYYY-MM-DD HH24MISS'
                             );
               END IF;

               l_start_date :=
                  TO_DATE ((   TO_CHAR (TRUNC (l_end_date) - 30, 'YYYYMMDD')
                            || ' 000000'
                           ),
                           'YYYYMMDD HH24MISS'
                          );
            ELSIF p_start_date_in IS NOT NULL
            THEN
               l_start_date :=
                  TO_DATE ((p_start_date_in || ' 000000'),
                           'YYYY-MM-DD HH24MISS'
                          );

               IF p_end_date_in IS NULL
               THEN
                  l_end_date :=
                     TO_DATE ((   TO_CHAR (TRUNC (l_start_date) + 30,
                                           'YYYYMMDD'
                                          )
                               || ' 235959'
                              ),
                              'YYYYMMDD HH24MISS'
                             );
               ELSE
                  l_end_date :=
                     TO_DATE ((p_end_date_in || ' 235959'),
                              'YYYY-MM-DD HH24MISS'
                             );
               END IF;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg := 'Invalid Date';
               RAISE exp_reject_record;
         END;
-- SN Get start and end date

--SN Validating Date

        IF p_start_date_in > p_end_date_in
        THEN
            p_resp_code_out := '21';
            l_err_msg := 'End Date must be greater then Start Date';
            RAISE exp_reject_record;
        END IF;

--EN Validating Date


         -- SN Validate account type and transaction filter
         BEGIN
            IF (l_account_type NOT IN ('SPENDING', 'SAVINGS'))
            THEN
               p_resp_code_out := '21';
               RAISE exp_reject_record;
            END IF;

            IF (l_tran_filter NOT IN ('ALL', 'POSTED', 'PENDING'))
            THEN
               p_resp_code_out := '21';
               RAISE exp_reject_record;
            END IF;
         EXCEPTION
            WHEN exp_reject_record
            THEN
               l_err_msg :=
                     'Error in Input Data - Account Type or Transaction Filter'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error in Input Data - Account Type or Transaction Filter'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;

-- EN Validate account type and transaction filter



--SN Perform common validations
BEGIN
      sp_status_check_gpr (p_inst_code_in,
                           p_pan_code_in,
                           p_del_channel_in,
                           l_expry_date,
                           l_card_stat,
                           p_txn_code_in,
                           '0',--p_txn_mode_in',
                           l_prod_code,
                           l_card_type,
                           p_msg_type_in,
                           p_business_date_in,
                           p_business_time_in,
                           NULL,
                           NULL,
                           NULL,
                           p_resp_code_out,
                           l_err_msg
                          );

      IF (   (p_resp_code_out <> '1' AND l_err_msg <> 'OK')
          OR (p_resp_code_out <> '0' AND l_err_msg <> 'OK'))  THEN
         RAISE exp_reject_record;
      ELSE
         l_status_chk := p_resp_code_out;
         p_resp_code_out := '1';
      END IF;
   EXCEPTION  WHEN exp_reject_record THEN
        RAISE;
      WHEN OTHERS  THEN
         p_resp_code_out := '21';
         l_err_msg :=  'Error from GPR Card Status Check '|| SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   --En GPR Card status check
   IF l_status_chk = '1'
   THEN
      -- Expiry Check
      BEGIN
         IF TO_DATE (p_business_date_in, 'YYYYMMDD') >  LAST_DAY (TO_CHAR (l_expry_date, 'DD-MON-YY'))
         THEN
            p_resp_code_out := '13';
            l_err_msg := 'EXPIRED CARD';
            RAISE exp_reject_record ;
         END IF;
      EXCEPTION WHEN exp_reject_record THEN
               RAISE;
         WHEN OTHERS    THEN
            p_resp_code_out := '21';
            l_err_msg :='ERROR IN EXPIRY DATE CHECK ' || SUBSTR (SQLERRM, 1, 200);
           RAISE exp_reject_record;
      END;
      --Sn select authorization processe flag
      BEGIN
         SELECT ptp_param_value
           INTO l_precheck_flag
           FROM pcms_tranauth_param
          WHERE ptp_param_name = 'PRE CHECK' AND ptp_inst_code = p_inst_code_in;
      EXCEPTION
         WHEN OTHERS   THEN
            p_resp_code_out := '21';
            l_err_msg :=  'Error while selecting precheck flag' || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_record;
      END;
      --Sn check for precheck
      IF l_precheck_flag = 1  THEN
         BEGIN
            sp_precheck_txn (p_inst_code_in,
                             p_pan_code_in,
                             p_del_channel_in,
                             l_expry_date,
                             l_card_stat,
                             p_txn_code_in,
                             '0',--p_txn_mode_in,
                             p_business_date_in,
                             p_business_time_in,
                             l_tran_amt,
                             NULL,
                             NULL,
                             p_resp_code_out,
                             l_err_msg
                            );

            IF (p_resp_code_out <> '1' OR l_err_msg <> 'OK') THEN
               RAISE exp_reject_record;
            END IF;
         EXCEPTION WHEN exp_reject_record THEN
               RAISE;
            WHEN OTHERS   THEN
               p_resp_code_out := '21';
               l_err_msg := 'Error from precheck processes '  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;
      END IF;
   END IF;

/*
         BEGIN
            vmscommon.authorize_nonfinancial_txn (p_inst_code_in,
                                                  p_msg_type_in,
                                                  p_rrn_in,
                                                  p_del_channel_in,
                                                  p_txn_code_in,
                                                  '0',        --p_txn_mode_in,
                                                  p_business_date_in,
                                                  p_business_time_in,
                                                  '00',
                                                  l_txn_type,
                                                  p_pan_code_in,
                                                  l_hash_pan,
                                                  l_encr_pan,
                                                  l_spending_acct_no,--l_acct_no,
                                                  l_card_stat,
                                                  l_expry_date,
                                                  l_prod_code,
                                                  l_card_type,
                                                  l_prfl_flag,
                                                  l_prfl_code,
                                                  l_txn_type,
                                                  p_curr_code_in,
                                                  l_preauth_flag,
                                                  l_tran_desc,
                                                  l_cr_dr_flag,
                                                  l_login_txn,
                                                  p_resp_code_out,
                                                  l_err_msg,
                                                  l_comb_hash,
                                                  l_auth_id,
                                                  l_fee_code,
                                                  l_fee_plan,
                                                  l_feeattach_type,
                                                  l_tranfee_amt,
                                                  l_total_amt,
                                                  l_preauth_type
                                                 );

            IF l_err_msg <> 'OK'
            THEN
               RAISE exp_reject_record;
            END IF;
         EXCEPTION
            WHEN exp_reject_record
            THEN
               RAISE;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error from authorize_nonfinancial_txn '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;
*/
--EN Perform common validations

         -- SN Generate common select query
          BEGIN
          
            l_pending_select_query :=
                  ' select add_ins_date run_date,
                     time_stamp ts,
                     rrn id, 
                     to_char(add_ins_date, ''YYYY-MM-DD HH24:MI:SS'') transactionDate, 
                     ''Debit'' crdrFlag,
                     upper(trim(NVL(trans_desc,CTM_TRAN_DESC)))  transactionDescription,
                     TRIM(TO_CHAR (cpt_totalhold_amt, ''99999999999999990.99'')) transactionAmount,
                     reason reason,
                     --'''' checkDescription,
                     --'''' checkRoutingNumber,
                     --'''' checkAccountNumber,
                      '''' check_detls,
                      ''PENDING'' transactionType,
                     TRIM(TO_CHAR (ledger_balance, ''99999999999999990.99''))  ledgerBalance,
                     TRIM(TO_CHAR (acct_balance, ''99999999999999990.99''))  availableBalance,
                     customer_acct_no accountNumber,
                     topup_acct_no toAccountNumber,
                     substr(fn_dmaps_main(customer_card_no_encr),-4) lastFourPAN,
                     substr(fn_dmaps_main(topup_card_no_encr),-4)toLastFourPAN,
                     mccode MCCDescription,
                     merchant_id merchantID,
                     CASE
                      WHEN  delivery_channel = ''11'' 
                      THEN  REGEXP_REPLACE(NVL((DECODE(NVL(COMPANYNAME,''''),'''','''',''/''
                        ||''From ''||COMPANYNAME)
                        || DECODE(NVL(COMPENTRYDESC,''''),'''','''',''/''
                        ||COMPENTRYDESC)
                        || DECODE(NVL(INDNAME,''''),'''','''',''/''
                        ||INDIDNUM
                        ||'' to ''
                        ||INDNAME)),''Direct Deposit''),''/'','''',1,1)
                      ELSE NVL ( MERCHANT_NAME, DECODE (TRIM (CDM_CHANNEL_DESC), ''ATM'', ''ATM'', ''POS'', ''Retail Merchant'', ''IVR'', ''IVR Transfer'', ''CHW'', ''Card Holder website'', ''ACH'', ''Direct Deposit'', ''MOB'', ''Mobile Transfer'', ''CSR'', ''Customer Service'', ''System''))
                     END name,
                     merchant_street streetAddress,
                     merchant_city city,
                     merchant_zip postalCode,
                     merchant_state state,
                     country_code country,
                     terminal_id terminalId ';
                     
          EXCEPTION
          WHEN OTHERS
          THEN
             p_resp_code_out := '21';
             l_err_msg :=
                   'Error while executing l_pending_select_query '
                || SUBSTR (SQLERRM, 1, 200);
             RAISE exp_reject_record;                           
                     
          END;
          
          BEGIN
          
            l_pending_from_query := 
                   ' from   transactionlog,
                            cms_transaction_mast,
                            cms_preauth_transaction,
                            CMS_DELCHANNEL_MAST
                    where  customer_acct_no =:l_acct_no 
                      and CDM_CHANNEL_CODE = DELIVERY_CHANNEL
                      AND CDM_INST_CODE = INSTCODE
                      and  instcode = ctm_inst_code 
                      and  delivery_channel = ctm_delivery_channel 
                      and  txn_code = ctm_tran_code
                       and cpt_txn_code=txn_code
                     and cpt_delivery_channel=DELIVERY_CHANNEL
                      and  response_code = ''00''
                      and  customer_card_no = cpt_card_no
                      and  rrn = cpt_rrn
                      and  business_date = cpt_txn_date
                      and  business_time = cpt_txn_time
                      and CPT_TOTALHOLD_AMT       > 0
                      and cpt_expiry_flag       = ''N''
                      and cpt_preauth_validflag = ''Y''
                      and add_ins_date  between :l_start_date and :l_end_date ';
                    
          EXCEPTION
          WHEN OTHERS
          THEN
             p_resp_code_out := '21';
             l_err_msg :=
                   'Error while executing l_pending_from_query '
                || SUBSTR (SQLERRM, 1, 200);
             RAISE exp_reject_record;                       
          
          END;
          
          BEGIN
         -- Modified for vms-780 ,change is rrn to csl_rrn
             l_posted_select_query := 
                   ' select csl_ins_date run_date,
                    CSL_TIME_STAMP ts,
                    csl_rrn id,  
                    to_char(csl_ins_date, ''YYYY-MM-DD HH24:MI:SS'') transactionDate, 
                    decode(upper(CSL_TRANS_TYPE),''CR'',''Credit'',''DR'',''Debit'') crdrFlag,
                    DECODE ( NVL (REVERSAL_CODE, ''0''), ''0'', DECODE ( TXN_FEE_FLAG, ''Y'',
                                                  REPLACE(TRIM(UPPER(SUBSTR(CSL_TRANS_NARRRATION,0,DECODE(instr(CSL_TRANS_NARRRATION,'' - '',-1),0,LENGTH(CSL_TRANS_NARRRATION),instr(CSL_TRANS_NARRRATION,'' - '',-1))))),''CLAWBACK-'''',''), 
                                                  DECODE(upper(trim(NVL(trans_desc,CTM_TRAN_DESC))),upper(trim(CTM_TRAN_DESC)),ctm_display_txndesc,trans_desc))
                                                , DECODE ( TXN_FEE_FLAG, ''Y'', REPLACE(TRIM(UPPER(SUBSTR(CSL_TRANS_NARRRATION,0,DECODE(instr(CSL_TRANS_NARRRATION,'' - '',-1),0,LENGTH(CSL_TRANS_NARRRATION),instr(CSL_TRANS_NARRRATION,'' - '',-1))))),''CLAWBACK-'',''''), ''RVSL-''
                                                  ||
                                                  DECODE(upper(trim(NVL(trans_desc,CTM_TRAN_DESC))),upper(trim(CTM_TRAN_DESC)),ctm_display_txndesc,trans_desc))) 
                                                  || (
                                                  CASE
                                                      WHEN clawback_indicator = ''Y''
                                                      THEN
                                                        (
                                                        SELECT UPPER(DECODE(CPC_CLAWBACK_DESC,NULL,'''','' -''
                                                          || CPC_CLAWBACK_DESC))
                                                          ||rtrim(SUBSTR(CSL_TRANS_NARRRATION,instr(CSL_TRANS_NARRRATION,'' - '',-1)))
                                                          FROM CMS_PROD_CATTYPE
                                                       WHERE CPC_PROD_CODE = PRODUCTID
                                                        AND CPC_CARD_TYPE= CATEGORYID
                                                        AND CPC_INST_CODE=INSTCODE
                                                    ) 
                                                  ELSE DECODE (TXN_FEE_FLAG, ''Y'', '' - FEE'')
                                               END)    transactionDescription,
                    TRIM(TO_CHAR (nvl(csl_trans_amount,amount), ''99999999999999990.99'')) transactionAmount,
                    reason reason,
                    --ctd_check_desc checkDescription,
                    --ctd_routing_number checkRoutingNumber,
                    --ctd_check_acctno checkAccountNumber,
                    case when csl_delivery_channel = ''13'' then
                    (select ctd_check_desc||''~''||ctd_routing_number||''~''||ctd_check_acctno
                    from   cms_transaction_log_dtl
                    where   csl_rrn=ctd_rrn 
                    and csl_acct_no=ctd_cust_acct_number
                    and  csl_delivery_channel = ctd_delivery_channel
                    and  csl_txn_code = ctd_txn_code 
                    and  csl_business_date = ctd_business_date
                    and  csl_business_time = ctd_business_time
                    and rownum=1) end check_detls,
                    ''POSTED'' transactionType,
                    TRIM(TO_CHAR (nvl(csl_closing_balance,ledger_balance), ''99999999999999990.99''))  ledgerBalance,
                    TRIM(TO_CHAR (acct_balance, ''99999999999999990.99''))  availableBalance,
                    csl_acct_no accountNumber,
                    csl_to_acctno toAccountNumber,
                    CSL_PANNO_LAST4DIGIT lastFourPAN,
                    substr(fn_dmaps_main(topup_card_no_encr),-4)toLastFourPAN,
                    mccode MCCDescription,
                    merchant_id merchantID,
                    CASE
                      WHEN  csl_delivery_channel = ''11'' 
                      THEN  REGEXP_REPLACE(NVL((DECODE(NVL(COMPANYNAME,''''),'''','''',''/''
                        ||''From ''||COMPANYNAME)
                        || DECODE(NVL(COMPENTRYDESC,''''),'''','''',''/''
                        ||COMPENTRYDESC)
                        || DECODE(NVL(INDNAME,''''),'''','''',''/''
                        ||INDIDNUM
                        ||'' to ''
                        ||INDNAME)),''Direct Deposit''),''/'','''',1,1)
                      ELSE NVL ( CSL_MERCHANT_NAME, DECODE (TRIM (CDM_CHANNEL_DESC), ''ATM'', ''ATM'', ''POS'', ''Retail Merchant'', ''IVR'', ''IVR Transfer'', ''CHW'', ''Card Holder website'', ''ACH'', ''Direct Deposit'', ''MOB'', ''Mobile Transfer'', ''CSR'', ''Customer Service'', ''System'')) 
                    END name,
                    merchant_street streetAddress,
                    merchant_city city,
                    merchant_zip postalCode,
                    merchant_state state,
                    country_code country,
                    terminal_id terminalId ';
                    
          EXCEPTION
          WHEN OTHERS
          THEN
             p_resp_code_out := '21';
             l_err_msg :=
                   'Error while executing l_posted_select_query '
                || SUBSTR (SQLERRM, 1, 200);
             RAISE exp_reject_record;                        
          
          END;
          
          BEGIN
          
             l_posted_from_query := 
                  ' from   transactionlog,
                          -- cms_transaction_log_dtl,
                           cms_transaction_mast,
                           cms_statements_log,
                           CMS_DELCHANNEL_MAST
                    where  csl_acct_no = :l_acct_no  
                    --  and  csl_rrn = ctd_rrn 
                    --  and  csl_delivery_channel = ctd_delivery_channel
                      and CDM_CHANNEL_CODE = CSL_DELIVERY_CHANNEL
                      AND CDM_INST_CODE = CSL_INST_CODE
                    --  and  csl_txn_code = ctd_txn_code
                    --  and  csl_business_date = ctd_business_date
                    --  and  csl_business_time = ctd_business_time
                    --and  ctd_process_flag IN ( ''Y'' , ''C'') modified for vms-780:to include decline fee record
                      and  csl_inst_code = ctm_inst_code 
                      and  csl_delivery_channel = ctm_delivery_channel 
                      and  csl_txn_code = ctm_tran_code
                      and  CSL_PAN_NO= customer_card_no (+)
                      and  csl_rrn = rrn(+) 
                      and  CSL_TXN_CODE = txn_code(+) 
                      and  CSL_DELIVERY_CHANNEL= delivery_channel (+)
                      and  CSL_AUTH_ID= AUTH_ID (+)
                     --and  (response_code = ''00'' or response_code is null) modified for vms-780:to include decline fee record
                      and  csl_ins_date  between :l_start_date and :l_end_date ';

                      
          EXCEPTION
          WHEN OTHERS
          THEN
             p_resp_code_out := '21';
             l_err_msg :=
                   'Error while executing l_posted_from_query '
                || SUBSTR (SQLERRM, 1, 200);
             RAISE exp_reject_record;               
          
          END;
 		  -- EN Generate common select query

  -- SN Open cursor to execute query
         BEGIN
            IF l_no_of_records IS NOT NULL
            THEN
                 IF l_tran_filter = 'PENDING' 
                 THEN
        
                       l_exec_query := l_pending_select_query||l_pending_from_query;
        
                        BEGIN
                        
                             l_exec_query := ' select * from(select b.*,rownum r from ( '
                                             || l_exec_query
                                             || ' order by run_date desc,  ts desc
                                                )b) WHERE r<= :l_no_of_records ';
                                              
                             OPEN p_transaction_out FOR l_exec_query
                             USING l_acct_no, l_start_date, l_end_date,l_no_of_records;
                          
                              
                         EXCEPTION
                            WHEN OTHERS
                            THEN
                               p_resp_code_out := '21';
                               l_err_msg :=
                                     'Error while executing l_exec_query '
                                  || SUBSTR (SQLERRM, 1, 200);
                               RAISE exp_reject_record;
                         END;  
        
                ELSIF l_tran_filter = 'POSTED' THEN
     
                       l_exec_query := l_posted_select_query || l_posted_from_query;
                      
                       BEGIN
                      
                           l_exec_query := ' select * from(select b.*,rownum r from ( '
                                           || l_exec_query
                                           || ' order by run_date desc,  ts desc
                                              )b) WHERE r<= :l_no_of_records ';
                                              
                           OPEN p_transaction_out FOR l_exec_query
                           USING l_acct_no, l_start_date, l_end_date,l_no_of_records;
                        
                            
                       EXCEPTION
                          WHEN OTHERS
                          THEN
                             p_resp_code_out := '21';
                             l_err_msg :=
                                   'Error while executing l_exec_query '
                                || SUBSTR (SQLERRM, 1, 200);
                             RAISE exp_reject_record;
                       END;  
        
               ELSE 
             
                      l_exec_query :=  l_pending_select_query||l_pending_from_query
                                       || ' union '
                                       || l_posted_select_query||l_posted_from_query;
                                       
                      BEGIN
                      
                           l_exec_query := ' select * from(select b.*,rownum r from ( '
                                           || l_exec_query
                                           || ' order by run_date desc,  ts desc
                                              )b) WHERE r<= :l_no_of_records ';
                                             
                           OPEN p_transaction_out FOR l_exec_query
                           USING l_acct_no, l_start_date, l_end_date,
                                 l_acct_no, l_start_date, l_end_date,l_no_of_records;
                        
                            
                       EXCEPTION
                          WHEN OTHERS
                          THEN
                             p_resp_code_out := '21';
                             l_err_msg :=
                                   'Error while executing l_exec_query '
                                || SUBSTR (SQLERRM, 1, 200);
                             RAISE exp_reject_record;
                       END;                 
                                 
                END IF;   

            ELSE
                 IF l_tran_filter = 'PENDING' 
                 THEN
        
                       l_exec_query := l_pending_select_query||l_pending_from_query;
        
                        BEGIN
                        
                             l_exec_query := ' select * from( '
                                             || l_exec_query
                                             || ' )order by run_date desc,  ts desc ';
                                                
                             OPEN p_transaction_out FOR l_exec_query
                             USING l_acct_no, l_start_date, l_end_date;
                          
                              
                         EXCEPTION
                            WHEN OTHERS
                            THEN
                               p_resp_code_out := '21';
                               l_err_msg :=
                                     'Error while executing l_exec_query '
                                  || SUBSTR (SQLERRM, 1, 200);
                               RAISE exp_reject_record;
                         END;  
        
                ELSIF l_tran_filter = 'POSTED' THEN
     
                       l_exec_query := l_posted_select_query || l_posted_from_query;
                      
                       BEGIN
                      
                           l_exec_query := ' select * from( '
                                           || l_exec_query
                                           || ' )order by run_date desc,  ts desc ';
                                             
                           OPEN p_transaction_out FOR l_exec_query
                           USING l_acct_no, l_start_date, l_end_date;
                        
                            
                       EXCEPTION
                          WHEN OTHERS
                          THEN
                             p_resp_code_out := '21';
                             l_err_msg :=
                                   'Error while executing l_exec_query '
                                || SUBSTR (SQLERRM, 1, 200);
                             RAISE exp_reject_record;
                       END;  
        
               ELSE 
             
                      l_exec_query :=  l_pending_select_query||l_pending_from_query
                                       || ' union '
                                       || l_posted_select_query||l_posted_from_query;
                                       
                      BEGIN
                      
                           l_exec_query := ' select * from( '
                                           || l_exec_query
                                           || ' )order by run_date desc,  ts desc ';
                                              
                           OPEN p_transaction_out FOR l_exec_query
                           USING l_acct_no, l_start_date, l_end_date,
                                 l_acct_no, l_start_date, l_end_date;
                        
                            
                       EXCEPTION
                          WHEN OTHERS
                          THEN
                             p_resp_code_out := '21';
                             l_err_msg :=
                                   'Error while executing l_exec_query '
                                || SUBSTR (SQLERRM, 1, 200);
                             RAISE exp_reject_record;
                       END;                 
                                 
                END IF;   
            END IF;
           
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error while executing query '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;

-- EN Open cursor to execute query
   

          p_resp_code_out := '1';


      EXCEPTION                                         --<<Main Exception>>--
         WHEN exp_reject_record
         THEN
               p_resp_msg_out := l_err_msg;
 
         WHEN OTHERS
         THEN
            p_resp_msg_out := 'Other Excp-' || SUBSTR (SQLERRM, 1, 300);
            p_resp_code_out := '89';
      END;
      
        BEGIN
            SELECT cms_iso_respcde
              INTO p_resp_code_out
              FROM cms_response_mast
             WHERE cms_inst_code = p_inst_code_in
               AND cms_delivery_channel = p_del_channel_in
               AND cms_response_id = TO_NUMBER (p_resp_code_out);
         EXCEPTION
            WHEN OTHERS
            THEN
               l_err_msg :=
                     'Problem while selecting data from response master for respose code'
                  || p_resp_code_out
                  || ' is-'
                  || SUBSTR (SQLERRM, 1, 300);
               p_resp_code_out := '69';
         END;
         
      BEGIN
         l_hashkey_id :=
            gethash (   p_del_channel_in
                     || p_txn_code_in
                     || p_pan_code_in
                     || p_rrn_in
                     || TO_CHAR (NVL (l_timestamp, SYSTIMESTAMP),
                                 'YYYYMMDDHH24MISSFF5'
                                )
                    );
      EXCEPTION
         WHEN OTHERS
         THEN
            p_resp_code_out := '21';
            p_resp_msg_out :=
                  'Error while generating hashkey_id- '
               || SUBSTR (SQLERRM, 1, 200);
      END;
      
      BEGIN
          
          SELECT CAM_ACCT_BAL,CAM_LEDGER_BAL,CAM_TYPE_CODE
          INTO   l_acct_bal,l_ledger_bal,l_acct_type
          FROM   CMS_ACCT_MAST
          WHERE  CAM_INST_CODE = p_inst_code_in
          AND    CAM_ACCT_NO = l_acct_no;
      
      EXCEPTION
            WHEN NO_DATA_FOUND    THEN
               p_resp_code_out := '21';
               l_err_msg := 'Invalid Card number ' ;
         WHEN OTHERS
        THEN
           p_resp_code_out := '12';
           l_err_msg :=
                   'Error in account details' || SUBSTR (SQLERRM, 1, 200);
      END;
      

-- SN Log into transaction log and cms_transaction_log_dtl
      BEGIN
         vms_log.log_transactionlog (p_inst_code_in,
                                     p_msg_type_in,
                                     p_rrn_in,
                                     p_del_channel_in,
                                     p_txn_code_in,
                                     l_txn_type,
                                     '0',                          
                                     p_business_date_in,
                                     p_business_time_in,
                                     '00',
                                     l_hash_pan,
                                     l_encr_pan,
                                     p_resp_msg_out,
                                     p_ip_addr_in,
                                     l_card_stat,
                                     l_tran_desc,
                                     p_ani_in,
                                     p_dni_in,
                                     l_timestamp,
                                     l_acct_no,
                                     l_prod_code,
                                     l_card_type,
                                     l_cr_dr_flag,
                                     l_acct_bal,
                                     l_ledger_bal,
                                     l_acct_type,
                                     l_proxy_number,
                                     l_auth_id,
                                     0,
                                     l_total_amt,
                                     l_fee_code,
                                     l_tranfee_amt,
                                     l_fee_plan,
                                     l_feeattach_type,
                                     p_resp_code_out,
                                     p_resp_code_out,
                                     p_curr_code_in,
                                     l_hashkey_id,
                                     p_uuid_in,
                                     p_osname_in,
                                     p_osversion_in,
                                     p_gpscoordinates_in,
                                     p_displayresolution_in,
                                     p_physicalmemory_in,
                                     p_appname_in,
                                     p_appversion_in,
                                     p_sessionid_in,
                                     p_devicecountry_in,
                                     p_deviceregion_in,
                                     p_ipcountry_in,
                                     p_proxy_in,
                                     p_partner_id_in,
                                     l_err_msg
                                    );
      EXCEPTION
         WHEN OTHERS
         THEN
            p_resp_code_out := '69';
            l_err_msg :=
                  'Exception while inserting to transaction log '
               || SUBSTR (SQLERRM, 1, 300);
      END;
-- EN Log into transaction log and cms_transaction_log_dtl
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         p_resp_code_out := '89';
         p_resp_msg_out := 'Main Excp- ' || SUBSTR (SQLERRM, 1, 300);
   END get_transaction_history;
   
   PROCEDURE get_transaction_history_v2 (
       p_inst_code_in               IN   VARCHAR2,
       p_del_channel_in             IN   VARCHAR2,
       p_txn_code_in                IN   VARCHAR2,
       p_rrn_in                     IN   VARCHAR2,
       p_src_app_in                 IN   VARCHAR2,
       p_partner_id_in              IN   VARCHAR2,
       p_business_date_in           IN   VARCHAR2,
       p_business_time_in           IN   VARCHAR2,
       p_curr_code_in               IN   VARCHAR2,
       p_reversal_code_in           IN   VARCHAR2,
       p_msg_type_in                IN   VARCHAR2,
       p_ip_addr_in                 IN   VARCHAR2,
       p_ani_in                     IN   VARCHAR2,
       p_dni_in                     IN   VARCHAR2,
       p_dev_mob_no_in              IN   VARCHAR2,
       p_device_id_in               IN   VARCHAR2,
       p_uuid_in                    IN   VARCHAR2,
       p_osname_in                  IN   VARCHAR2,
       p_osversion_in               IN   VARCHAR2,
       p_gpscoordinates_in          IN   VARCHAR2,
       p_displayresolution_in       IN   VARCHAR2,
       p_physicalmemory_in          IN   VARCHAR2,
       p_appname_in                 IN   VARCHAR2,
       p_appversion_in              IN   VARCHAR2,
       p_sessionid_in               IN   VARCHAR2,
       p_devicecountry_in           IN   VARCHAR2,
       p_deviceregion_in            IN   VARCHAR2,
       p_ipcountry_in               IN   VARCHAR2,
       p_proxy_in                   IN   VARCHAR2,
       p_cust_id_in                 IN   VARCHAR2,
       p_pan_code_in                IN   VARCHAR2,
       p_start_date_in              IN   VARCHAR2,
       p_end_date_in                IN   VARCHAR2,
       p_account_type_in            IN   VARCHAR2,
       p_tran_filter_in             IN   VARCHAR2,
       p_no_of_records_in           IN   VARCHAR2,
       p_pagenumber_in              IN   VARCHAR2,
       p_resp_code_out              OUT  VARCHAR2,
       p_resp_msg_out               OUT  VARCHAR2,
       p_total_records_out          OUT  VARCHAR2,
       p_total_debit_amount_out     OUT  VARCHAR2,
       p_total_credit_amount_out    OUT  VARCHAR2,
       p_total_pending_amount_out   OUT  VARCHAR2,
       p_transaction_out            OUT  SYS_REFCURSOR
   )
   AS
      l_start_date                DATE;
      l_end_date                  DATE;
      l_account_type              VARCHAR2 (100)
                                              := NVL (UPPER (p_account_type_in), 'SPENDING');
      l_tran_filter               VARCHAR2 (100)
                                              := NVL (UPPER (p_tran_filter_in), 'ALL');
      l_no_of_records             VARCHAR2 (5)   := p_no_of_records_in;
      l_pagenumber                NUMBER;
      l_rec_start_no              NUMBER;
      l_rec_end_no                NUMBER;
      l_total_pending_count       NUMBER;
      l_total_posted_count        NUMBER;
      l_total_pending_amount      NUMBER;
      l_total_credit_amount       NUMBER;
      l_total_debit_amount        NUMBER;
      l_total_select_query        VARCHAR2 (10000);
      l_pending_select_query      VARCHAR2 (10000);
      l_pending_from_query        VARCHAR2 (10000);
      l_posted_select_query       VARCHAR2 (10000);
      l_posted_from_query         VARCHAR2 (10000);
      l_pending_total_query       VARCHAR2 (10000);
      l_posted_total_query        VARCHAR2 (10000);
      l_exec_query                VARCHAR2 (20000);
      l_tot_pend_exec_query       VARCHAR2 (10000);
      l_tot_post_exec_query       VARCHAR2 (10000);
      l_err_msg                   VARCHAR2 (1000);
      l_txn_type                  VARCHAR2 (2);
      l_hash_pan          cms_appl_pan.cap_pan_code%TYPE;
      l_encr_pan          cms_appl_pan.cap_pan_code_encr%TYPE;
      l_acct_no           cms_appl_pan.cap_acct_no%TYPE;
      l_card_stat         cms_appl_pan.cap_card_stat%TYPE;
      l_prod_code         cms_appl_pan.cap_prod_code%TYPE;
      l_card_type         cms_appl_pan.cap_card_type%TYPE;
      l_expry_date        cms_appl_pan.cap_expry_date%TYPE;
      l_prfl_code         cms_appl_pan.cap_prfl_code%TYPE;
      l_proxy_number      cms_appl_pan.cap_proxy_number%TYPE;
      l_cr_dr_flag        cms_transaction_mast.ctm_credit_debit_flag%TYPE;
      l_tran_desc         cms_transaction_mast.ctm_tran_desc%TYPE;
      l_prfl_flag         cms_transaction_mast.ctm_prfl_flag%TYPE;
      l_preauth_flag      cms_transaction_mast.ctm_preauth_flag%TYPE;
      l_login_txn         cms_transaction_mast.ctm_login_txn%TYPE;
      l_preauth_type      cms_transaction_mast.ctm_preauth_type%TYPE;
      l_dup_rrn_check     cms_transaction_mast.ctm_rrn_check%TYPE;
      l_acct_bal          cms_acct_mast.cam_acct_bal%TYPE;
      l_ledger_bal        cms_acct_mast.cam_ledger_bal%TYPE;
      l_acct_type         cms_acct_mast.cam_type_code%TYPE;
      l_auth_id           transactionlog.auth_id%TYPE;
      l_fee_code          transactionlog.feecode%TYPE;
      l_fee_plan          transactionlog.fee_plan%TYPE;
      l_feeattach_type    transactionlog.feeattachtype%TYPE;
      l_tranfee_amt       transactionlog.tranfee_amt%TYPE;
      l_total_amt         transactionlog.total_amount%TYPE;
      l_hashkey_id        cms_transaction_log_dtl.ctd_hashkey_id%TYPE;
      l_tran_amt          cms_acct_mast.cam_acct_bal%TYPE;
      l_comb_hash         pkg_limits_check.type_hash;
      l_timestamp         TIMESTAMP;
      exp_reject_record   EXCEPTION;
      l_spending_acct_no  cms_acct_mast.cam_acct_no%TYPE;
      l_cust_code         cms_appl_pan.cap_cust_code%TYPE;
      l_status_chk        PLS_INTEGER;
      l_precheck_flag     PLS_INTEGER;
/*************************************************
  * Modified By       : Sivakumar M
  * Modified Date     : 08-Feb-2019 
  * Purpose           : VMS-780 
  * Reviewer          : Saravanakumar
  * Build Number      : VMSR12-B0003
  
  * Modified By      : Sivakumar M
  * Modified Date    : 23-May-2019
  * Purpose          : VMS-922
  * Reviewer         : Saravanan
  * Release Number   : VMSGPRHOST R16
*************************************************/
   BEGIN
      BEGIN
      p_resp_msg_out :='success';


-- SN Get PAN Details
         BEGIN
         SELECT cap_pan_code, cap_pan_code_encr, cap_acct_no,
                cap_card_stat, cap_prod_code, cap_card_type,
                cap_expry_date,  cap_prfl_code,  cap_proxy_number,cap_cust_code
           INTO l_hash_pan, l_encr_pan, l_acct_no,
                l_card_stat, l_prod_code, l_card_type,
                l_expry_date,  l_prfl_code, l_proxy_number,l_cust_code
           FROM cms_appl_pan
          WHERE cap_inst_code = p_inst_code_in
            AND cap_pan_code = gethash (p_pan_code_in)
            AND cap_mbr_numb = '000';


         EXCEPTION
            WHEN NO_DATA_FOUND    THEN
               p_resp_code_out := '21';
               l_err_msg := 'Invalid Card number ' || gethash (p_pan_code_in);
               RAISE exp_reject_record;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error while getting PAN details  '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;

-- EN Get PAN Details


 l_spending_acct_no := l_acct_no;
--Sn Validating Savings Account type
 IF upper(p_account_type_in) = 'SAVINGS'
 THEN
    BEGIN
         SELECT cam_acct_no
         INTO l_acct_no
         FROM CMS_ACCT_MAST
         WHERE cam_inst_code = p_inst_code_in
         AND cam_type_code = '2'
         AND cam_acct_id   in (select cca_acct_id from cms_cust_acct where cca_cust_code = l_cust_code);

    EXCEPTION
             WHEN NO_DATA_FOUND    THEN
                 p_resp_code_out := '21';
                 l_err_msg := 'Saving account not created ' ;
                 RAISE exp_reject_record;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                   'Error in getting savings account number' || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
    END;
 END IF;
--En Validating Account type

         -- SN Get Transaction details
         BEGIN
            vmscommon.get_transaction_details (p_inst_code_in,
                                               p_del_channel_in,
                                               p_txn_code_in,
                                               l_cr_dr_flag,
                                               l_txn_type,
                                               l_tran_desc,
                                               l_prfl_flag,
                                               l_preauth_flag,
                                               l_login_txn,
                                               l_preauth_type,
                                               l_dup_rrn_check,
                                               p_resp_code_out,
                                               l_err_msg
                                              );

            IF l_err_msg <> 'OK'
            THEN
               RAISE exp_reject_record;
            END IF;
         EXCEPTION
            WHEN exp_reject_record
            THEN
               RAISE;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error while getting Transaction details  '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;

-- EN Get Transaction details

         -- SN Validate date and RRN
         IF l_dup_rrn_check = 'Y' THEN
         BEGIN
            vmscommon.validate_date_rrn (p_inst_code_in,
                                         p_rrn_in,
                                         p_business_date_in,
                                         p_business_time_in,
                                         p_del_channel_in,
                                         l_err_msg,
                                         p_resp_code_out
                                        );

            IF l_err_msg <> 'OK'
            THEN
               RAISE exp_reject_record;
            END IF;
         EXCEPTION
            WHEN exp_reject_record
            THEN
               RAISE;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error while validating date and RRN  '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;
         END IF;
-- EN Validate date and RRN



-- SN Get start and end date
         BEGIN
       IF  (p_no_of_records_in IS NOT NULL AND p_pagenumber_in IS NOT NULL) AND ( p_start_date_in IS NULL AND p_end_date_in IS NULL) THEN
       
         l_start_date :=null;
         l_end_date :=null;
        ELSE
         
            IF p_start_date_in IS NULL
            THEN
               IF p_end_date_in IS NULL
               THEN
                  l_end_date :=
                     TO_DATE ((   TO_CHAR (TRUNC (SYSDATE), 'YYYYMMDD')
                               || ' 235959'
                              ),
                              'YYYYMMDD HH24MISS'
                             );
               ELSE
                  l_end_date :=
                     TO_DATE ((p_end_date_in || ' 235959'),
                              'YYYY-MM-DD HH24MISS'
                             );
               END IF;

               l_start_date :=
                  TO_DATE ((   TO_CHAR (TRUNC (l_end_date) - 30, 'YYYYMMDD')
                            || ' 000000'
                           ),
                           'YYYYMMDD HH24MISS'
                          );
            ELSIF p_start_date_in IS NOT NULL
            THEN
               l_start_date :=
                  TO_DATE ((p_start_date_in || ' 000000'),
                           'YYYY-MM-DD HH24MISS'
                          );

               IF p_end_date_in IS NULL
               THEN
                  l_end_date :=
                     TO_DATE ((   TO_CHAR (TRUNC (l_start_date) + 30,
                                           'YYYYMMDD'
                                          )
                               || ' 235959'
                              ),
                              'YYYYMMDD HH24MISS'
                             );
               ELSE
                  l_end_date :=
                     TO_DATE ((p_end_date_in || ' 235959'),
                              'YYYY-MM-DD HH24MISS'
                             );
               END IF;
            END IF;
            
        END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg := 'Invalid Date';
               RAISE exp_reject_record;
         END;
-- SN Get start and end date

--SN Validating Date

        IF p_start_date_in > p_end_date_in
        THEN
            p_resp_code_out := '21';
            l_err_msg := 'End Date must be greater then Start Date';
            RAISE exp_reject_record;
        END IF;

--EN Validating Date
         
         
       	BEGIN
              IF ((p_no_of_records_in IS NOT NULL AND p_pagenumber_in IS NULL) OR 
                 (p_no_of_records_in IS NULL AND p_pagenumber_in IS NOT NULL)  OR (p_no_of_records_in='0' or p_pagenumber_in='0' ))
              THEN 
                 p_resp_code_out := '313';
                 l_err_msg :='No of records / page number should not be null';
                 RAISE exp_reject_record;
          	END IF;		 
        	EXCEPTION WHEN exp_reject_record then
               raise;
              WHEN OTHERS
              THEN
                 p_resp_code_out := '21';
                 l_err_msg :=
                       'Error while checking records and pagenumber validation '
                    || SUBSTR (SQLERRM, 1, 200);
                 RAISE exp_reject_record;
       END;	 
       
-- EN Get start and end date
        l_no_of_records  := nvl(p_no_of_records_in,
                                1000);
        l_pagenumber     := nvl(p_pagenumber_in,
                                1);
        l_rec_end_no     := l_no_of_records * l_pagenumber;
        l_rec_start_no   := (l_rec_end_no - l_no_of_records) + 1;
        
  

         -- SN Validate account type and transaction filter
         BEGIN
            IF (l_account_type NOT IN ('SPENDING', 'SAVINGS'))
            THEN
               p_resp_code_out := '21';
               RAISE exp_reject_record;
            END IF;

            IF (l_tran_filter NOT IN ('ALL', 'POSTED', 'PENDING'))
            THEN
               p_resp_code_out := '21';
               RAISE exp_reject_record;
            END IF;
         EXCEPTION
            WHEN exp_reject_record
            THEN
               l_err_msg :=
                     'Error in Input Data - Account Type or Transaction Filter'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error in Input Data - Account Type or Transaction Filter'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;

-- EN Validate account type and transaction filter



--SN Perform common validations

BEGIN
      sp_status_check_gpr (p_inst_code_in,
                           p_pan_code_in,
                           p_del_channel_in,
                           l_expry_date,
                           l_card_stat,
                           p_txn_code_in,
                           '0',--p_txn_mode_in',
                           l_prod_code,
                           l_card_type,
                           p_msg_type_in,
                           p_business_date_in,
                           p_business_time_in,
                           NULL,
                           NULL,
                           NULL,
                           p_resp_code_out,
                           l_err_msg
                          );

      IF (   (p_resp_code_out <> '1' AND l_err_msg <> 'OK')
          OR (p_resp_code_out <> '0' AND l_err_msg <> 'OK'))  THEN
         RAISE exp_reject_record;
      ELSE
         l_status_chk := p_resp_code_out;
         p_resp_code_out := '1';
      END IF;
   EXCEPTION  WHEN exp_reject_record THEN
        RAISE;
      WHEN OTHERS  THEN
         p_resp_code_out := '21';
         l_err_msg :=  'Error from GPR Card Status Check '|| SUBSTR (SQLERRM, 1, 200);
         RAISE exp_reject_record;
   END;

   --En GPR Card status check
   IF l_status_chk = '1'
   THEN
      -- Expiry Check
      BEGIN
         IF TO_DATE (p_business_date_in, 'YYYYMMDD') >  LAST_DAY (TO_CHAR (l_expry_date, 'DD-MON-YY'))
         THEN
            p_resp_code_out := '13';
            l_err_msg := 'EXPIRED CARD';
            RAISE exp_reject_record ;
         END IF;
      EXCEPTION WHEN exp_reject_record THEN
               RAISE;
         WHEN OTHERS    THEN
            p_resp_code_out := '21';
            l_err_msg :='ERROR IN EXPIRY DATE CHECK ' || SUBSTR (SQLERRM, 1, 200);
           RAISE exp_reject_record;
      END;
      --Sn select authorization processe flag
      BEGIN
         SELECT ptp_param_value
           INTO l_precheck_flag
           FROM pcms_tranauth_param
          WHERE ptp_param_name = 'PRE CHECK' AND ptp_inst_code = p_inst_code_in;
      EXCEPTION
         WHEN OTHERS   THEN
            p_resp_code_out := '21';
            l_err_msg :=  'Error while selecting precheck flag' || SUBSTR (SQLERRM, 1, 200);
            RAISE exp_reject_record;
      END;
      --Sn check for precheck
      IF l_precheck_flag = 1  THEN
         BEGIN
            sp_precheck_txn (p_inst_code_in,
                             p_pan_code_in,
                             p_del_channel_in,
                             l_expry_date,
                             l_card_stat,
                             p_txn_code_in,
                             '0',--p_txn_mode_in,
                             p_business_date_in,
                             p_business_time_in,
                             l_tran_amt,
                             NULL,
                             NULL,
                             p_resp_code_out,
                             l_err_msg
                            );

            IF (p_resp_code_out <> '1' OR l_err_msg <> 'OK') THEN
               RAISE exp_reject_record;
            END IF;
         EXCEPTION WHEN exp_reject_record THEN
               RAISE;
            WHEN OTHERS   THEN
               p_resp_code_out := '21';
               l_err_msg := 'Error from precheck processes '  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;
      END IF;
   END IF;
   
   /*
         BEGIN
            vmscommon.authorize_nonfinancial_txn (p_inst_code_in,
                                                  p_msg_type_in,
                                                  p_rrn_in,
                                                  p_del_channel_in,
                                                  p_txn_code_in,
                                                  '0',        --p_txn_mode_in,
                                                  p_business_date_in,
                                                  p_business_time_in,
                                                  '00',
                                                  l_txn_type,
                                                  p_pan_code_in,
                                                  l_hash_pan,
                                                  l_encr_pan,
                                                  l_spending_acct_no,--l_acct_no,
                                                  l_card_stat,
                                                  l_expry_date,
                                                  l_prod_code,
                                                  l_card_type,
                                                  l_prfl_flag,
                                                  l_prfl_code,
                                                  l_txn_type,
                                                  p_curr_code_in,
                                                  l_preauth_flag,
                                                  l_tran_desc,
                                                  l_cr_dr_flag,
                                                  l_login_txn,
                                                  p_resp_code_out,
                                                  l_err_msg,
                                                  l_comb_hash,
                                                  l_auth_id,
                                                  l_fee_code,
                                                  l_fee_plan,
                                                  l_feeattach_type,
                                                  l_tranfee_amt,
                                                  l_total_amt,
                                                  l_preauth_type
                                                 );

            IF l_err_msg <> 'OK'
            THEN
               RAISE exp_reject_record;
            END IF;
         EXCEPTION
            WHEN exp_reject_record
            THEN
               RAISE;
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error from authorize_nonfinancial_txn '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;
*/
--EN Perform common validations

        -- SN Generate common select query
          BEGIN
          
            l_pending_select_query :=
                   ' select add_ins_date run_date,
                     time_stamp ts,
                     rrn id, 
                     to_char(add_ins_date, ''YYYY-MM-DD HH24:MI:SS'') transactionDate, 
                     ''Debit'' crdrFlag,
                     upper(trim(NVL(trans_desc,CTM_TRAN_DESC)))  transactionDescription,
                     TRIM(TO_CHAR (cpt_totalhold_amt, ''99999999999999990.99'')) transactionAmount,
                     reason reason,
                     --'''' checkDescription,
                     --'''' checkRoutingNumber,
                     --'''' checkAccountNumber,
                     '''' check_detls,
                     ''PENDING'' transactionType,
                     TRIM(TO_CHAR (ledger_balance, ''99999999999999990.99''))  ledgerBalance,
                     TRIM(TO_CHAR (acct_balance, ''99999999999999990.99''))  availableBalance,
                     customer_acct_no accountNumber,
                     topup_acct_no toAccountNumber,
                     substr(fn_dmaps_main(customer_card_no_encr),-4) lastFourPAN,
                     substr(fn_dmaps_main(topup_card_no_encr),-4)toLastFourPAN,
                     mccode MCCDescription,
                     merchant_id merchantID,
                     CASE
                      WHEN  delivery_channel = ''11'' 
                      THEN  REGEXP_REPLACE(NVL((DECODE(NVL(COMPANYNAME,''''),'''','''',''/''
                        ||''From ''||COMPANYNAME)
                        || DECODE(NVL(COMPENTRYDESC,''''),'''','''',''/''
                        ||COMPENTRYDESC)
                        || DECODE(NVL(INDNAME,''''),'''','''',''/''
                        ||INDIDNUM
                        ||'' to ''
                        ||INDNAME)),''Direct Deposit''),''/'','''',1,1)
                      ELSE NVL ( MERCHANT_NAME, DECODE (TRIM (CDM_CHANNEL_DESC), ''ATM'', ''ATM'', ''POS'', ''Retail Merchant'', ''IVR'', ''IVR Transfer'', ''CHW'', ''Card Holder website'', ''ACH'', ''Direct Deposit'', ''MOB'', ''Mobile Transfer'', ''CSR'', ''Customer Service'', ''System''))
                     END name,
                     merchant_street streetAddress,
                     merchant_city city,
                     merchant_zip postalCode,
                     merchant_state state,
                     country_code country,
                     terminal_id terminalId ';
                     
          EXCEPTION
          WHEN OTHERS
          THEN
             p_resp_code_out := '21';
             l_err_msg :=
                   'Error while executing l_pending_select_query '
                || SUBSTR (SQLERRM, 1, 200);
             RAISE exp_reject_record;                           
                     
          END;
          
          BEGIN
          
            l_pending_from_query := 
                   ' from   transactionlog,
                            cms_transaction_mast,
                            cms_preauth_transaction,
                            CMS_DELCHANNEL_MAST
                    where  customer_acct_no =:l_acct_no 
                      and CDM_CHANNEL_CODE = DELIVERY_CHANNEL
                      AND CDM_INST_CODE = INSTCODE
                      and  instcode = ctm_inst_code 
                      and  delivery_channel = ctm_delivery_channel 
                      and  txn_code = ctm_tran_code
                       and cpt_txn_code=txn_code
                     and cpt_delivery_channel=DELIVERY_CHANNEL
                      and  response_code = ''00''
                      and  customer_card_no = cpt_card_no
                      and  rrn = cpt_rrn
                      and  business_date = cpt_txn_date
                      and  business_time = cpt_txn_time
                      and CPT_TOTALHOLD_AMT       > 0
                      and cpt_expiry_flag       = ''N''
                      and cpt_preauth_validflag = ''Y'' ';
                      
                      IF l_start_date is not null and  l_end_date is not null then
                      l_pending_from_query:= l_pending_from_query||' and add_ins_date  between :l_start_date and :l_end_date ';
                      end if;
                    
          EXCEPTION
          WHEN OTHERS
          THEN
             p_resp_code_out := '21';
             l_err_msg :=
                   'Error while executing l_pending_from_query '
                || SUBSTR (SQLERRM, 1, 200);
             RAISE exp_reject_record;                       
          
          END;
          
          BEGIN
          -- Modified for vms-780 ,change is rrn to csl_rrn
             l_posted_select_query := 
                  ' select csl_ins_date run_date,
                    CSL_TIME_STAMP ts,
                    csl_rrn id, 
                    to_char(csl_ins_date, ''YYYY-MM-DD HH24:MI:SS'') transactionDate, 
                    decode(upper(CSL_TRANS_TYPE),''CR'',''Credit'',''DR'',''Debit'') crdrFlag,
                    DECODE ( NVL (REVERSAL_CODE, ''0''), ''0'', DECODE ( TXN_FEE_FLAG, ''Y'',
                                                  REPLACE(TRIM(UPPER(SUBSTR(CSL_TRANS_NARRRATION,0,DECODE(instr(CSL_TRANS_NARRRATION,'' - '',-1),0,LENGTH(CSL_TRANS_NARRRATION),instr(CSL_TRANS_NARRRATION,'' - '',-1))))),''CLAWBACK-'''',''), 
                                                  DECODE(upper(trim(NVL(trans_desc,CTM_TRAN_DESC))),upper(trim(CTM_TRAN_DESC)),ctm_display_txndesc,trans_desc))
                                                , DECODE ( TXN_FEE_FLAG, ''Y'', REPLACE(TRIM(UPPER(SUBSTR(CSL_TRANS_NARRRATION,0,DECODE(instr(CSL_TRANS_NARRRATION,'' - '',-1),0,LENGTH(CSL_TRANS_NARRRATION),instr(CSL_TRANS_NARRRATION,'' - '',-1))))),''CLAWBACK-'',''''), ''RVSL-''
                                                  ||
                                                  DECODE(upper(trim(NVL(trans_desc,CTM_TRAN_DESC))),upper(trim(CTM_TRAN_DESC)),ctm_display_txndesc,trans_desc))) 
                                                  || (
                                                  CASE
                                                      WHEN clawback_indicator = ''Y''
                                                      THEN
                                                        (
                                                        SELECT UPPER(DECODE(CPC_CLAWBACK_DESC,NULL,'''','' -''
                                                          || CPC_CLAWBACK_DESC))
                                                          ||rtrim(SUBSTR(CSL_TRANS_NARRRATION,instr(CSL_TRANS_NARRRATION,'' - '',-1)))
                                                          FROM CMS_PROD_CATTYPE
                                                       WHERE CPC_PROD_CODE = PRODUCTID
                                                        AND CPC_CARD_TYPE= CATEGORYID
                                                        AND CPC_INST_CODE=INSTCODE
                                                    ) 
                                                  ELSE DECODE (TXN_FEE_FLAG, ''Y'', '' - FEE'')
                                               END)    transactionDescription,
                    TRIM(TO_CHAR (nvl(csl_trans_amount,amount), ''99999999999999990.99'')) transactionAmount,
                    reason reason,
		            --ctd_check_desc checkDescription,
                    --ctd_routing_number checkRoutingNumber,
                    --ctd_check_acctno checkAccountNumber,
                    case when csl_delivery_channel = ''13'' then
                    (select ctd_check_desc||''~''||ctd_routing_number||''~''||ctd_check_acctno
                    from   cms_transaction_log_dtl
                    where   csl_rrn=ctd_rrn 
                    and csl_acct_no=ctd_cust_acct_number
                    and  csl_delivery_channel = ctd_delivery_channel
                    and  csl_txn_code = ctd_txn_code 
                    and  csl_business_date = ctd_business_date
                    and  csl_business_time = ctd_business_time
                    and rownum=1) end check_detls,
                    ''POSTED'' transactionType,
                    TRIM(TO_CHAR (nvl(csl_closing_balance,ledger_balance), ''99999999999999990.99''))  ledgerBalance,
                    TRIM(TO_CHAR (acct_balance, ''99999999999999990.99''))  availableBalance,
                    csl_acct_no accountNumber,
                    csl_to_acctno toAccountNumber,
                    CSL_PANNO_LAST4DIGIT lastFourPAN,
                    substr(fn_dmaps_main(topup_card_no_encr),-4)toLastFourPAN,
                    mccode MCCDescription,
                    merchant_id merchantID,
                    CASE
                      WHEN  csl_delivery_channel = ''11'' 
                      THEN  REGEXP_REPLACE(NVL((DECODE(NVL(COMPANYNAME,''''),'''','''',''/''
                        ||''From ''||COMPANYNAME)
                        || DECODE(NVL(COMPENTRYDESC,''''),'''','''',''/''
                        ||COMPENTRYDESC)
                        || DECODE(NVL(INDNAME,''''),'''','''',''/''
                        ||INDIDNUM
                        ||'' to ''
                        ||INDNAME)),''Direct Deposit''),''/'','''',1,1)
                      ELSE NVL ( CSL_MERCHANT_NAME, DECODE (TRIM (CDM_CHANNEL_DESC), ''ATM'', ''ATM'', ''POS'', ''Retail Merchant'', ''IVR'', ''IVR Transfer'', ''CHW'', ''Card Holder website'', ''ACH'', ''Direct Deposit'', ''MOB'', ''Mobile Transfer'', ''CSR'', ''Customer Service'', ''System'')) 
                    END name,
                    merchant_street streetAddress,
                    merchant_city city,
                    merchant_zip postalCode,
                    merchant_state state,
                    country_code country,
                    terminal_id terminalId ';
                    
          EXCEPTION
          WHEN OTHERS
          THEN
             p_resp_code_out := '21';
             l_err_msg :=
                   'Error while executing l_posted_select_query '
                || SUBSTR (SQLERRM, 1, 200);
             RAISE exp_reject_record;                        
          
          END;
          
          BEGIN
          
             l_posted_from_query := 
                  ' from   transactionlog,
                           --cms_transaction_log_dtl,
                           cms_transaction_mast,
                           cms_statements_log,
                           CMS_DELCHANNEL_MAST
                    where  csl_acct_no = :l_acct_no  
                     -- and  csl_rrn = ctd_rrn 
                     -- and  csl_delivery_channel = ctd_delivery_channel
                      and CDM_CHANNEL_CODE = CSL_DELIVERY_CHANNEL
                      AND CDM_INST_CODE = CSL_INST_CODE
                     -- and  csl_txn_code = ctd_txn_code
                     -- and  csl_business_date = ctd_business_date
                     -- and  csl_business_time = ctd_business_time
                     -- and  ctd_process_flag IN ( ''Y'' , ''C'') modified for vms-780:to include decline fee record
                      and  csl_inst_code = ctm_inst_code 
                      and  csl_delivery_channel = ctm_delivery_channel 
                      and  csl_txn_code = ctm_tran_code
                      and  CSL_PAN_NO= customer_card_no (+)
                      and  csl_rrn = rrn(+) 
                      and  CSL_TXN_CODE = txn_code(+) 
                      and  CSL_DELIVERY_CHANNEL= delivery_channel (+)
                      and  CSL_AUTH_ID= AUTH_ID (+)';
                     -- and  (response_code = ''00'' or response_code is null) '; modified for vms-780:to include decline fee record
                      
                    IF l_start_date is not null and  l_end_date is not null then
                      l_posted_from_query := l_posted_from_query||'and  csl_ins_date  between :l_start_date and :l_end_date ';
                    end if;
                      
          EXCEPTION
          WHEN OTHERS
          THEN
             p_resp_code_out := '21';
             l_err_msg :=
                   'Error while executing l_posted_from_query '
                || SUBSTR (SQLERRM, 1, 200);
             RAISE exp_reject_record;               
          
          END;
 		  -- EN Generate common select query
      
		  -- SN Generate total select query
         BEGIN
            l_pending_total_query :=
                        '  select count(1) total_pending_count,
                                  sum(cpt_totalhold_amt) total_pending_amnt ';
                                  
            l_posted_total_query := 
                        ' select COUNT(1) total_posted_count,
                                 SUM(CASE when upper(CSL_TRANS_TYPE)=''CR'' 
                                          then nvl(csl_trans_amount,amount)
                                                  else 0 
                                          END)total_credit_amnt,
                                  SUM(CASE when upper(CSL_TRANS_TYPE)=''DR'' 
                                          then nvl(csl_trans_amount,amount)
                                                  else 0 
                                          END)total_debit_amnt ';
                                          
          EXCEPTION
          WHEN OTHERS
          THEN
             p_resp_code_out := '21';
             l_err_msg :=
                   'Error while executing total query '
                || SUBSTR (SQLERRM, 1, 200);
             RAISE exp_reject_record;                                 
         END;

     -- EN Generate total select query
     
     IF l_tran_filter = 'PENDING' THEN
        
        l_exec_query := l_pending_select_query||l_pending_from_query;
        
        BEGIN
        
             l_exec_query := ' select * from(select b.*,rownum r from ( '
                             || l_exec_query
                             || ' order by run_date desc,  ts desc
                                )b) WHERE r BETWEEN :l_rec_start_no AND :l_rec_end_no ';
                                
           IF l_start_date is not null and  l_end_date is not null then 
             OPEN p_transaction_out FOR l_exec_query
             USING l_acct_no, l_start_date, l_end_date,
                   l_rec_start_no, l_rec_end_no;
          else
            OPEN p_transaction_out FOR l_exec_query
             USING l_acct_no, l_rec_start_no, l_rec_end_no;
          end if;
          
              
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error while executing l_exec_query '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;  
        
     ELSIF l_tran_filter = 'POSTED' THEN
     
        l_exec_query := l_posted_select_query || l_posted_from_query;
        
         BEGIN
        
             l_exec_query := ' select * from(select b.*,rownum r from ( '
                             || l_exec_query
                             || ' order by run_date desc,  ts desc
                                )b) WHERE r BETWEEN :l_rec_start_no AND :l_rec_end_no ';
                                
        
         IF l_start_date is not null and  l_end_date is not null then                         
             OPEN p_transaction_out FOR l_exec_query
             USING l_acct_no, l_start_date, l_end_date,
                   l_rec_start_no, l_rec_end_no;
          else
          OPEN p_transaction_out FOR l_exec_query
             USING l_acct_no, l_rec_start_no, l_rec_end_no;
        end if;
              
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error while executing l_exec_query '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;  
        
     ELSE 
     
        l_exec_query :=  l_pending_select_query||l_pending_from_query
                         || ' union '
                         || l_posted_select_query||l_posted_from_query;
                         
        BEGIN
        
             l_exec_query := ' select * from(select b.*,rownum r from ( '
                             || l_exec_query
                             || ' order by run_date desc,  ts desc
                                )b) WHERE r BETWEEN :l_rec_start_no AND :l_rec_end_no ';
          
          
             IF l_start_date is not null and  l_end_date is not null then                      
             OPEN p_transaction_out FOR l_exec_query
             USING l_acct_no, l_start_date, l_end_date,
                   l_acct_no, l_start_date, l_end_date, 
                   l_rec_start_no, l_rec_end_no;
              else
                OPEN p_transaction_out FOR l_exec_query
             USING l_acct_no, 
                   l_acct_no, 
                   l_rec_start_no, l_rec_end_no;
              end if;
              
         EXCEPTION
            WHEN OTHERS
            THEN
               p_resp_code_out := '21';
               l_err_msg :=
                     'Error while executing l_exec_query '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;                 
                         
     END IF;   
     
	   -- SN Open cursor to execute total query
         BEGIN
         
           IF l_tran_filter IN ( 'PENDING' , 'ALL' )  THEN
              
                l_tot_pend_exec_query := 
                                         l_pending_total_query || l_pending_from_query;
      
       IF l_start_date is not null and  l_end_date is not null then  
                EXECUTE IMMEDIATE l_tot_pend_exec_query
                INTO l_total_pending_count,l_total_pending_amount
                USING l_acct_no, l_start_date, l_end_date;
        else 
         EXECUTE IMMEDIATE l_tot_pend_exec_query
                INTO l_total_pending_count,l_total_pending_amount
                USING l_acct_no;
        end if;
            
            END IF;
            
            IF  l_tran_filter IN ( 'POSTED' , 'ALL' )  THEN
                      
                l_tot_post_exec_query := 
                        l_posted_total_query || l_posted_from_query;
        
            IF l_start_date is not null and  l_end_date is not null then  
                EXECUTE IMMEDIATE l_tot_post_exec_query
                INTO l_total_posted_count, l_total_credit_amount, l_total_debit_amount
                USING l_acct_no, l_start_date, l_end_date;
                
            else 
             EXECUTE IMMEDIATE l_tot_post_exec_query
                INTO l_total_posted_count, l_total_credit_amount, l_total_debit_amount
                USING l_acct_no;
            end if;
            
            END IF;
          
            p_total_pending_amount_out :=  CASE WHEN l_tran_filter = 'POSTED'
                                           THEN
                                             0
                                           ELSE
                                             nvl(l_total_pending_amount,0)
                                           END;
            p_total_credit_amount_out  :=  CASE WHEN l_tran_filter = 'PENDING'
                                           THEN
                                             0
                                           ELSE
                                             nvl(l_total_credit_amount,0)
                                           END;
            p_total_debit_amount_out   :=  CASE WHEN l_tran_filter = 'PENDING'
                                           THEN
                                             0
                                           ELSE
                                             nvl(l_total_debit_amount,0)
                                           END;
           
            p_total_records_out        :=  CASE WHEN l_tran_filter = 'ALL'
                                           THEN
                                              nvl(l_total_posted_count,0) + nvl(l_total_pending_count,0)
                                           WHEN l_tran_filter ='POSTED'
                                           THEN
                                              nvl(l_total_posted_count,0)
                                           WHEN l_tran_filter ='PENDING'
                                           THEN
                                              nvl(l_total_pending_count,0)
                                           ELSE 
                                              0
                                           END;
          
          p_total_pending_amount_out := trim(to_char(p_total_pending_amount_out,'99999999999999990.99'));
          p_total_credit_amount_out  := trim(to_char(p_total_credit_amount_out,'99999999999999990.99'));
          p_total_debit_amount_out   := trim(to_char(p_total_debit_amount_out,'99999999999999990.99'));
            
                          
           EXCEPTION
              WHEN OTHERS
              THEN
                 p_resp_code_out := '21';
                 l_err_msg :=
                       'Error while executing l_tot_exec_query  '
                    || SUBSTR (SQLERRM, 1, 200);
                 RAISE exp_reject_record;
           END;
             
-- EN Open cursor to execute query

         

          p_resp_code_out := '1';


      EXCEPTION                                         --<<Main Exception>>--
         WHEN exp_reject_record
         THEN
               p_resp_msg_out := l_err_msg;
 
         WHEN OTHERS
         THEN
            p_resp_msg_out := 'Other Excp-' || SUBSTR (SQLERRM, 1, 300);
            p_resp_code_out := '89';
      END;
      
        BEGIN
            SELECT cms_iso_respcde
              INTO p_resp_code_out
              FROM cms_response_mast
             WHERE cms_inst_code = p_inst_code_in
               AND cms_delivery_channel = p_del_channel_in
               AND cms_response_id = TO_NUMBER (p_resp_code_out);
         EXCEPTION
            WHEN OTHERS
            THEN
               l_err_msg :=
                     'Problem while selecting data from response master for respose code'
                  || p_resp_code_out
                  || ' is-'
                  || SUBSTR (SQLERRM, 1, 300);
               p_resp_code_out := '69';
         END;
         
      BEGIN
         l_hashkey_id :=
            gethash (   p_del_channel_in
                     || p_txn_code_in
                     || p_pan_code_in
                     || p_rrn_in
                     || TO_CHAR (NVL (l_timestamp, SYSTIMESTAMP),
                                 'YYYYMMDDHH24MISSFF5'
                                )
                    );
      EXCEPTION
         WHEN OTHERS
         THEN
            p_resp_code_out := '21';
            p_resp_msg_out :=
                  'Error while generating hashkey_id- '
               || SUBSTR (SQLERRM, 1, 200);
      END;
      
      BEGIN
          
          SELECT CAM_ACCT_BAL,CAM_LEDGER_BAL,CAM_TYPE_CODE
          INTO   l_acct_bal,l_ledger_bal,l_acct_type
          FROM   CMS_ACCT_MAST
          WHERE  CAM_INST_CODE = p_inst_code_in
          AND    CAM_ACCT_NO = l_acct_no;
      
      EXCEPTION
            WHEN NO_DATA_FOUND    THEN
               p_resp_code_out := '21';
               l_err_msg := 'Invalid Card number ' ;
         WHEN OTHERS
        THEN
           p_resp_code_out := '12';
           l_err_msg :=
                   'Error in account details' || SUBSTR (SQLERRM, 1, 200);
      END;
      

-- SN Log into transaction log and cms_transaction_log_dtl
      BEGIN
         vms_log.log_transactionlog (p_inst_code_in,
                                     p_msg_type_in,
                                     p_rrn_in,
                                     p_del_channel_in,
                                     p_txn_code_in,
                                     l_txn_type,
                                     '0',                          
                                     p_business_date_in,
                                     p_business_time_in,
                                     '00',
                                     l_hash_pan,
                                     l_encr_pan,
                                     p_resp_msg_out,
                                     p_ip_addr_in,
                                     l_card_stat,
                                     l_tran_desc,
                                     p_ani_in,
                                     p_dni_in,
                                     l_timestamp,
                                     l_acct_no,
                                     l_prod_code,
                                     l_card_type,
                                     l_cr_dr_flag,
                                     l_acct_bal,
                                     l_ledger_bal,
                                     l_acct_type,
                                     l_proxy_number,
                                     l_auth_id,
                                     0,
                                     l_total_amt,
                                     l_fee_code,
                                     l_tranfee_amt,
                                     l_fee_plan,
                                     l_feeattach_type,
                                     p_resp_code_out,
                                     p_resp_code_out,
                                     p_curr_code_in,
                                     l_hashkey_id,
                                     p_uuid_in,
                                     p_osname_in,
                                     p_osversion_in,
                                     p_gpscoordinates_in,
                                     p_displayresolution_in,
                                     p_physicalmemory_in,
                                     p_appname_in,
                                     p_appversion_in,
                                     p_sessionid_in,
                                     p_devicecountry_in,
                                     p_deviceregion_in,
                                     p_ipcountry_in,
                                     p_proxy_in,
                                     p_partner_id_in,
                                     l_err_msg
                                    );
      EXCEPTION
         WHEN OTHERS
         THEN
            p_resp_code_out := '69';
            l_err_msg :=
                  'Exception while inserting to transaction log '
               || SUBSTR (SQLERRM, 1, 300);
      END;
-- EN Log into transaction log and cms_transaction_log_dtl
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         p_resp_code_out := '89';
         p_resp_msg_out := 'Main Excp- ' || SUBSTR (SQLERRM, 1, 300);
   END get_transaction_history_v2; 
   
END vms_transaction;
/
show error