CREATE TABLE VMSCMS.CMS_REQUEST_INVENTORY
(
  CRI_REF_NO                    VARCHAR2(11 BYTE),
  CRI_BRANCH_CODE               VARCHAR2(5 BYTE),
  CRI_PRODUCT_CODE              VARCHAR2(6 BYTE),
  CRI_CARD_TYPE                 NUMBER(2),
  CRI_CARD_DENIOMINATION        NUMBER(10),
  CRI_CARD_AMOUNT               NUMBER(10,2),
  CRI_NOOF_CARDS                NUMBER(5),
  CRI_INST_CODE                 NUMBER(3),
  CRI_BATCH_STATUS              VARCHAR2(1 BYTE),
  CRI_DISPATCH_DATE             DATE,
  CRI_DISPATCH_FROMCARDNO       VARCHAR2(90 BYTE),
  CRI_DISPATCH_TOCARDNO         VARCHAR2(90 BYTE),
  CRI_DISPATCH_TOTAL            NUMBER,
  CRI_COURIER_AGENCY            VARCHAR2(50 BYTE),
  CRI_RECEIPT_DATE              DATE,
  CRI_RECEIPT_TOTAL             NUMBER,
  CRI_RECEIPT_FROMCARDNO        VARCHAR2(90 BYTE),
  CRI_RECEIPT_TOCARDNO          VARCHAR2(90 BYTE),
  CRI_INS_USER                  NUMBER(5),
  CRI_INS_DATE                  DATE,
  CRI_CHECKED_USER              NUMBER(5),
  CRI_CHECKED_DATE              DATE,
  CRI_AUTH_USER                 NUMBER(5),
  CRI_AUTH_DATE                 DATE,
  CRI_LUPD_USER                 NUMBER,
  CRI_LUPD_DATE                 DATE,
  CRI_APPROVED_CARDS            NUMBER(5),
  CRI_COURIER_TRACKINGNO        VARCHAR2(15 BYTE),
  CRI_PENDING_QTY               NUMBER(5),
  CRI_DISPATCH_FROMCARDNO_ENCR  RAW(100),
  CRI_DISPATCH_TOCARDNO_ENCR    RAW(100),
  CRI_RECEIPT_FROMCARDNO_ENCR   RAW(100),
  CRI_RECEIPT_TOCARDNO_ENCR     RAW(100)
)
TABLESPACE CMS_BIG_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_REQUEST_INVENTORY ADD (
  CONSTRAINT PK_REQUEST_INVENTORY_REFNO
 PRIMARY KEY
 (CRI_REF_NO))
/

ALTER TABLE VMSCMS.CMS_REQUEST_INVENTORY ADD (
  CONSTRAINT FK_REQUEST_INVENTORY_BRANCODE 
 FOREIGN KEY (CRI_INST_CODE, CRI_BRANCH_CODE) 
 REFERENCES VMSCMS.CMS_BRAN_MAST (CBM_INST_CODE,CBM_BRAN_CODE))
/

