create or replace
TRIGGER VMSCMS.TRG_CMS_TRANLOG_STD
   BEFORE INSERT OR UPDATE
   ON vmscms.transactionlog
   FOR EACH ROW
/*************************************************
     * Created Date       :
     * Created By         :
     * PURPOSE            :
     * Modified By:       : Ganesh
     * Modified Date      : 12/09/2012
     * Modified reason    : Inserting and Updating the sysdate.
     * VERSION            : CMS3.5.1_RI0016_B0002
     * Reviewed by        : Saravanakumar
     * Reviewed Date      : 12/09/2012
	 
	 * Modified by       : Siva kumar M
     * Modified Date     : 18-Aug-17
     * Modified For      : FSS-5157 B2B changes
     * Reviewer          : Saravanakumar A
     * Build Number      : VMSGPRHOST_17.08
	 
   	 * Modified by       : Akhil
     * Modified Date     : 15-Nov-17
     * Modified For      : VMS-63
     * Reviewer          : Saravanakumar A
     * Build Number      : VMSGPRHOST_17.10.1
	 
	 * Modified by       : Ubaid
     * Modified Date     : 05-Jul-2018
     * Modified For      :  VMS-375
     * Reviewer          : Saravanakumar A
     * Build Number      : VMSR03_B0003
     
     * Modified By      : Ubaidur Rahman H
     * Modified Date    : 14-NOV-2019
     * Purpose          : Fix for dead lock issue
     * Reviewer         : Saravanakumar A 
     * Build Number     : VMS_RSI0226
	 
	 * Modified By      : Ubaidur Rahman H
     * Modified Date    : 18-DEC-2020
     * Purpose          : VMS- 3100 - BlockingSession Identified in B2BCCF 
										APPL_PAN lock while update of cap_last_txndate
     * Reviewer         : Saravanakumar A 
     * Build Number     : VMS_RSI0226
   ***********************************************/
BEGIN                                                    --Trigger body begins
   
   IF INSERTING THEN
      :NEW.add_ins_date := SYSDATE;
      :NEW.add_lupd_date := SYSDATE;
     --Sn Added for DFCTNM-44-Partner Id changes
     BEGIN
        IF :NEW.productid IS NULL THEN
           SELECT cpp_partner_id
             INTO :NEW.partner_id
             FROM cms_appl_pan, cms_product_param
            WHERE cap_pan_code = :NEW.customer_card_no
              AND cpp_prod_code = cap_prod_code
              AND cpp_inst_code = cap_inst_code;
        ELSE
           SELECT cpp_partner_id
             INTO :NEW.partner_id
             FROM cms_product_param
            WHERE cpp_prod_code = :NEW.productid
              AND cpp_inst_code = :NEW.instcode;
        END IF;
     EXCEPTION
      WHEN OTHERS THEN
         NULL;
     END;
     --En Added for DFCTNM-44-Partner Id changes


      BEGIN
        IF :NEW.date_time IS NULL THEN
           :NEW.date_time := to_date(:NEW.business_date||:NEW.business_time,'YYYYMMDDhh24miss');
        END IF;
     EXCEPTION
      WHEN OTHERS THEN
         NULL;
     END;

      IF NOT (:NEW.delivery_channel = '05' AND :NEW.txn_code IN ('04','06','07','13', '16', '17', '18', '97')
				OR (:NEW.delivery_channel = '17' AND :NEW.txn_code ='04'))
				--- Modified for dead lock issue.
      THEN
         UPDATE cms_appl_pan
            SET cap_last_txndate = SYSDATE
          WHERE cap_pan_code = :NEW.customer_card_no
                 AND trunc(NVL(cap_last_txndate,sysdate-1))<trunc(sysdate)
				 AND cap_proxy_number is NOT NULL;					
																	
																	---Modified for VMS-3100-BlockingSession Identified in B2BCCF  
	   END IF;
      
       IF :NEW.delivery_channel <> '05' AND :NEW.CR_DR_FLAG ='DR' and :NEW.customer_acct_no is not null THEN
        UPDATE  CMS_ACCT_MAST 
          SET CAM_FIRST_PURCHASEDATE=SYSDATE 
          WHERE cam_acct_no=:NEW.customer_acct_no
          and CAM_FIRST_PURCHASEDATE IS NULL;
       END IF;
     
   ELSIF UPDATING THEN
      :NEW.add_lupd_date := SYSDATE;
   END IF;
END;
/
show error