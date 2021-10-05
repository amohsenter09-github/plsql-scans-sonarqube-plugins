CREATE TABLE VMSCMS.CMS_OPTIN_STATUS
(
  COS_INST_CODE                NUMBER(3)        NOT NULL,
  COS_CUST_ID                  NUMBER(20)       NOT NULL,
  COS_SMS_OPTINFLAG            CHAR(1 BYTE),
  COS_SMS_OPTINTIME            TIMESTAMP(6),
  COS_SMS_OPTOUTTIME           TIMESTAMP(6),
  COS_EMAIL_OPTINFLAG          CHAR(1 BYTE),
  COS_EMAIL_OPTINTIME          TIMESTAMP(6),
  COS_EMAIL_OPTOUTTIME         TIMESTAMP(6),
  COS_MARKMSG_OPTINFLAG        CHAR(1 BYTE),
  COS_MARKMSG_OPTINTIME        TIMESTAMP(6),
  COS_MARKMSG_OPTOUTTIME       TIMESTAMP(6),
  COS_GPRESIGN_OPTINFLAG       CHAR(1 BYTE),
  COS_GPRESIGN_OPTINTIME       TIMESTAMP(6),
  COS_GPRESIGN_OPTOUTTIME      TIMESTAMP(6),
  COS_SAVINGSESIGN_OPTINFLAG   CHAR(1 BYTE),
  COS_SAVINGSESIGN_OPTINTIME   TIMESTAMP(6),
  COS_SAVINGSESIGN_OPTOUTTIME  TIMESTAMP(6),
  CONSTRAINT PK_OPTIN_STATUS   PRIMARY KEY (COS_INST_CODE, COS_CUST_ID)
)TABLESPACE CMS_SML_TXN;