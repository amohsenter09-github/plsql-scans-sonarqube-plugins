CREATE OR REPLACE PACKAGE VMSCMS.VMSB2BAPI
AS
   -- Author  : MageshKumar
   -- Created : 27-July-2017
   -- Purpose : B2B APIS

   -- Public type declarations

   -- Public constant declarations

   -- Public variable declarations

   -- Public function and procedure declarations


   PROCEDURE process_order_request (p_inst_code_in    IN     NUMBER,
                                    p_order_id_in     IN     VARCHAR2,
                                    p_partner_id_in   IN     VARCHAR2,
                                    P_USER_CODE_IN    IN     NUMBER,
                                    p_resp_msg_out       OUT VARCHAR2);

   PROCEDURE get_serials (p_productid_in   IN     VARCHAR2,
                          p_quantity_in    IN     NUMBER,
                          p_serials_out       OUT shuffle_array_typ,
                          p_respmsg_out       OUT VARCHAR2
                          );

   PROCEDURE delete_cards (p_card_nos_in    IN     shuffle_array_typ,
                           p_resp_msg_out      OUT VARCHAR2);
PROCEDURE cancel_order_request(
    p_inst_code_in  IN NUMBER,
    p_order_id_in   IN VARCHAR2,
    p_partner_id_in IN VARCHAR2,
    p_resp_Code_out OUT VARCHAR2,
    p_resp_msg_out OUT VARCHAR2)  ;  
    PROCEDURE cancel_order_process(
    p_inst_code_in  IN NUMBER,
    p_order_id_in   IN VARCHAR2,
    p_partner_id_in IN VARCHAR2,
    p_resp_Code_out OUT VARCHAR2,
    p_resp_msg_out OUT VARCHAR2,
    P_postback_URL_OUT OUT VARCHAR2);
END VMSB2BAPI;
/
show error
