CREATE TABLE vmscms.VMS_PRODCAT_NETWORKID_MAPPING
(
VPN_INST_CODE NUMBER(3,0),
VPN_PROD_CODE VARCHAR2(20),
VPN_CARD_TYPE VARCHAR2(20),
VPN_NETWORK_ID VARCHAR2(20),
VPN_INS_USER NUMBER(5,0),
VPN_INS_DATE DATE,
VPN_LUPD_USER NUMBER(5,0),
VPN_LUPD_DATE DATE);

ALTER TABLE VMSCMS.VMS_PRODCAT_NETWORKID_MAPPING ADD CONSTRAINT PK_PRODCAT_NETWORKID_MAPPING
PRIMARY KEY (VPN_INST_CODE,VPN_PROD_CODE,VPN_CARD_TYPE,VPN_NETWORK_ID);