alter table vmscms.VMS_RULE_PARAMETERS drop CONSTRAINT CHECK_RULEPARAM_TYPE;  
alter table vmscms.VMS_RULE_PARAMETERS add CONSTRAINT CHECK_RULEPARAM_TYPE 
CHECK (VRP_PARAM_TYPE IN ('1','2','3','4','5'));