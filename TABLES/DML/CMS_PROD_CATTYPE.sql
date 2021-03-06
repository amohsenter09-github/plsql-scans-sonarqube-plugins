UPDATE vmscms.CMS_PROD_CATTYPE  SET CPC_RELOADABLE_FLAG =
(SELECT DECODE(CPM_VAR_FLAG,'F','N','Y') 
 FROM vmscms.CMS_PROD_MAST WHERE 
 CPM_PROD_CODE=CPC_PROD_CODE AND CPM_INST_CODE=1)
WHERE EXISTS (SELECT 1 FROM  vmscms.CMS_PROD_MAST 
WHERE CPM_PROD_CODE=CPC_PROD_CODE 
 AND CPM_INST_CODE=1 and CPM_VAR_FLAG is not null);


BEGIN

for i in (select CPM_PROD_CODE,CPM_FROM_DATE,CPM_ROUT_NUM,
CPM_INSTITUTION_ID,CPM_TRANSIT_NUMBER,CPP_EMAIL_ID,CPP_FROMEMAIL_ID,
CPP_APP_NAME,CPP_APPNTY_TYPE,CPP_SHORT_CODE,CPP_NETWORKACQID_FLAG,CPM_ISSU_BANK,
CPM_ISSU_BANK_ADDR,CPM_ICA,CPM_PROXY_LENGTH,CPP_KYCVERIFY_FLAG,CPP_CIP_INTVL,
CPM_STATEMENT_FOOTER,CPM_OLS_EXPIRY_FLAG,CPP_RENEWAL_PINMIGRATION,CPP_DUP_SSNCHK,
CPM_OLSRESP_FLAG,CPM_EMV_FLAG,CPM_RANDOM_PIN,CPM_PINCHANGE_FLAG,
CPM_POA_PROD,CPM_ONUS_AUTH_EXPIRY,CPP_WRONG_LOGONCOUNT,CPP_ACCTUNLOCK_DURATION,
CPP_CLAWBACK_DESC,CPP_ACHBLCKEXPRY_PERIOD,CPP_FEDERALCHECK_FLAG,
CPP_TANDC_VERSION,CPP_WEBAUTHMAPPING_ID,CPP_IVRAUTHMAPPING_ID,
CPP_GPRFLAG_ACHTXN,CPM_PROFILE_CODE from vmscms.cms_prod_mast,
vmscms.cms_product_param 
where cpm_inst_code=cpp_inst_code and cpm_prod_code=cpp_prod_code)
loop
BEGIN

update vmscms.CMS_PROD_CATTYPE
set CPC_FROM_DATE=I.CPM_FROM_DATE,
CPC_ROUT_NUM=I.CPM_ROUT_NUM,
CPC_INSTITUTION_ID=I.CPM_INSTITUTION_ID,
CPC_TRANSIT_NUMBER=I.CPM_TRANSIT_NUMBER,
CPC_EMAIL_ID=I.CPP_EMAIL_ID,
CPC_FROMEMAIL_ID=I.CPP_FROMEMAIL_ID,
CPC_APP_NAME=I.CPP_APP_NAME,
CPC_APPNTY_TYPE=I.CPP_APPNTY_TYPE,
CPC_SHORT_CODE=I.CPP_SHORT_CODE,
CPC_NETWORKACQID_FLAG=I.CPP_NETWORKACQID_FLAG,
CPC_ISSU_BANK=I.CPM_ISSU_BANK,
CPC_ISSU_BANK_ADDR=I.CPM_ISSU_BANK_ADDR,
CPC_ICA=I.CPM_ICA,
CPC_PROXY_LENGTH=I.CPM_PROXY_LENGTH,
CPC_KYCVERIFY_FLAG=I.CPP_KYCVERIFY_FLAG,
CPC_CIP_INTVL=I.CPP_CIP_INTVL,
CPC_STATEMENT_FOOTER=I.CPM_STATEMENT_FOOTER,
CPC_OLS_EXPIRY_FLAG=I.CPM_OLS_EXPIRY_FLAG,
CPC_RENEWAL_PINMIGRATION=I.CPP_RENEWAL_PINMIGRATION,
CPC_DUP_SSNCHK=I.CPP_DUP_SSNCHK,
CPC_OLSRESP_FLAG=I.CPM_OLSRESP_FLAG,
CPC_EMV_FLAG=I.CPM_EMV_FLAG,
CPC_RANDOM_PIN=I.CPM_RANDOM_PIN,
CPC_PINCHANGE_FLAG=I.CPM_PINCHANGE_FLAG,
CPC_POA_PROD=I.CPM_POA_PROD,
CPC_ONUS_AUTH_EXPIRY=I.CPM_ONUS_AUTH_EXPIRY,
CPC_WRONG_LOGONCOUNT=I.CPP_WRONG_LOGONCOUNT,
CPC_ACCTUNLOCK_DURATION=I.CPP_ACCTUNLOCK_DURATION,
CPC_CLAWBACK_DESC=I.CPP_CLAWBACK_DESC,
CPC_ACHBLCKEXPRY_PERIOD=I.CPP_ACHBLCKEXPRY_PERIOD,
CPC_FEDERALCHECK_FLAG=I.CPP_FEDERALCHECK_FLAG,
CPC_TANDC_VERSION=I.CPP_TANDC_VERSION,
CPC_WEBAUTHMAPPING_ID=I.CPP_WEBAUTHMAPPING_ID,
CPC_IVRAUTHMAPPING_ID=I.CPP_IVRAUTHMAPPING_ID,
CPC_GPRFLAG_ACHTXN=I.CPP_GPRFLAG_ACHTXN,
CPC_PAN_INVENTORY_FLAG='N',
CPC_PDENOM_MIN=1,
CPC_PDENOM_MAX=999999999,
CPC_PROD_DENOM='1',
CPC_DISABLE_REPL_FLAG='N',
CPC_PROD_SUFFIX=CPC_PROD_PREFIX,
CPC_START_CARD_NO=(select lpad(1, 
(select Cpc_Length from vmscms.Cms_Pan_Construct where Cpc_Profile_Code=I.CPM_PROFILE_CODE and Cpc_Field_Name='Serial Number'),0) from dual),
CPC_END_CARD_NO=(select lpad(9, (select Cpc_Length from vmscms.Cms_Pan_Construct where Cpc_Profile_Code=I.CPM_PROFILE_CODE and Cpc_Field_Name='Serial Number'),9) from dual)
 WHERE CPC_PROD_CODE=I.CPM_PROD_CODE;
 
 commit;
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error while updating this product'||i.cpm_prod_code||sqlerrm);
    END;
end loop;
EXCEPTION
WHEN OTHERS THEN
rollback;
DBMS_OUTPUT.PUT_LINE('Error in main'||sqlerrm);
END;
/


update vmscms.CMS_PROD_CATTYPE set CPC_CCF_FORMAT_VERSION='4.2';
UPDATE vmscms.CMS_PROD_CATTYPE SET CPC_DUP_SSNCHK='N' WHERE
 CPC_DUP_TIMEPERIOD IS NULL AND CPC_DUP_TIMEUNT IS NULL;