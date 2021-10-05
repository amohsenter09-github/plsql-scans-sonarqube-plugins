DECLARE
q1 varchar2(4000);
q2 varchar2(4000);
q3 varchar2(4000);
q4 varchar2(4000);
v_chk_tab   VARCHAR2 (10);
v_err       VARCHAR2 (1000);
BEGIN
	SELECT COUNT (1)
     INTO v_chk_tab
     FROM all_objects
    WHERE object_type = 'TABLE'
      AND owner = 'VMSCMS'
      AND object_name = 'VMS_RULE_CONFIG';

		IF v_chk_tab = 1
		THEN
		
		q1:='[ {
    id: ''TRAN_AMT'',
    label: ''Transaction Amount'',
    placeholder: ''Transaction Amount'',
    type: ''double'',
    validation: {
      min: 0
    },
    operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  }, {
    id: ''MERCHANT_ID'',
    label: ''Merchant ID'',
    placeholder: ''Merchant ID'',
    type: ''string'',
    operators: [''di_ran'',''amex_ran'',''begins_with'', ''contains'', ''ends_with'', ''equal'', ''not_contains'', ''not_equal'']
  }, {
    id: ''MERCHANT_NAME'',
    label: ''Merchant Name'',
    placeholder: ''Merchant Name'',
    type: ''string'',
    operators: [''begins_with'', ''contains'', ''ends_with'', ''equal'', ''not_contains'', ''not_equal'']
  }, {
    id: ''STORE_ID'',
    label: ''Store ID'',
    type: ''string'',
    operators: [''begins_with'', ''contains'', ''ends_with'', ''equal'', ''not_contains'', ''not_equal'']
  }
, {
    id: ''TERMINAL_ID'',
    label: ''Terminal ID'',
    type: ''string'',
    operators: [''begins_with'', ''contains'', ''ends_with'', ''equal'', ''not_contains'', ''not_equal'']
  }
, {
    id: ''MERCHANT_ADDRESS1'',
    label: ''Merchant Address 1'',
    type: ''string'',
    operators: [''begins_with'', ''contains'', ''ends_with'', ''equal'', ''not_contains'', ''not_equal'']
  }
, {
    id: ''MERCHANT_CITY'',
    label: ''Merchant City'',
    type: ''string'',
    operators: [''begins_with'', ''contains'', ''ends_with'', ''equal'', ''not_contains'', ''not_equal'']
  }
, {
    id: ''MERCHANT_STATE'',
    label: ''Merchant State / Region'',
    type: ''string'',
    operators: [''begins_with'', ''contains'', ''ends_with'', ''equal'', ''not_contains'', ''not_equal'']
  }
, {
    id: ''MERCHANT_ZIP'',
    label: ''Merchant ZIP / Postal Code'',
    type: ''string'',
    operators: [''begins_with'', ''contains'', ''ends_with'', ''equal'', ''not_contains'', ''not_equal'']
  }
, {
    id: ''COUNTRY_CODE'',
    label: ''Country Code'',
    type: ''string'',
    operators: [''equal'', ''not_equal'']
  }
, {
    id: ''CURRENCY_CODE'',
    label: ''Currency Code'',
    type: ''string'',
    operators: [''equal'', ''not_equal'']
  }
, {
    id: ''MCC'',
    label: ''MCC'',
    type: ''string'',
    operators: [''equal'', ''not_equal'']
  }
, {
    id: ''POS_ENTRY_MODE'',
    label: ''POS Entry Mode'',
    type: ''string'',
    operators: [''equal'', ''not_equal'']
  }
, {
    id: ''POS_SECURITY_INDICATOR'',
    label: ''POS Security Indicator'',
    type: ''string'',
    operators: [''equal'', ''not_equal'']
  }
,{
    id: ''NETWORK'',
    label: ''Network'',
    type: ''string'',
    operators: [''begins_with'', ''contains'', ''ends_with'', ''equal'', ''not_contains'', ''not_equal'']
  }
