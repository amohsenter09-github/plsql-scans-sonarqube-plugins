UPDATE vmscms.CMS_PRODUCT_PARAM SET CPP_SUBBIN_LENGTH=(select MAX(LENGTH(CPC_PROD_PREFIX)) from vmscms.cms_prod_cattype WHERE CPC_PROD_CODE=CPP_PROD_CODE);