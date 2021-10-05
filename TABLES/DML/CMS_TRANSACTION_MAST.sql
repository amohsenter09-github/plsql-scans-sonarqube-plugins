DECLARE
   v_chk_tab   VARCHAR2 (10);
   v_err       VARCHAR2 (1000);
   v_cnt       NUMBER (2);
BEGIN
   SELECT COUNT (1)
     INTO v_chk_tab
     FROM all_objects
    WHERE owner = 'VMSCMS'
      AND OBJECT_TYPE = 'TABLE'
      AND object_name = 'CMS_TRANSACTION_MAST_R1707B5';

   IF v_chk_tab = 1
   THEN
      SELECT COUNT (1)
        INTO v_cnt
        FROM vmscms.cms_transaction_mast
       WHERE CTM_INST_CODE = 1
         AND ctm_tran_code = '01'
         AND ctm_delivery_channel = '17';

      IF v_cnt = 0
      THEN
                   INSERT INTO vmscms.CMS_TRANSACTION_MAST_R1707B5(
CTM_INST_CODE,CTM_TRAN_CODE,CTM_TRAN_DESC,CTM_CREDIT_DEBIT_FLAG,CTM_DELIVERY_CHANNEL,CTM_OUTPUT_TYPE,CTM_TRAN_TYPE,CTM_SUPPORT_TYPE,CTM_LUPD_DATE,CTM_LUPD_USER,CTM_INS_DATE,CTM_INS_USER,
CTM_PREAUTH_FLAG,CTM_AMNT_TRANSFER_FLAG,CTM_LOGIN_TXN,CTM_PRFL_FLAG,CTM_FEE_FLAG,CTM_TXN_IND,CTM_ADJUSTMENT_FLAG,CTM_INITIAL_PREAUTH_IND,CTM_DEPLOYMENT_FLAG,
CTM_LOADTRANS_FLAG,CTM_PRFLUPD_FLAG,CTM_DISPLAY_TXNDESC,CTM_KYCDISPLAY_FLAG,CTM_TXN_MAP_CODE,CTM_TXN_MAP_FLAG,CTM_TRANSACTION_IDENTIFIER,CTM_CARD_ACTIVATION,CTM_CARDSTAT_CHANGE_TXN) 
VALUES(1,'01','CARD ACTIVATION','NA','17','N','N','T',SYSDATE,1,SYSDATE,1,
'N','N','Y','N','N','N','N','N',0,
'N','N','CARD ACTIVATION','N','NA','N','0','Y','Y');

      END IF;
	  
	  SELECT COUNT (1)
        INTO v_cnt
        FROM vmscms.cms_transaction_mast
       WHERE CTM_INST_CODE = 1
         AND ctm_tran_code = '02'
         AND ctm_delivery_channel = '17';

      IF v_cnt = 0
      THEN
                 INSERT INTO vmscms.CMS_TRANSACTION_MAST_R1707B5(
CTM_INST_CODE,CTM_TRAN_CODE,CTM_TRAN_DESC,CTM_CREDIT_DEBIT_FLAG,CTM_DELIVERY_CHANNEL,CTM_OUTPUT_TYPE,CTM_TRAN_TYPE,CTM_SUPPORT_TYPE,CTM_LUPD_DATE,CTM_LUPD_USER,CTM_INS_DATE,CTM_INS_USER,
CTM_PREAUTH_FLAG,CTM_AMNT_TRANSFER_FLAG,CTM_LOGIN_TXN,CTM_PRFL_FLAG,CTM_FEE_FLAG,CTM_TXN_IND,CTM_ADJUSTMENT_FLAG,CTM_INITIAL_PREAUTH_IND,CTM_DEPLOYMENT_FLAG,
CTM_LOADTRANS_FLAG,CTM_PRFLUPD_FLAG,CTM_DISPLAY_TXNDESC,CTM_KYCDISPLAY_FLAG,CTM_TXN_MAP_CODE,CTM_TXN_MAP_FLAG,CTM_TRANSACTION_IDENTIFIER,CTM_CARD_ACTIVATION,CTM_CARDSTAT_CHANGE_TXN) 
VALUES(1,'02','VIRTUAL CARD VALIDATION','NA','17','N','N','T',SYSDATE,1,SYSDATE,1,
'N','N','Y','N','N','N','N','N',0,
'N','N','VIRTUAL CARD VALIDATION','N','NA','N','0','N','N');
      END IF;
	  
	  
	  SELECT COUNT (1)
        INTO v_cnt
        FROM vmscms.cms_transaction_mast
       WHERE CTM_INST_CODE = 1
         AND ctm_tran_code = '03'
         AND ctm_delivery_channel = '17';

      IF v_cnt = 0
      THEN
                  INSERT INTO vmscms.CMS_TRANSACTION_MAST_R1707B5(
CTM_INST_CODE,CTM_TRAN_CODE,CTM_TRAN_DESC,CTM_CREDIT_DEBIT_FLAG,CTM_DELIVERY_CHANNEL,CTM_OUTPUT_TYPE,CTM_TRAN_TYPE,CTM_SUPPORT_TYPE,CTM_LUPD_DATE,CTM_LUPD_USER,CTM_INS_DATE,CTM_INS_USER,
CTM_PREAUTH_FLAG,CTM_AMNT_TRANSFER_FLAG,CTM_LOGIN_TXN,CTM_PRFL_FLAG,CTM_FEE_FLAG,CTM_TXN_IND,CTM_ADJUSTMENT_FLAG,CTM_INITIAL_PREAUTH_IND,CTM_DEPLOYMENT_FLAG,
CTM_LOADTRANS_FLAG,CTM_SUCCESS_ALERTS,CTM_PRFLUPD_FLAG,CTM_DISPLAY_TXNDESC,CTM_KYCDISPLAY_FLAG,CTM_TXN_MAP_CODE,CTM_TXN_MAP_FLAG,CTM_TRANSACTION_IDENTIFIER,CTM_CARD_ACTIVATION,CTM_CARDSTAT_CHANGE_TXN) 
VALUES(1,'03','CARD RELOAD','CR','17','N','F','T',SYSDATE,1,SYSDATE,1,
'N','N','N','Y','N','N','N','N',0,
'Y','9:1,10:2,11:3,29:19','N','CARD RELOAD','N','NA','N','4','N','Y');
      END IF;
	  
	  
	  SELECT COUNT (1)
        INTO v_cnt
        FROM vmscms.cms_transaction_mast
       WHERE CTM_INST_CODE = 1
         AND ctm_tran_code = '59'
         AND ctm_delivery_channel = '13';

      IF v_cnt = 0
      THEN
                  INSERT INTO vmscms.CMS_TRANSACTION_MAST_R1707B5(
CTM_INST_CODE,CTM_TRAN_CODE,CTM_TRAN_DESC,CTM_CREDIT_DEBIT_FLAG,CTM_DELIVERY_CHANNEL,CTM_OUTPUT_TYPE,CTM_TRAN_TYPE,CTM_SUPPORT_TYPE,CTM_LUPD_DATE,CTM_LUPD_USER,CTM_INS_DATE,CTM_INS_USER,
CTM_PREAUTH_FLAG,CTM_AMNT_TRANSFER_FLAG,CTM_LOGIN_TXN,CTM_PRFL_FLAG,CTM_FEE_FLAG,CTM_TXN_IND,CTM_ADJUSTMENT_FLAG,CTM_INITIAL_PREAUTH_IND,CTM_DEPLOYMENT_FLAG,
CTM_LOADTRANS_FLAG,CTM_PRFLUPD_FLAG,CTM_DISPLAY_TXNDESC,CTM_KYCDISPLAY_FLAG,CTM_TXN_MAP_CODE,CTM_TXN_MAP_FLAG,CTM_TRANSACTION_IDENTIFIER,CTM_CARD_ACTIVATION,CTM_CARDSTAT_CHANGE_TXN) 
VALUES(1,'59','VIRTUAL CARD VALIDATION','NA','13','N','N','T',SYSDATE,1,SYSDATE,1,
'N','N','Y','N','N','N','N','N',0,
'N','N','VIRTUAL CARD VALIDATION','N','NA','N','0','N','N');
      END IF;
	  
	  SELECT COUNT (1)
        INTO v_cnt
        FROM vmscms.cms_transaction_mast
       WHERE CTM_INST_CODE = 1
         AND ctm_tran_code = '35'
         AND ctm_delivery_channel = '07';

      IF v_cnt = 0
      THEN
                   INSERT INTO vmscms.CMS_TRANSACTION_MAST_R1707B5(
CTM_INST_CODE,CTM_TRAN_CODE,CTM_TRAN_DESC,CTM_CREDIT_DEBIT_FLAG,CTM_DELIVERY_CHANNEL,CTM_OUTPUT_TYPE,CTM_TRAN_TYPE,CTM_SUPPORT_TYPE,CTM_LUPD_DATE,CTM_LUPD_USER,CTM_INS_DATE,CTM_INS_USER,
CTM_PREAUTH_FLAG,CTM_AMNT_TRANSFER_FLAG,CTM_LOGIN_TXN,CTM_PRFL_FLAG,CTM_FEE_FLAG,CTM_TXN_IND,CTM_ADJUSTMENT_FLAG,CTM_INITIAL_PREAUTH_IND,CTM_DEPLOYMENT_FLAG,
CTM_LOADTRANS_FLAG,CTM_PRFLUPD_FLAG,CTM_DISPLAY_TXNDESC,CTM_KYCDISPLAY_FLAG,CTM_TXN_MAP_CODE,CTM_TXN_MAP_FLAG,CTM_TRANSACTION_IDENTIFIER,CTM_CARD_ACTIVATION,CTM_CARDSTAT_CHANGE_TXN) 
VALUES(1,'35','B2B CARD ACTIVATION','NA','07','N','N','T',SYSDATE,1,SYSDATE,1,
'N','N','Y','N','N','N','N','N',0,
'N','N','B2B CARD ACTIVATION','N','NA','N','0','Y','Y');
      END IF;
	  
	  SELECT COUNT (1)
        INTO v_cnt
        FROM vmscms.cms_transaction_mast
       WHERE CTM_INST_CODE = 1
         AND ctm_tran_code = '36'
         AND ctm_delivery_channel = '07';

      IF v_cnt = 0
      THEN
                  INSERT INTO vmscms.CMS_TRANSACTION_MAST_R1707B5(
CTM_INST_CODE,CTM_TRAN_CODE,CTM_TRAN_DESC,CTM_CREDIT_DEBIT_FLAG,CTM_DELIVERY_CHANNEL,CTM_OUTPUT_TYPE,CTM_TRAN_TYPE,CTM_SUPPORT_TYPE,CTM_LUPD_DATE,CTM_LUPD_USER,CTM_INS_DATE,CTM_INS_USER,
CTM_PREAUTH_FLAG,CTM_AMNT_TRANSFER_FLAG,CTM_LOGIN_TXN,CTM_PRFL_FLAG,CTM_FEE_FLAG,CTM_TXN_IND,CTM_ADJUSTMENT_FLAG,CTM_INITIAL_PREAUTH_IND,CTM_DEPLOYMENT_FLAG,
CTM_LOADTRANS_FLAG,CTM_SUCCESS_ALERTS,CTM_PRFLUPD_FLAG,CTM_DISPLAY_TXNDESC,CTM_KYCDISPLAY_FLAG,CTM_TXN_MAP_CODE,CTM_TXN_MAP_FLAG,CTM_TRANSACTION_IDENTIFIER,CTM_CARD_ACTIVATION,CTM_CARDSTAT_CHANGE_TXN) 
VALUES(1,'36','CARD RELOAD','CR','07','N','F','T',SYSDATE,1,SYSDATE,1,
'N','N','N','Y','N','N','N','N',0,
'Y','9:1,10:2,11:3,29:19','N','CARD RELOAD','N','NA','N','4','N','Y');
      END IF;
	  
	  SELECT COUNT (1)
        INTO v_cnt
        FROM vmscms.cms_transaction_mast
       WHERE CTM_INST_CODE = 1
         AND ctm_tran_code = '37'
         AND ctm_delivery_channel = '07';

      IF v_cnt = 0
      THEN
                  insert into vmscms.CMS_TRANSACTION_MAST_R1707B5 (CTM_INST_CODE,CTM_TRAN_CODE,CTM_TRAN_DESC,CTM_CREDIT_DEBIT_FLAG,CTM_DELIVERY_CHANNEL,CTM_OUTPUT_TYPE,CTM_TRAN_TYPE,CTM_SUPPORT_TYPE,CTM_LUPD_DATE,CTM_LUPD_USER,CTM_INS_DATE,CTM_INS_USER,CTM_PREAUTH_FLAG,
CTM_AMNT_TRANSFER_FLAG,CTM_LOGIN_TXN,CTM_PRFL_FLAG,CTM_FEE_FLAG,CTM_TXN_IND,CTM_ADJUSTMENT_FLAG,CTM_INITIAL_PREAUTH_IND,CTM_DEPLOYMENT_FLAG,CTM_LOADTRANS_FLAG,
CTM_PRFLUPD_FLAG,CTM_DISPLAY_TXNDESC,CTM_KYCDISPLAY_FLAG,CTM_TXN_MAP_CODE,CTM_TXN_MAP_FLAG,CTM_TRANSACTION_IDENTIFIER,CTM_CARD_ACTIVATION,CTM_CARDSTAT_CHANGE_TXN) 
values (1,'37','Initial Load','CR','07','N','F','T',sysdate,1,sysdate,1,'N','N','N','N','Y','N','N','N',0,'N','N','Initial Load','N','NA','N','0','N','N');
      END IF;
	  
	  
	  SELECT COUNT (1)
        INTO v_cnt
        FROM vmscms.cms_transaction_mast
       WHERE CTM_INST_CODE = 1
         AND ctm_tran_code = '04'
         AND ctm_delivery_channel = '17';

      IF v_cnt = 0
      THEN
                  insert into vmscms.CMS_TRANSACTION_MAST_R1707B5 (CTM_INST_CODE,CTM_TRAN_CODE,CTM_TRAN_DESC,CTM_CREDIT_DEBIT_FLAG,CTM_DELIVERY_CHANNEL,CTM_OUTPUT_TYPE,CTM_TRAN_TYPE,CTM_SUPPORT_TYPE,CTM_LUPD_DATE,CTM_LUPD_USER,CTM_INS_DATE,CTM_INS_USER,CTM_PREAUTH_FLAG,
CTM_AMNT_TRANSFER_FLAG,CTM_LOGIN_TXN,CTM_PRFL_FLAG,CTM_FEE_FLAG,CTM_TXN_IND,CTM_ADJUSTMENT_FLAG,CTM_INITIAL_PREAUTH_IND,CTM_DEPLOYMENT_FLAG,CTM_LOADTRANS_FLAG,
CTM_PRFLUPD_FLAG,CTM_DISPLAY_TXNDESC,CTM_KYCDISPLAY_FLAG,CTM_TXN_MAP_CODE,CTM_TXN_MAP_FLAG,CTM_TRANSACTION_IDENTIFIER,CTM_CARD_ACTIVATION,CTM_CARDSTAT_CHANGE_TXN) 
values (1,'04','Initial Load','CR','17','N','F','T',sysdate,1,sysdate,1,'N','N','N','N','Y','N','N','N',0,'N','N','Initial Load','N','NA','N','0','N','N');
      END IF;
	  

      INSERT INTO vmscms.cms_transaction_mast
         SELECT *
           FROM vmscms.CMS_TRANSACTION_MAST_R1707B5
          WHERE (ctm_inst_code, ctm_tran_code, ctm_delivery_channel) NOT IN (
                     SELECT ctm_inst_code, ctm_tran_code,
                            ctm_delivery_channel
                       FROM vmscms.cms_transaction_mast);

      DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows inserted ');
   ELSE
      DBMS_OUTPUT.put_line ('Backup Object Not Found');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;
      v_err := SUBSTR (SQLERRM, 1, 100);
      DBMS_OUTPUT.put_line ('Main Excp ' || v_err);
END;
/