, {
    id: ''PARTIAL_AUTH_INDICATOR'',
    label: ''Partial Auth Indicator'',
    type: ''string'',
    operators: [''equal'', ''not_equal'']
  },{
    id: ''SYSTEM_DATE'',
    label: ''System Date'',
    type: ''date'',
    placeholder: ''MM/DD/YYYY'',
    validation: {
      format: ''MM/DD/YYYY'',
      min: ''01/01/2016'',
      max: ''01/01/2099'',
callback: function(value,rule) {

var retval =$(''#builder-basic'').queryBuilder(''validateValueInternal'', rule,value);
if(typeof(retval)==''boolean'')
{
if(rule.operator.nb_inputs>1)
{
var stdate=moment(rule.$el.find(''.rule-value-container [name*=_value_0]'').val(),rule.filter.validation.format);
var eddate=moment(rule.$el.find(''.rule-value-container [name*=_value_1]'').val(),rule.filter.validation.format);
if(stdate>eddate)
return ''Start Date greater than End Date'';
}
}
else
{
return retval;
}
return true;
}
    },
    plugin: ''datepicker'',
    plugin_config: {
      format: ''mm/dd/yyyy'',
      todayBtn: ''linked'',
      todayHighlight: true,
      autoclose: true
    },';
	
		update vmscms.vms_rule_config set VRC_PARAM_VALUE=q1 where vrc_param_id='filters';
		DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Updated ');
		
		
	q2:='operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  }, {
    id: ''SYSTEM_TIME'',
    label: ''System Time'',
    type: ''time'',
    placeholder: ''hh:mm'',
validation: {
callback: function(value,rule) {
for(var l=0;l<rule.operator.nb_inputs;l++)
{
var match_result = (rule.$el.find(''.rule-value-container [name*=_value_''+l+'']'').val().match(/^([01]?[0-9]|2[0-3]):[0-5][0-9]$/));
if(match_result==null)
return "Enter valid Time format hh:mm";
if(l==1)
{
var c= new Date();
var stime = moment(c.getMonth()+1+"/"+c.getDate()+"/"+c.getFullYear()+" "+rule.$el.find(''.rule-value-container [name*=_value_0]'').val(),''MM/DD/YYYY HH:mm'');
var etime = moment(c.getMonth()+1+"/"+c.getDate()+"/"+c.getFullYear()+" "+rule.$el.find(''.rule-value-container [name*=_value_1]'').val(),''MM/DD/YYYY HH:mm'');
if(stime>etime)
return ''Start Time greater than End Time'';
}
}
return true;
}
},
    operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  },
    {
    id: ''LAST_ACTIVE_PERIOD'',
    label: ''Last Activity Period'',
    type: ''double'',
    operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  },{
    id: ''DEVICE_ID'',
    label: ''Device Id'',
    type: ''integer'',
    operators: [''equal'', ''begins_with'', ''ends_with'', ''contains'', ''not_contains'', ''not_equal'',''countEqual'',''countGreater'',''countGreaterEqual'',''countLesser'',''countLesserEqual'',''countNotEqual'']
     },
  {
    id: ''CHARGE_BACK_COUNT'',
    label: ''Charge Back'',
    type: ''string'',
    operators: [''countEqual'',''countGreater'',''countGreaterEqual'',''countLesser'',''countLesserEqual'',''countNotEqual''],
    validation: {
    callback: function(value,rule) {
      var match_result1 = (rule.$el.find(''.rule-value-container [name$=_5]'').val().match(''^\\d+$''));
      if (match_result1==null) {
        return ''Enter valid charge back Count'';
      }
      var match_result = (rule.$el.find(''.rule-value-container [name$=_6]'').val().match(''^\\d+$''));
      if(match_result==null){
        return ''Enter valid charge back Period'';
      }
     return true;
}
}, input: function(rule, name) {
      return ''\
          <input onclick="onCountClick(this);" onblur="onCountBlur(this);" value="Charge back count"  class="form-control" type="text" name="''+ name +''_5"/>\
          <input onclick="onClick(this);" onblur="onBlur(this);" class="form-control"  value="Period in days" type="text"  name="''+ name +''_6"/>'';
    },
    valueGetter: function(rule) {
      return rule.$el.find(''.rule-value-container [name$=_5]'').val()
      +''.''+rule.$el.find(''.rule-value-container [name$=_6]'').val();
    },
    valueSetter: function(rule, value) {
      if (rule.operator.nb_inputs > 0) {
        var val = value.split(''.'');
        rule.$el.find(''.rule-value-container [name$=_5]'').val(val[0]);
        rule.$el.find(''.rule-value-container [name$=_6]'').val(val[1]);
      }
    }
  },
  {
    id: ''WALLET_ID'',
    label: ''Wallet Identifier'',
    type: ''string'',
    operators: [''equal'', ''begins_with'', ''ends_with'', ''contains'', ''not_contains'', ''not_equal'',''countEqual'',''countGreater'',''countGreaterEqual'',''countLesser'',''countLesserEqual'',''countNotEqual'']

  },
  {
    id: ''RISK_ASSESMENT'',
    label: ''Assesment'',
    type: ''string'',
    operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  },
  {
    id: ''TOKEN_SCORE'',
    label: ''Token Score'',
    type: ''double'',
     operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  },';
  
		update vmscms.vms_rule_config set VRC_PARAM_VALUE=VRC_PARAM_VALUE||q2 where vrc_param_id='filters';
		DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Updated ');
		
		q3:='{
    id: ''DEVICE_LOCATION_DISTANCE'',
    label: ''Device Location Distance'',
    type: ''double'',
     operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  },{
    id: ''DEVICE_LOCATION_COUNTRY'',
    label: ''Device Location Country'',
     type: ''string'',
    operators: [''equal'', ''not_equal'',''begins_with'',''ends_with'',''contains'',''not_contains'']
  },
  {
    id: ''DEVICE_SCORE'',
    label: ''Device Score'',
    type: ''double'',
     operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  },
  {
    id: ''ACCOUNT_SCORE'',
    label: ''Account Score'',
    type: ''double'',
     operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  },
  {
    id: ''NETWORK_TOKEN_DECISION'',
    label: ''Network Provision Decision'',
    type: ''string'',
    operators: [''equal'', ''not_equal'',''begins_with'',''ends_with'',''contains'',''not_contains'']
  },
  {
    id: ''PAN_SOURCE'',
    label: ''PAN Source'',
    type: ''string'',
     operators: [''equal'', ''not_equal'',''begins_with'',''ends_with'',''contains'',''not_contains'']
  },
  {
    id: ''DEVICE_TYPE'',
    label: ''Device Type'',
    type: ''string'',
     operators: [''equal'', ''not_equal'',''begins_with'',''ends_with'',''contains'',''not_contains'']
  },{
    id: ''TOKEN_STORAGE_TECHNOLOGY'',
    label: ''Token Storage technology'',
    type: ''string'',
     operators: [''equal'', ''not_equal'',''begins_with'',''ends_with'',''contains'',''not_contains'']
  },
  {
    id: ''TOKEN_TYPE'',
    label: ''Token Type'',
    type: ''string'',
     operators: [''equal'', ''not_equal'',''begins_with'',''ends_with'',''contains'',''not_contains'']
  },
  {
    id: ''DEVICE_ID_ADDRESS'',
    label: ''Device IP Address'',
    type: ''string'',
    operators: [''equal'', ''not_equal'',''begins_with'',''ends_with'',''contains'',''not_contains'']
  },
  {
    id: ''ADDR_VERIFI_ZIP'',
    label: ''Address Verification Zip'',
    type: ''string'',
    input: ''select'',
   values: {
     ''U'': ''U'',
      ''W'': ''W'',
      ''Y'': ''Y'',
      ''Z'': ''Z'',
      ''N'': ''N''
    },
     operators: [''equal'', ''not_equal'']
  },
  {
    id: ''ADDR_VERIFI_ADDR'',
    label: ''Address Verification Address'',
    type: ''string'',
     input: ''select'',
    values: {
     ''U'': ''U'',
      ''W'': ''W'',
      ''Y'': ''Y'',
      ''Z'': ''Z'',
      ''N'': ''N''
    },
    operators: [''equal'', ''not_equal'']
  },
  {
    id: ''ADDR_VERIFI_BOTH'',
    label: ''Address Verification'',
    type: ''string'',
     input: ''select'',
    values: {
     ''U'': ''U'',
      ''W'': ''W'',
      ''Y'': ''Y'',
      ''Z'': ''Z'',
      ''N'': ''N''
    },
      operators: [''equal'', ''not_equal'']
  }, {
    id: ''BLACKLIST_PAN'',
    label: ''BlackList Pan'',
    type: ''string'',
     input: ''textarea'',
      operators: [''contains'',''not_contains'']
  }
  ,
   {
    id: ''CVV_Length'',
    label: ''CVV Length'',
    type: ''double'',
     operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  },
  {
    id: ''PROBABILITY_SCORE'',
    label: ''Probability Score'',
    type: ''string'',
     operators: [''equal'', ''not_equal'',''begins_with'',''ends_with'',''contains'',''not_contains'']
  },
  {
    id: ''DYNAMIC_RULE_CODE'',
    label: ''Dynamic Rule Code'',
    type: ''string'',
     operators: [''equal'',''not_equal'',''begins_with'',''ends_with'',''contains'',''not_contains'']
  },';
  
  update vmscms.vms_rule_config set VRC_PARAM_VALUE=VRC_PARAM_VALUE||q3 where vrc_param_id='filters';
		DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Updated ');
		
		q4:='{
    id: ''ACQRINST_COUNTRY_CODE'',
    label: ''Acquiring Institution Country Code'',
    type: ''string'',
     operators: [''equal'',''not_equal'']
  },
  {
    id: ''LAST_FOUR_DIGIT_PAN'',
    label: ''Last Four Digit PAN'',
    type: ''double'',
    operators: [''equal'', ''greater'', ''greater_or_equal'', ''less'', ''less_or_equal'', ''not_equal'']
  },
  {
    id: ''PAYMENT_TYPE'',
    label: ''Payment Type'',
    type: ''string'',
     operators: [''equal'', ''not_equal'',''begins_with'',''ends_with'',''contains'',''not_contains'']
  },

  {
    id: ''CARD_PRESENT_INDICATOR'',
    label: ''Card Present Indicator'',
    type: ''string'',
     operators: [''equal'', ''not_equal'']
  }

