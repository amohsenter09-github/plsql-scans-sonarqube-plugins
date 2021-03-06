CREATE TABLE VMSCMS.VMS_TOKEN_RESPONSE_MAST
(
  VTR_INST_CODE         NUMBER(3),
  VTR_DELIVERY_CHANNEL  NUMBER(2),
  VTR_RESPONSE_ID       NUMBER(5,0),
  VTR_ACTION_CODE       VARCHAR2(50 ),
  VTR_ERROR_CODE        VARCHAR2(50 ),
  VTR_RESP_DESC         VARCHAR2(300 ),
  VTR_SERVADV_ERRCODE   VARCHAR2(50),
  VTR_ELG_ACTION_CODE   VARCHAR2(50),
  VTR_INS_USER          NUMBER(5),
  VTR_INS_DATE          DATE,
  VTR_LUPD_USER         NUMBER(5),
  VTR_LUPD_DATE         DATE
);

create index ind_del_response on vmscms.VMS_TOKEN_RESPONSE_MAST(vtr_delivery_channel,vtr_response_id);