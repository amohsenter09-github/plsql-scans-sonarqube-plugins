create or replace
PACKAGE        vmscms.VMSMOBILE AS 


  PROCEDURE  hold_auth_amount (
          p_inst_code_in          IN       NUMBER,
      p_msg_type_in           IN       VARCHAR2,
      p_rrn_in                IN       VARCHAR2,
      p_delivery_channel_in   IN       VARCHAR2,
      p_txn_code_in           IN       VARCHAR2,
      p_txn_mode_in           IN       VARCHAR2,
      p_tran_date_in          IN       VARCHAR2,
      p_tran_time_in          IN       VARCHAR2,
      p_mbr_numb_in           IN       VARCHAR2,
      p_rvsl_code_in          IN       VARCHAR2,
      p_txn_amt_in            IN       NUMBER,
      p_cust_id_in            IN       NUMBER,
      p_pan_code_in           IN       VARCHAR2,
      p_curr_code_in          IN       VARCHAR2,
      p_partner_id_in         IN       VARCHAR2,
      p_payee_id_in           IN       VARCHAR2,
      p_resubmit_flag_in      IN       VARCHAR2,
      p_remarks_in            IN       VARCHAR2,
      p_reason_code_in        IN       VARCHAR2,
      p_resp_code_out          OUT      VARCHAR2,
      p_resmsg_out             OUT      VARCHAR2,
      p_org_rrn_out            OUT      VARCHAR2

   );
 PROCEDURE  release_auth_amount (
          p_inst_code_in          IN       NUMBER,
      p_msg_type_in           IN       VARCHAR2,
      p_rrn_in                IN       VARCHAR2,
      p_delivery_channel_in   IN       VARCHAR2,
      p_txn_code_in           IN       VARCHAR2,
      p_txn_mode_in           IN       VARCHAR2,
      p_tran_date_in          IN       VARCHAR2,
      p_tran_time_in          IN       VARCHAR2,
      p_mbr_numb_in           IN       VARCHAR2,
      p_rvsl_code_in          IN       VARCHAR2,
      p_txn_amt_in            IN       NUMBER,
      p_cust_id_in            IN       NUMBER,
      p_pan_code_in           IN       VARCHAR2,
      p_curr_code_in          IN       VARCHAR2,
      p_resubmit_flag_in      IN       VARCHAR2,
      p_remarks_in            IN       VARCHAR2,
      p_reason_code_in        IN       VARCHAR2,
      p_resp_code_out          OUT      VARCHAR2,
      p_resmsg_out             OUT      VARCHAR2,
      p_reversal_amount_out    OUT      VARCHAR2
   );
    PROCEDURE  settle_auth_amount (
         p_inst_code_in          IN       NUMBER,
      p_msg_type_in           IN       VARCHAR2,
      p_rrn_in                IN       VARCHAR2,
      p_delivery_channel_in   IN       VARCHAR2,
      p_txn_code_in           IN       VARCHAR2,
      p_txn_mode_in           IN       VARCHAR2,
      p_tran_date_in          IN       VARCHAR2,
      p_tran_time_in          IN       VARCHAR2,
      p_mbr_numb_in           IN       VARCHAR2,
      p_rvsl_code_in          IN       VARCHAR2,
      p_txn_amt_in            IN       NUMBER,
      p_cust_id_in            IN       NUMBER,
      p_pan_code_in           IN       VARCHAR2,
      p_curr_code_in          IN       VARCHAR2,
      p_remarks_in            IN       VARCHAR2,
      p_reason_code_in        IN       VARCHAR2,
      p_resp_code_out          OUT      VARCHAR2,
      p_resmsg_out             OUT      VARCHAR2
   );
    PROCEDURE  inquire_cellphone_number (
          p_inst_code_in         in    number,
          p_msg_type_in          in 	  varchar2,
          p_rrn_in               in  	varchar2,
          p_delivery_channel_in  in  	varchar2,
          p_txn_code_in          in  	varchar2,
          p_txn_mode_in          in  	varchar2,
          p_tran_date_in         in  	varchar2,
          p_tran_time_in         in  	varchar2,
          p_mbr_numb_in          in  	varchar2,
          p_rvsl_code_in         in  	varchar2,
          p_cust_id_in           in    number,
          p_pan_code_in   		    in  	varchar2,
          p_curr_code_in         in  	varchar2,
          p_reason_code_in        IN    VARCHAR2,
          p_resp_code_out         out 	varchar2,
          p_resmsg_out            out 	varchar2,
          p_cell_no_out           out   varchar2
   );

    PROCEDURE  validate_partnerid_customerid (
          p_inst_code_in         in    number,
          p_msg_type_in          in 	  varchar2,
          p_rrn_in               in  	varchar2,
          p_delivery_channel_in  in  	varchar2,
          p_txn_code_in          in  	varchar2,
          p_txn_mode_in          in  	varchar2,
          p_tran_date_in         in  	varchar2,
          p_tran_time_in         in  	varchar2,
          p_mbr_numb_in          in  	varchar2,
          p_rvsl_code_in         in  	varchar2,
          p_cust_id_in           in    number,
          p_pan_code_in   		   in  	varchar2,
          p_curr_code_in         in  	varchar2,
          p_partner_id_in        in  	varchar2,
          p_device_id_in         in  	varchar2,
          p_mobile_no_in         in  	varchar2,
          p_ip_address_in        in  	varchar2,
          p_reason_code_in       IN     VARCHAR2,
          p_resp_code_out        out 	varchar2,
          p_resmsg_out           out 	varchar2


   );


    PROCEDURE  fund_credit_debit (
      p_inst_code_in          IN       NUMBER,
      p_msg_type_in           IN       VARCHAR2,
      p_rrn_in                IN       VARCHAR2,
      p_delivery_channel_in   IN       VARCHAR2,
      p_txn_code_in           IN       VARCHAR2,
      p_txn_mode_in           IN       VARCHAR2,
      p_tran_date_in          IN       VARCHAR2,
      p_tran_time_in          IN       VARCHAR2,
      p_mbr_numb_in           IN       VARCHAR2,
      p_rvsl_code_in          IN       VARCHAR2,
      p_txn_amt_in            IN       NUMBER,
      p_cust_id_in            IN       NUMBER,
      p_pan_code_in           IN       VARCHAR2,
      p_curr_code_in          IN       VARCHAR2,
      p_partner_id_in         IN       VARCHAR2,
      p_payee_id_in           IN       VARCHAR2,
      p_remarks_in            IN       VARCHAR2,
      p_mobile_no_in          IN       VARCHAR2,
      p_device_id_in          IN       VARCHAR2,
      p_reason_code_in        IN       VARCHAR2,
      p_resp_code_out         OUT      VARCHAR2,
      p_resmsg_out            OUT      VARCHAR2

   );

   PROCEDURE  fund_creditdebit_rvsl (
      p_inst_code_in          IN       NUMBER,
      p_msg_type_in           IN       VARCHAR2,
      p_rrn_in                IN       VARCHAR2,
      p_delivery_channel_in   IN       VARCHAR2,
      p_txn_code_in           IN       VARCHAR2,
      p_txn_mode_in           IN       VARCHAR2,
      p_tran_date_in          IN       VARCHAR2,
      p_tran_time_in          IN       VARCHAR2,
      p_mbr_numb_in           IN       VARCHAR2,
      p_rvsl_code_in          IN       VARCHAR2,
      p_txn_amt_in            IN       NUMBER,
      p_cust_id_in            IN       NUMBER,
      p_pan_code_in           IN       VARCHAR2,
      p_curr_code_in          IN       VARCHAR2,
      p_partner_id_in         IN       VARCHAR2,
      p_payee_id_in           IN       VARCHAR2,
      p_remarks_in            IN       VARCHAR2,
      p_mobile_no_in          IN       VARCHAR2,
      p_device_id_in          IN       VARCHAR2,
      p_reason_code_in        IN       VARCHAR2,
      p_resp_code_out         OUT      VARCHAR2,
      p_resmsg_out            OUT      VARCHAR2,
      p_reversal_amount_out   OUT      VARCHAR2

   );

     PROCEDURE        sp_mob_check_deposit(
   p_inst_code          IN       NUMBER,
   p_msg_type           IN       VARCHAR2,
   p_rrn                IN       VARCHAR2,
   p_delivery_channel   IN       VARCHAR2,
   p_txn_code           IN       VARCHAR2,
   p_txn_mode           IN       VARCHAR2,
   p_tran_date          IN       VARCHAR2,
   p_tran_time          IN       VARCHAR2,
   p_pan_code           IN       VARCHAR2,
   p_mbr_numb           IN       VARCHAR2,
   p_rvsl_code          IN       VARCHAR2,
   P_CUSTOMERID         in       varchar2,
   p_curr_code          IN       VARCHAR2,
   P_TRAN_AMOUNT        in       varchar2,
   P_DEPOSIT_ID         in       varchar2,
   P_PARTNER_ID         in       varchar2,
   P_MOBIL_NO           in       varchar2,
   P_DEVICE_ID          in       varchar2,
   p_chcek_acctno       IN       VARCHAR2,
   P_CHECK_NO           in       varchar2,
   P_USER_CHECKDESC     in       varchar2,
   p_check_imagefs      IN       BLOB,
   P_CHECK_IMAGEBS      in       blob,
   P_EXPRYDATE          in       varchar2,
   p_routing_no         IN       VARCHAR2,
   p_reason_code_in     IN       VARCHAR2,
   p_resp_code          OUT      VARCHAR2,
   p_resmsg             OUT      VARCHAR2,
   P_ACCT_BAL           OUT      varchar2,
   P_PREV_BALANCE       OUT      varchar2,
   P_EMAIL_ID           OUT      varchar2,
   P_ORG_RESP_CODE      OUT      varchar2,
   P_ORG_RESP_DESC      OUT      varchar2
   );
   PROCEDURE        sp_mob_check_deposit_rvsl(
   p_inst_code          IN       NUMBER,
   p_msg_type           IN       VARCHAR2,
   p_rrn                IN       VARCHAR2,
   p_delivery_channel   IN       VARCHAR2,
   p_txn_code           IN       VARCHAR2,
   p_txn_mode           IN       VARCHAR2,
   p_tran_date          IN       VARCHAR2,
   p_tran_time          IN       VARCHAR2,
   p_pan_code           IN       VARCHAR2,
   p_mbr_numb           IN       VARCHAR2,
   p_rvsl_code          IN       VARCHAR2,
   P_CUSTOMERID         in       varchar2,
   p_curr_code          IN       VARCHAR2,
   P_TRAN_AMOUNT        in       varchar2,
   P_DEPOSIT_ID         in       varchar2,
   P_PARTNER_ID         in       varchar2,
   P_MOBIL_NO           in       varchar2,
   P_DEVICE_ID          in       varchar2,
   p_chcek_acctno       IN       VARCHAR2,
   P_CHECK_NO           in       varchar2,
   P_USER_CHECKDESC     in       varchar2,
   p_check_imagefs      IN       BLOB,
   P_CHECK_IMAGEBS      in       blob,
   P_EXPRYDATE          in       varchar2,
   p_routing_no         IN       VARCHAR2,
   p_reason_code_in     IN       VARCHAR2,
   p_resp_code          OUT      VARCHAR2,
   p_resmsg             OUT      VARCHAR2,
   P_ACCT_BAL           OUT      varchar2,
   P_PREV_BALANCE       OUT      varchar2,
   P_EMAIL_ID           OUT      varchar2,
   P_ORG_RESP_CODE      OUT      varchar2,
   P_ORG_RESP_DESC      OUT      varchar2
   );

   FUNCTION get_reason_code_desc(p_reason_code_in VARCHAR2) RETURN VARCHAR2;
END VMSMOBILE;
/
show error