,{
    id: ''VELOCITY_CONTROL_DEVICE_COUNT'',
    label: ''Velocity Control Device Count'',
    type: ''string'',
    operators: [''countEqual'',''countGreaterEqual'',''countLesser'',''countLesserEqual''],
    validation: {
    callback: function(value,rule) {
      var match_result7 = (rule.$el.find(''.rule-value-container [name$=_7]'').val().match(''^\\d+$''));
      if (match_result7==null) {
        return ''Enter valid Velocity Control Device Count'';
      }
      var match_result8 = (rule.$el.find(''.rule-value-container [name$=_8]'').val().match(''^\\d+$''));
      if(match_result8==null){
        return ''Enter valid Velocity Control Device Count Period in days'';
      }
     return true;
}
}, input: function(rule, name) {
      return ''\
          <input onclick="onCountClick(this);" onblur="onCountBlur(this);"  placeholder="Velocity Control Device Count"  class="form-control" type="text" name="''+ name +''_7"/>\
          <input onclick="onClick(this);" onblur="onBlur(this);" class="form-control"  placeholder="Device Count Period in days" type="text"  name="''+ name +''_8"/>'';
    },
    valueGetter: function(rule) {
      return rule.$el.find(''.rule-value-container [name$=_7]'').val()
      +''.''+rule.$el.find(''.rule-value-container [name$=_8]'').val();
    },
    valueSetter: function(rule, value) {
      if (rule.operator.nb_inputs > 0) {
        var val = value.split(''.'');
        rule.$el.find(''.rule-value-container [name$=_7]'').val(val[0]);
        rule.$el.find(''.rule-value-container [name$=_8]'').val(val[1]);
      }
    }
  }

  ]';
  
			update vmscms.vms_rule_config set VRC_PARAM_VALUE=VRC_PARAM_VALUE||q4 where VRC_PARAM_ID='filters';
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Updated ');
	  
	    ELSE
      DBMS_OUTPUT.put_line ('Backup Object Not Found');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      v_err := SUBSTR (SQLERRM, 1, 100);
      DBMS_OUTPUT.put_line ('Main Excp ' || v_err);
END;
/