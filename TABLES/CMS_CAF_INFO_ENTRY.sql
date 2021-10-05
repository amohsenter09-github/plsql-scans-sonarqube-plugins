CREATE TABLE VMSCMS.CMS_CAF_INFO_ENTRY
(
  CCI_INST_CODE             NUMBER(3),
  CCI_FILE_NAME             VARCHAR2(35 BYTE),
  CCI_ROW_ID                VARCHAR2(8 BYTE)    NOT NULL,
  CCI_APPL_CODE             VARCHAR2(30 BYTE),
  CCI_APPL_NO               VARCHAR2(21 BYTE),
  CCI_PAN_CODE              VARCHAR2(90 BYTE),
  CCI_MBR_NUMB              VARCHAR2(3 BYTE),
  CCI_CRD_STAT              CHAR(1 BYTE),
  CCI_EXP_DAT               VARCHAR2(4 BYTE),
  CCI_REC_TYP               CHAR(1 BYTE),
  CCI_CRD_TYP               VARCHAR2(5 BYTE),
  CCI_REQUESTER_NAME        VARCHAR2(40 BYTE),
  CCI_PROD_CODE             VARCHAR2(12 BYTE),
  CCI_CARD_TYPE             NUMBER(2)           DEFAULT 1,
  CCI_FIID                  VARCHAR2(4 BYTE),
  CCI_CUST_ID               NUMBER(10),
  CCI_CUST_CATG             VARCHAR2(9 BYTE),
  CCI_CUSTAPPL_PARAM1       VARCHAR2(100 BYTE),
  CCI_CUSTAPPL_PARAM2       VARCHAR2(100 BYTE),
  CCI_CUSTAPPL_PARAM3       VARCHAR2(100 BYTE),
  CCI_CUSTAPPL_PARAM4       VARCHAR2(100 BYTE),
  CCI_CUSTAPPL_PARAM5       VARCHAR2(100 BYTE),
  CCI_CUSTAPPL_PARAM6       VARCHAR2(100 BYTE),
  CCI_CUSTAPPL_PARAM7       VARCHAR2(100 BYTE),
  CCI_CUSTAPPL_PARAM8       VARCHAR2(100 BYTE),
  CCI_CUSTAPPL_PARAM9       VARCHAR2(100 BYTE),
  CCI_CUSTAPPL_PARAM10      VARCHAR2(100 BYTE),
  CCI_TITLE                 VARCHAR2(5 BYTE),
  CCI_BIRTH_DATE            DATE,
  CCI_MOTHERS_MAIDEN_NAME   VARCHAR2(40 BYTE),
  CCI_SSN                   VARCHAR2(10 BYTE),
  CCI_HOBBIES               VARCHAR2(50 BYTE),
  CCI_CUSTOMER_PARAM1       VARCHAR2(100 BYTE),
  CCI_CUSTOMER_PARAM2       VARCHAR2(100 BYTE),
  CCI_CUSTOMER_PARAM3       VARCHAR2(100 BYTE),
  CCI_CUSTOMER_PARAM4       VARCHAR2(100 BYTE),
  CCI_CUSTOMER_PARAM5       VARCHAR2(100 BYTE),
  CCI_CUSTOMER_PARAM6       VARCHAR2(100 BYTE),
  CCI_CUSTOMER_PARAM7       VARCHAR2(100 BYTE),
  CCI_CUSTOMER_PARAM8       VARCHAR2(100 BYTE),
  CCI_CUSTOMER_PARAM9       VARCHAR2(100 BYTE),
  CCI_CUSTOMER_PARAM10      VARCHAR2(100 BYTE),
  CCI_COMM_TYPE             VARCHAR2(3 BYTE),
  CCI_SEG12_BRANCH_NUM      VARCHAR2(4 BYTE),
  CCI_SEG12_NAME_LINE1      VARCHAR2(40 BYTE),
  CCI_SEG12_NAME_LINE2      VARCHAR2(40 BYTE),
  CCI_SEG12_ADDR_LINE1      VARCHAR2(50 BYTE),
  CCI_SEG12_ADDR_LINE2      VARCHAR2(50 BYTE),
  CCI_SEG12_CITY            VARCHAR2(40 BYTE),
  CCI_SEG12_STATE           VARCHAR2(3 BYTE),
  CCI_SEG12_POSTAL_CODE     VARCHAR2(15 BYTE),
  CCI_SEG12_COUNTRY_CODE    VARCHAR2(3 BYTE),
  CCI_SEG12_MOBILENO        VARCHAR2(40 BYTE),
  CCI_SEG12_HOMEPHONE_NO    VARCHAR2(40 BYTE),
  CCI_SEG12_OFFICEPHONE_NO  VARCHAR2(40 BYTE),
  CCI_SEG12_EMAILID         VARCHAR2(50 BYTE),
  CCI_SEG12_ADDR_PARAM1     VARCHAR2(100 BYTE),
  CCI_SEG12_ADDR_PARAM2     VARCHAR2(100 BYTE),
  CCI_SEG12_ADDR_PARAM3     VARCHAR2(100 BYTE),
  CCI_SEG12_ADDR_PARAM4     VARCHAR2(100 BYTE),
  CCI_SEG12_ADDR_PARAM5     VARCHAR2(100 BYTE),
  CCI_SEG12_ADDR_PARAM6     VARCHAR2(100 BYTE),
  CCI_SEG12_ADDR_PARAM7     VARCHAR2(100 BYTE),
  CCI_SEG12_ADDR_PARAM8     VARCHAR2(100 BYTE),
  CCI_SEG12_ADDR_PARAM9     VARCHAR2(100 BYTE),
  CCI_SEG12_ADDR_PARAM10    VARCHAR2(100 BYTE),
  CCI_SEG13_ADDR_LINE1      VARCHAR2(50 BYTE),
  CCI_SEG13_ADDR_LINE2      VARCHAR2(50 BYTE),
  CCI_SEG13_CITY            VARCHAR2(40 BYTE),
  CCI_SEG13_STATE           VARCHAR2(3 BYTE),
  CCI_SEG13_POSTAL_CODE     VARCHAR2(15 BYTE),
  CCI_SEG13_COUNTRY_CODE    VARCHAR2(3 BYTE),
  CCI_SEG13_MOBILENO        VARCHAR2(15 BYTE),
  CCI_SEG13_HOMEPHONE_NO    VARCHAR2(40 BYTE),
  CCI_SEG13_OFFICEPHONE_NO  VARCHAR2(40 BYTE),
  CCI_SEG13_EMAILID         VARCHAR2(50 BYTE),
  CCI_SEG13_ADDR_PARAM1     VARCHAR2(100 BYTE),
  CCI_SEG13_ADDR_PARAM2     VARCHAR2(100 BYTE),
  CCI_SEG13_ADDR_PARAM3     VARCHAR2(100 BYTE),
  CCI_SEG13_ADDR_PARAM4     VARCHAR2(100 BYTE),
  CCI_SEG13_ADDR_PARAM5     VARCHAR2(100 BYTE),
  CCI_SEG13_ADDR_PARAM6     VARCHAR2(100 BYTE),
  CCI_SEG13_ADDR_PARAM7     VARCHAR2(100 BYTE),
  CCI_SEG13_ADDR_PARAM8     VARCHAR2(100 BYTE),
  CCI_SEG13_ADDR_PARAM9     VARCHAR2(100 BYTE),
  CCI_SEG13_ADDR_PARAM10    VARCHAR2(100 BYTE),
  CCI_SEG31_LGTH            VARCHAR2(4 BYTE),
  CCI_SEG31_ACCT_CNT        VARCHAR2(4 BYTE),
  CCI_SEG31_TYP             VARCHAR2(2 BYTE),
  CCI_SEG31_NUM             VARCHAR2(19 BYTE),
  CCI_SEG31_NUM_PARAM1      VARCHAR2(100 BYTE),
  CCI_SEG31_NUM_PARAM2      VARCHAR2(100 BYTE),
  CCI_SEG31_NUM_PARAM3      VARCHAR2(100 BYTE),
  CCI_SEG31_NUM_PARAM4      VARCHAR2(100 BYTE),
  CCI_SEG31_NUM_PARAM5      VARCHAR2(100 BYTE),
  CCI_SEG31_NUM_PARAM6      VARCHAR2(100 BYTE),
  CCI_SEG31_NUM_PARAM7      VARCHAR2(100 BYTE),
  CCI_SEG31_NUM_PARAM8      VARCHAR2(100 BYTE),
  CCI_SEG31_NUM_PARAM9      VARCHAR2(100 BYTE),
  CCI_SEG31_NUM_PARAM10     VARCHAR2(100 BYTE),
  CCI_SEG31_STAT            CHAR(1 BYTE),
  CCI_PROD_AMT              VARCHAR2(10 BYTE),
  CCI_FEE_AMT               VARCHAR2(10 BYTE),
  CCI_TOT_AMT               VARCHAR2(10 BYTE),
  CCI_PAYMENT_MODE          VARCHAR2(15 BYTE),
  CCI_INSTRUMENT_NO         VARCHAR2(15 BYTE),
  CCI_INSTRUMENT_AMT        VARCHAR2(10 BYTE),
  CCI_DRAWN_DATE            VARCHAR2(20 BYTE),
  CCI_PAYREF_NO             VARCHAR2(20 BYTE),
  CCI_EMP_ID                VARCHAR2(15 BYTE),
  CCI_KYC_REASON            VARCHAR2(30 BYTE),
  CCI_KYC_FLAG              VARCHAR2(1 BYTE)    DEFAULT 'N'                   NOT NULL,
  CCI_ADDON_FLAG            VARCHAR2(6 BYTE)    DEFAULT 'False',
  CCI_VIRTUAL_ACCT          VARCHAR2(19 BYTE),
  CCI_DOCUMENT_VERIFY       VARCHAR2(100 BYTE),
  CCI_EXCHANGE_RATE         VARCHAR2(25 BYTE),
  CCI_UPLD_STAT             VARCHAR2(1 BYTE),
  CCI_APPROVED              VARCHAR2(1 BYTE)    DEFAULT 'N',
  CCI_COMMENTS              VARCHAR2(200 BYTE),
  CCI_INSTRUMENT_REALISED   VARCHAR2(1 BYTE),
  CCI_PROCESS_MSG           VARCHAR2(500 BYTE),
  CCI_MAKER_USER_ID         NUMBER(5),
  CCI_MAKER_DATE            DATE,
  CCI_CHECKER_USER_ID       NUMBER(5),
  CCI_CHEKER_DATE           DATE,
  CCI_AUTH_USER_ID          NUMBER(5),
  CCI_AUTH_DATE             DATE,
  CCI_INS_USER              NUMBER(5),
  CCI_INS_DATE              DATE                NOT NULL,
  CCI_LUPD_USER             NUMBER(5),
  CCI_LUPD_DATE             DATE,
  CCI_CVV                   VARCHAR2(3 BYTE),
  CCI_KYCUPLOAD_USER_ID     NUMBER(5),
  CCI_KYCUPLOAD_DATE        DATE,
  CCI_KYCUPLOAD_FILENAME    VARCHAR2(50 BYTE),
  CCI_KYCPROCESS_STAT       VARCHAR2(1 BYTE),
  CCI_KYCPRCESS_MESSAGE     VARCHAR2(300 BYTE),
  CCI_CARD_NUMBER           VARCHAR2(90 BYTE),
  CCI_ENTRY_REC_TYPE        VARCHAR2(1 BYTE),
  CCI_PAN_CODE_ENCR         RAW(100),
  CCI_CARD_NUMBER_ENCR      RAW(100),
  CCI_STORE_ID              VARCHAR2(15 BYTE),
  CCI_ID_ISSUER             VARCHAR2(40 BYTE),
  CCI_ID_NUMBER             VARCHAR2(40 BYTE),
  CCI_ID_ISSUANCE_DATE      DATE,
  CCI_ID_EXPIRY_DATE        DATE,
  CCI_IDOLOGY_ID            NUMBER(10),
  CCI_QUESTION_ONE          VARCHAR2(500 BYTE),
  CCI_QUESTION_TWO          VARCHAR2(500 BYTE),
  CCI_QUESTION_THREE        VARCHAR2(500 BYTE),
  CCI_ANSWER_ONE            VARCHAR2(500 BYTE),
  CCI_ANSWER_TWO            VARCHAR2(500 BYTE),
  CCI_ANSWER_THREE          VARCHAR2(500 BYTE),
  CCI_TYPE_ONE              VARCHAR2(100 BYTE),
  CCI_TYPE_TWO              VARCHAR2(100 BYTE),
  CCI_TYPE_THREE            VARCHAR2(100 BYTE),
  CCI_ALTERNATE_ID          VARCHAR2(100 BYTE),
  CCI_CIP_CHECK             VARCHAR2(3 BYTE),
  CCI_SEG12_STATE_CODE      NUMBER(3),
  CCI_SEG13_STATE_CODE      NUMBER(3),
  CCI_OFAC_FAIL_FLAG        VARCHAR2(1 BYTE)    DEFAULT 'N',
  CCI_KYC_REG_DATE          DATE,
  CCI_SSN_FLAG              VARCHAR2(2 BYTE)    DEFAULT 'N',
  CCI_SSNFAIL_DTLS          VARCHAR2(4000 BYTE),
  CCI_PACKAGE_TYPE          VARCHAR2(4 BYTE),
  CCI_STARTER_CARD_NO       VARCHAR2(90 BYTE),
  CCI_STARTER_CARD_NO_ENCR  RAW(100),
  CCI_STARTER_ACCT_NO       VARCHAR2(20 BYTE),
  CCI_OVERRIDE_FLAG         NUMBER(1)           DEFAULT 0,
  CCI_ORIG_ROWID            VARCHAR2(8 BYTE)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/

