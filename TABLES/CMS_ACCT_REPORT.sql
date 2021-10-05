CREATE TABLE VMSCMS.CMS_ACCT_REPORT
(
  REPT_ID                        NUMBER(20),
  ACCT_REPT_DATE                 DATE,
  RECORD_TYPE                    VARCHAR2(1 BYTE),
  ACCOUNT_NUMBER                 VARCHAR2(20 BYTE),
  PROGRAM_ID                     VARCHAR2(5 BYTE),
  LOCATION_ID                    VARCHAR2(30 BYTE),
  AGENT_USER_ID                  VARCHAR2(50 BYTE),
  PRODUCT_ID                     VARCHAR2(10 BYTE),
  GROUP_ID                       VARCHAR2(10 BYTE),
  ACCOUNT_TYPE                   VARCHAR2(5 BYTE),
  ACCOUNT_STATUS                 VARCHAR2(5 BYTE),
  ACCOUNT_STATUS_DATE            VARCHAR2(8 BYTE),
  ACCOUNT_CREATED_DATE           VARCHAR2(8 BYTE),
  ACCOUNT_EXPIRATION_DATE        VARCHAR2(8 BYTE),
  RELOADABLE_INDICATOR           NUMBER(1),
  CREDIT_LINE                    VARCHAR2(20 BYTE),
  AVAILABLE_CREDIT               VARCHAR2(20 BYTE),
  SECURED_AMOUNT                 VARCHAR2(20 BYTE),
  CURRENT_BALANCE                VARCHAR2(20 BYTE),
  CURRENT_BALANCE_SIGN           VARCHAR2(2 BYTE),
  CURRENT_PAYMENT_DUE_DATE       VARCHAR2(8 BYTE),
  AVAILABLE_BALANCE              VARCHAR2(20 BYTE),
  AVAILABLE_BALANCE_SIGN         VARCHAR2(2 BYTE),
  NEGATIVE_BALANCE_FEE_AMOUNT    VARCHAR2(20 BYTE),
  NEGATIVE_BAL_PRINCIPLE_AMOUNT  VARCHAR2(20 BYTE),
  CASH_ADVANCE_OUTSTANDING       VARCHAR2(20 BYTE),
  NEGATIVE_BALANCE_DATE          VARCHAR2(8 BYTE),
  DELINQUENT_AMOUNT              VARCHAR2(20 BYTE),
  DELINQUENT_DAYS                VARCHAR2(10 BYTE),
  BILL_CYCLE_DAY                 VARCHAR2(10 BYTE),
  ACCOUNT_TRANSFER_NUMBER_TO     VARCHAR2(20 BYTE),
  ACCOUNT_TRANSFER_NUMBER_FROM   VARCHAR2(20 BYTE),
  ENROLLMENT_NUMBER              VARCHAR2(20 BYTE),
  EXTERNAL_ACCOUNT_NUMBER        VARCHAR2(20 BYTE),
  FIRST_LOAD_DATE                VARCHAR2(30 BYTE),
  LAST_REAGE_DATE                VARCHAR2(20 BYTE),
  LAST_STATEMENT_DATE            VARCHAR2(30 BYTE),
  LAST_TRANSACTION_DATE          VARCHAR2(30 BYTE),
  ACCOUNT_CURRENCY_CODE          VARCHAR2(20 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_ACCT_REPORT ADD (
  CONSTRAINT PK_ACCT_REPTID
 PRIMARY KEY
 (REPT_ID, ACCT_REPT_DATE, ACCOUNT_NUMBER))
/

