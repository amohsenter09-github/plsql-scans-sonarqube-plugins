create or replace
package vmscms.vmsfunutilities as
procedure get_currency_code(
      p_prod_code_in in cms_prod_mast.cpm_prod_code%type,
      p_card_type_in in cms_prod_cattype.cpc_card_type%type,
      p_inst_code_in in cms_inst_mast.cim_inst_code%type,
      p_currency_code_out out cms_bin_param.cbp_param_value%type,
      p_err_msg_out out varchar2);
PROCEDURE get_expiry_date(
    p_inst_code_in number,
    p_prod_code_in    VARCHAR2,
    p_card_type_in    NUMBER,
    p_profile_code_in VARCHAR2,
    p_expiry_date_out OUT DATE,
    p_resp_msg_out OUT VARCHAR2);
end;
/
show error