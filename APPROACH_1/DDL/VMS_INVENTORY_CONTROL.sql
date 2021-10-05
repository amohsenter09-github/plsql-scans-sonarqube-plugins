CREATE TABLE vmscms.VMS_INVENTORY_CONTROL(VIC_PROD_CODE VARCHAR2(20), 
VIC_CARD_TYPE      NUMBER(2),    
VIC_CONTROL_NUMBER    NUMBER(20), 
vic_max_seqno   NUMBER(20), 
VIC_INS_DATE       DATE,         
VIC_INS_USER       NUMBER(10));

alter table vmscms.VMS_INVENTORY_CONTROL add constraint pk_prod_cardtype  primary key (VIC_PROD_CODE,VIC_CARD_TYPE);


