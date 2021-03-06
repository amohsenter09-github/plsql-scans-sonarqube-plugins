CREATE TABLE VMSCMS.CMS_RETREQ_RESPONSE
(
  CRR_INST_CODE                 NUMBER(3),
  CRR_TRANS_CODE                VARCHAR2(2 BYTE),
  CRR_TRANSCODE_QUAL            VARCHAR2(1 BYTE),
  CRR_TRANS_COMP_SEQ_NUMB_TCR0  VARCHAR2(1 BYTE),
  CRR_PAN_CODE                  VARCHAR2(16 BYTE),
  CRR_MBR_NUMB                  VARCHAR2(3 BYTE),
  CRR_ARN_CODE                  VARCHAR2(23 BYTE),
  C1RR_ACQ_BUISS_ID             VARCHAR2(8 BYTE),
  CRR_PURCHASE_DATE             VARCHAR2(4 BYTE),
  CRR_TRANS_AMT                 VARCHAR2(12 BYTE),
  CRR_TRANS_CURR_CODE           VARCHAR2(3 BYTE),
  CRR_MERC_NAME                 VARCHAR2(25 BYTE),
  CRR_MERC_CITY                 VARCHAR2(13 BYTE),
  CRR_MERC_CNTRY_CODE           VARCHAR2(3 BYTE),
  CRR_MERC_CATG_CODE            VARCHAR2(4 BYTE),
  CRR_US_MERC_ZIP_CODE          VARCHAR2(5 BYTE),
  CRR_MERC_STATE                VARCHAR2(3 BYTE),
  CRR_ISSUER_CTRL_NUMB          VARCHAR2(9 BYTE),
  CRR_REQ_REASON_CODE           VARCHAR2(2 BYTE),
  CRR_SETTLEMENT_FLAG           VARCHAR2(1 BYTE),
  CRR_NATIONAL_REIMB_FEE        VARCHAR2(12 BYTE),
  CRR_ATM_ACCT_SELECTION        VARCHAR2(1 BYTE),
  CRR_RETREQ_ID                 VARCHAR2(12 BYTE),
  CRR_CENTRAL_PROC_DATE         VARCHAR2(4 BYTE),
  CRR_REIMB_ATTRIB              VARCHAR2(1 BYTE),
  CRR_TRANS_COMP_SEQ_NUMB_TCR1  VARCHAR2(1 BYTE),
  CRR_RESERVED_TCR1_1           VARCHAR2(12 BYTE),
  CRR_FAX_NUMBER                VARCHAR2(16 BYTE),
  CRR_INTERFACE_TRACE_NUMB      VARCHAR2(6 BYTE),
  CRR_REQ_FULLFILL_METHOD       VARCHAR2(1 BYTE),
  CRR_EST_FULLFILL_METHOD       VARCHAR2(1 BYTE),
  CRR_ISSUER_RFC_BIN            VARCHAR2(6 BYTE),
  CRR_ISSUER_RFC_SUB_ADDR       VARCHAR2(7 BYTE),
  CRR_ISSUER_BILL_CURR_CODE     VARCHAR2(3 BYTE),
  CRR_BILL_TRANS_AMT            VARCHAR2(12 BYTE),
  CRR_TRANS_IDENT               VARCHAR2(15 BYTE),
  CRR_EXCLD_TRANS_ID_REASON     VARCHAR2(1 BYTE),
  CRR_CRS_PROCESS_CODE          VARCHAR2(1 BYTE),
  CRR_MULT_CLEARING_SEQ_NUMB    VARCHAR2(2 BYTE),
  CRR_RESERVED_TCR1_2           VARCHAR2(81 BYTE),
  CRR_TRANS_COMP_SEQ_NUMB_TCR4  VARCHAR2(1 BYTE),
  CRR_RESERVED_TCR4_1           VARCHAR2(12 BYTE),
  CRR_DEBIT_PROD_CODE           VARCHAR2(4 BYTE),
  CRR_CONTACT_FOR_INFO          VARCHAR2(25 BYTE),
  CRR_RESERVED_TCR4_2           VARCHAR2(123 BYTE),
  CRR_INS_USER                  NUMBER(5),
  CRR_INS_DATE                  DATE,
  CRR_LUPD_USER                 NUMBER(5),
  CRR_LUPD_DATE                 DATE
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


