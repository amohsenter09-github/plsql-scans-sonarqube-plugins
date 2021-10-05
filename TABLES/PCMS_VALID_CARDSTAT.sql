CREATE TABLE VMSCMS.PCMS_VALID_CARDSTAT
(
  PVC_INST_CODE         NUMBER,
  PVC_CARD_STAT         VARCHAR2(2 BYTE),
  PVC_TRAN_CODE         VARCHAR2(2 BYTE),
  PVC_INS_USER          NUMBER(5),
  PVC_INS_DATE          DATE,
  PVC_LUPD_DATE         DATE,
  PVC_LUPD_USER         NUMBER(10),
  PVC_DELIVERY_CHANNEL  VARCHAR2(3 BYTE)
)
TABLESPACE CMS_SML_TXN
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


