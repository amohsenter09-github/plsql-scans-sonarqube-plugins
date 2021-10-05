UPDATE VMSCMS.cms_inst_param 
SET CIP_PARAM_VALUE = (SELECT CIP_PARAM_VALUE  FROM VMSCMS.cms_inst_param_06113013  
where cip_param_key = 'PRODUCT_THRESHOLD' )
WHERE cip_param_key = 'PRODUCT_THRESHOLD'
;

update vmscms.cms_prod_threshold 
set cpt_prod_threshold = (SELECT cpt_prod_threshold  FROM vmscms.cms_prod_threshold_12112013 
where cpt_prod_code =   'MP52') 
where cpt_prod_code =   'MP52';

update vmscms.cms_prod_threshold 
set cpt_prod_threshold = (SELECT cpt_prod_threshold  FROM vmscms.cms_prod_threshold_12112013 
where cpt_prod_code =   'MP53' ) 
where cpt_prod_code =   'MP53' ;

update vmscms.cms_prod_threshold 
set cpt_prod_threshold = (SELECT cpt_prod_threshold  FROM vmscms.cms_prod_threshold_12112013 
where cpt_prod_code =   'MP54') 
where cpt_prod_code =   'MP54';

COMMIT;

CREATE TABLE CMS_ACCT_MAST_MIGR 
AS SELECT * FROM CMS_ACCT_MAST
where cam_acct_no in (
select cap_acct_no from cms_appl_pan, cms_acct_mast
where cap_prod_code  in ( 'MP52', 'MP53', 'MP54')
and cam_acct_no = cap_acct_no);

ALTER TRIGGER  VMSCMS.TRG_TRANSLIMITCHECK_STD ENABLE; 
ALTER TRIGGER  VMSCMS.TRG_PREAUTH_STD ENABLE;   
ALTER TRIGGER  VMSCMS.TRG_CMS_C2CTXFR_TXN_STD ENABLE; 
ALTER TRIGGER  VMSCMS.TRG_PANSPPRT_STD ENABLE;   
ALTER TRIGGER  VMSCMS.TRG_CMS_STATEMENTS_LOG_STD ENABLE; 
ALTER TRIGGER  VMSCMS.TRG_CMS_TRANLOG_STD ENABLE;   
ALTER TRIGGER  VMSCMS.TRG_CMS_TRAN_LOG_DTL_STD ENABLE;
