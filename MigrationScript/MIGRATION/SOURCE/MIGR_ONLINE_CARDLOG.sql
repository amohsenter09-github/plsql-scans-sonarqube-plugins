CREATE TABLE VMSCMS.MIGR_ONLINE_CARDLOG
(
  TITLE                VARCHAR2(1 BYTE),
  FIRST_NAME           VARCHAR2(40 BYTE)        NOT NULL,
  LAST_NAME            VARCHAR2(40 BYTE),
  ID_NUMBER            VARCHAR2(40 BYTE),
  INITIAL_TOPUP_AMT    VARCHAR2(20 BYTE),
  BIRTH_DATE           VARCHAR2(8 BYTE),
  PERM_ADDR_LINE1      VARCHAR2(50 BYTE),
  PERM_ADDR_LINE2      VARCHAR2(50 BYTE),
  PERM_ADDR_CITY       VARCHAR2(40 BYTE),
  PERM_ADDR_STATE      VARCHAR2(3 BYTE),
  PERM_ADDR_CNTRY      VARCHAR2(3 BYTE),
  PERM_ADDR_ZIP        VARCHAR2(15 BYTE),
  PERM_ADDR_PHONE      VARCHAR2(40 BYTE),
  PERM_ADDR_MOBILE     VARCHAR2(20 BYTE),
  MAIL_ADDR_LINE1      VARCHAR2(50 BYTE),
  MAIL_ADDR_LINE2      VARCHAR2(50 BYTE),
  MAIL_ADDR_CITY       VARCHAR2(40 BYTE),
  MAIL_ADDR_STATE      VARCHAR2(3 BYTE),
  MAIL_ADDR_CNTRY      VARCHAR2(3 BYTE),
  MAIL_ADDR_ZIP        VARCHAR2(15 BYTE),
  MAIL_ADDR_PHONE      VARCHAR2(40 BYTE),
  MAIL_ADDR_MOBILE     VARCHAR2(20 BYTE),
  EMAIL_ADDRESS        VARCHAR2(50 BYTE),
  PRODUCT_CODE         VARCHAR2(6 BYTE)         NOT NULL,
  PROD_CATG_CODE       NUMBER(2)                NOT NULL,
  BRANCH_ID            VARCHAR2(6 BYTE),
  MERCHANT_ID          VARCHAR2(15 BYTE),
  CARD_NUMBER          VARCHAR2(4000 BYTE),
  CARD_STAT            VARCHAR2(2 BYTE),
  PROXY_NUMBER         VARCHAR2(19 BYTE),
  STARTER_CARD_FLAG    VARCHAR2(1 BYTE),
  ACTIVE_DATE_TIME     VARCHAR2(17 BYTE),
  EXPIRY_DATE          VARCHAR2(8 BYTE),
  PANGEN_DATE_TIME     VARCHAR2(17 BYTE),
  ATM_OFFLINE_LIMIT    NUMBER(10),
  ATM_ONLINE_LIMIT     NUMBER(10),
  POS_OFFLINE_LIMIT    NUMBER(10),
  POS_ONLINE_LIMIT     NUMBER(10),
  OFFLINE_AGGR_LIMIT   NUMBER(10),
  ONLINE_AGGR_LIMIT    NUMBER(10),
  MMPOS_ONLINE_LIMIT   NUMBER(10),
  MMPOS_OFFLINE_LIMIT  NUMBER(10),
  PIN_OFFSET           VARCHAR2(10 BYTE),
  NEXT_BILL_DATE       VARCHAR2(8 BYTE),
  NEXT_MON_BILL_DATE   VARCHAR2(8 BYTE),
  EMBOSS_DATE          VARCHAR2(17 BYTE),
  EMBOSS_FLAG          VARCHAR2(1 BYTE),
  PINGEN_DATE          VARCHAR2(17 BYTE),
  PIN_FLAG             VARCHAR2(1 BYTE),
  CCF_FILE_NAME        VARCHAR2(50 BYTE),
  KYC_FLAG             VARCHAR2(1 BYTE),
  TOTAL_ACCTS          VARCHAR2(2 BYTE),
  ACCT_NUMB1           VARCHAR2(20 BYTE),
  ACCT_NUMB2           VARCHAR2(20 BYTE),
  ACCT_NUMB3           VARCHAR2(20 BYTE),
  ACCT_NUMB4           VARCHAR2(20 BYTE),
  ACCT_NUMB5           VARCHAR2(20 BYTE),
  SAVING_ACCT          VARCHAR2(20 BYTE),
  SERIAL_NUMBER        VARCHAR2(40 BYTE),
  INITIAL_LOAD_FLAG    VARCHAR2(1 BYTE),
  SEC_QUES_ONE         VARCHAR2(200 BYTE),
  SEC_ANS_ONE          VARCHAR2(100 BYTE),
  SEC_QUES_TWO         VARCHAR2(200 BYTE),
  SEC_ANS_TWO          VARCHAR2(100 BYTE),
  SEC_QUES_THREE       VARCHAR2(200 BYTE),
  SEC_ANS_THREE        VARCHAR2(100 BYTE),
  CUST_USERNAME        VARCHAR2(15 BYTE),
  CUST_PASSWORD        VARCHAR2(100 BYTE),
  SMS_ALERT_FLAG       VARCHAR2(1 BYTE),
  EMAIL_ALERT_FLAG     VARCHAR2(1 BYTE),
  STORE_ID             VARCHAR2(15 BYTE),
  ID_TYPE              VARCHAR2(5 BYTE),
  ID_ISSUER            VARCHAR2(40 BYTE),
  ID_ISSUE_DATE        VARCHAR2(75 BYTE),
  ID_EXPRY_DATE        VARCHAR2(75 BYTE)
);