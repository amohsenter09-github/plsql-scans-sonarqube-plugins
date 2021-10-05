
SET DEFINE OFF;
Insert into vmscms.VMS_RULE_CONFIG (VRC_PARAM_ID,VRC_PARAM_VALUE) values ('RULE_TRANSACTION_TYPE','1:Activation,2:Authorization,3:Pre-Authorization,4:Reload,5:Token Provisioning,6:Spil Transaction,7:CSS Services');
Insert into vmscms.VMS_RULE_CONFIG (VRC_PARAM_ID,VRC_PARAM_VALUE) values ('operators_list','["equal","not_equal","in","not_in","less","less_or_equal","greater","greater_or_equal","between","not_between","begins_with","not_begins_with","contains","not_contains","ends_with","not_ends_with","is_empty","is_not_empty","is_null","is_not_null","di_ran","amex_ran","countEqual","countGreater","countGreaterEqual","countLesser",
"countLesserEqual","countNotEqual","activePeriod"]');
Insert into vmscms.VMS_RULE_CONFIG (VRC_PARAM_ID,VRC_PARAM_VALUE) values ('OPERATORS_CONFIG','{equal:{type:"equal",nb_inputs:1,multiple:!1,apply_to:["string",
"number","datetime","boolean"]},not_equal:{type:"not_equal",nb_inputs:1,multiple
:!1,apply_to:["string","number","datetime","boolean"]},"in":{type:"in",nb_inputs:1,
multiple:!0,apply_to:["string","number","datetime"]},not_in:{type:"not_in",nb_inputs:1,multiple:!0,apply_to:["string","number","datetime"]},less:{type:"less",nb_inputs:1,multiple:!1,apply_to:["number","datetime"]},less_or_equal:{type:"less_or_equal",nb_inputs:1,multiple:!1,apply_to:["number","datetime"]},greater:{type:"greater",nb_inputs:1,multiple:!1,apply_to:["number","datetime"]},greater_or_equal:{type:"greater_or_equal",nb_inputs:1,multiple:!1,apply_to:["number","datetime"]},between:{type:"between",nb_inputs:2,multiple:!1,apply_to:["number","datetime"]},not_between:{type:"not_between",nb_inputs:2,multiple:!1,apply_to:["number","datetime"]},begins_with:{type:"begins_with",nb_inputs:1,multiple:!1,apply_to:["string"]},not_begins_with:{type:"not_begins_with",nb_inputs:1,multiple:!1,apply_to:["string"]},contains:{type:"contains",nb_inputs:1,multiple:!1,apply_to:["string"]},not_contains:{type:"not_contains",nb_inputs:1,multiple:!1,apply_to:["string"]},ends_with:{type:"ends_with",nb_inputs:1,multiple:!1,apply_to:["string"]},not_ends_with:{type:"not_ends_with",nb_inputs:1,multiple:!1,apply_to:["string"]},is_empty:{type:"is_empty",nb_inputs:0,multiple:!1,apply_to:["string"]},is_not_empty:{type:"is_not_empty",nb_inputs:0,multiple:!1,apply_to:["string"]},is_null:{type:"is_null",nb_inputs:0,multiple:!1,apply_to:["string","number","datetime","boolean"]},is_not_null:{type:"is_not_null",nb_inputs:0,multiple:!1,apply_to:["string","number","datetime","boolean"]},di_ran:{type:"di_ran",nb_inputs:1,multiple:!1,apply_to:["string"]},amex_ran:{type:"amex_ran",nb_inputs:1,multiple:!1,apply_to:["string"]},countEqual:{type:"countEqual",nb_inputs:1,multiple:!1,apply_to:["number"]},countGreater:{type:"countGreater",nb_inputs:1,multiple:!1,apply_to:["number"]},countGreaterEqual:{type:"countGreaterEqual",nb_inputs:1,multiple:!1,apply_to:["number"]},countLesser:{type:"countLesser",nb_inputs:1,multiple:!1,apply_to:["number"]},countLesserEqual:{type:"countLesserEqual",nb_inputs:1,multiple:!1,apply_to:["number"]},countNotEqual:{type:"countNotEqual",nb_inputs:1,multiple:!1,apply_to:["number"]},
activePeriod:{type:"activePeriod",nb_inputs:1,multiple:!1,apply_to:["number"]}}');
Insert into vmscms.VMS_RULE_CONFIG (VRC_PARAM_ID,VRC_PARAM_VALUE) values ('operators','{equal:"Equal to",not_equal:"Not equal to","in":"in",
not_in:"not in",less:"Less than",less_or_equal:"Less than or equal to",
greater:"Greater than",greater_or_equal:"Greater than or equal to",between:"between",
not_between:"not between",begins_with:"Starts with",not_begins_with:"doesn't begin with",
contains:"Contains",not_contains:"Not contains",ends_with:"Ends with",
not_ends_with:"doesn't end with",is_empty:"is empty",
is_not_empty:"is not empty",is_null:"is null",
is_not_null:"is not null",di_ran:"DI_RAN",
amex_ran:"AMEX_RAN",
countEqual:"Count equal to",
countGreater:"Count greater than",countGreaterEqual:"Count Greater than equal to",
countLesser:"Count  Lesser than",countLesserEqual:"Count Lesser than equal to",
countNotEqual:"Count Not equal to",activePeriod:"Dormant period"}');
Insert into vmscms.VMS_RULE_CONFIG (VRC_PARAM_ID,VRC_PARAM_VALUE) values ('filters','[ {
    id: 'TRAN_AMT',
    label: 'Transaction Amount',
    placeholder: 'Transaction Amount',
    type: 'double',
    validation: {
      min: 0
    },
    operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  }, {
    id: 'MERCHANT_ID',
    label: 'Merchant ID',
    placeholder: 'Merchant ID',
    type: 'string',
    operators: ['di_ran','amex_ran','begins_with', 'contains', 'ends_with', 'equal', 'not_contains', 'not_equal']
  }, {
    id: 'MERCHANT_NAME',
    label: 'Merchant Name',
    placeholder: 'Merchant Name',
    type: 'string',
    operators: ['begins_with', 'contains', 'ends_with', 'equal', 'not_contains', 'not_equal']
  }, {
    id: 'STORE_ID',
    label: 'Store ID',
    type: 'string',
    operators: ['begins_with', 'contains', 'ends_with', 'equal', 'not_contains', 'not_equal']
  }
, {
    id: 'TERMINAL_ID',
    label: 'Terminal ID',
    type: 'string',
    operators: ['begins_with', 'contains', 'ends_with', 'equal', 'not_contains', 'not_equal']
  }
, {
    id: 'MERCHANT_ADDRESS1',
    label: 'Merchant Address 1',
    type: 'string',
    operators: ['begins_with', 'contains', 'ends_with', 'equal', 'not_contains', 'not_equal']
  }
, {
    id: 'MERCHANT_CITY',
    label: 'Merchant City',
    type: 'string',
    operators: ['begins_with', 'contains', 'ends_with', 'equal', 'not_contains', 'not_equal']
  }
, {
    id: 'MERCHANT_STATE',
    label: 'Merchant State / Region',
    type: 'string',
    operators: ['begins_with', 'contains', 'ends_with', 'equal', 'not_contains', 'not_equal']
  }
, {
    id: 'MERCHANT_ZIP',
    label: 'Merchant ZIP / Postal Code',
    type: 'string',
    operators: ['begins_with', 'contains', 'ends_with', 'equal', 'not_contains', 'not_equal']
  }
, {
    id: 'COUNTRY_CODE',
    label: 'Country Code',
    type: 'string',
    operators: ['equal', 'not_equal']
  }
, {
    id: 'CURRENCY_CODE',
    label: 'Currency Code',
    type: 'string',
    operators: ['equal', 'not_equal']
  }
, {
    id: 'MCC',
    label: 'MCC',
    type: 'string',
    operators: ['equal', 'not_equal']
  }
, {
    id: 'POS_ENTRY_MODE',
    label: 'POS Entry Mode',
    type: 'string',
    operators: ['equal', 'not_equal']
  }
, {
    id: 'POS_SECURITY_INDICATOR',
    label: 'POS Security Indicator',
    type: 'string',
    operators: ['equal', 'not_equal']
  }
,{
    id: 'NETWORK',
    label: 'Network',
    type: 'string',
    operators: ['begins_with', 'contains', 'ends_with', 'equal', 'not_contains', 'not_equal']
  }
, {
    id: 'PARTIAL_AUTH_INDICATOR',
    label: 'Partial Auth Indicator',
    type: 'string',
    operators: ['equal', 'not_equal']
  },{
    id: 'SYSTEM_DATE',
    label: 'System Date',
    type: 'date',
    placeholder: 'MM/DD/YYYY',
    validation: {
      format: 'MM/DD/YYYY',
      min: '01/01/2016',
      max: '01/01/2099',
callback: function(value,rule) {

var retval =$('#builder-basic').queryBuilder('validateValueInternal', rule,value);
if(typeof(retval)=='boolean')
{
if(rule.operator.nb_inputs>1)
{
var stdate=moment(rule.$el.find('.rule-value-container [name*=_value_0]').val(),rule.filter.validation.format);
var eddate=moment(rule.$el.find('.rule-value-container [name*=_value_1]').val(),rule.filter.validation.format);
if(stdate>eddate)
return 'Start Date greater than End Date';
}
}
else
{
return retval;
}
return true;
}
    },
    plugin: 'datepicker',
    plugin_config: {
      format: 'mm/dd/yyyy',
      todayBtn: 'linked',
      todayHighlight: true,
      autoclose: true
    },operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  }, {
    id: 'SYSTEM_TIME',
    label: 'System Time',
    type: 'time',
    placeholder: 'hh:mm',
validation: {
callback: function(value,rule) {
for(var l=0;l<rule.operator.nb_inputs;l++)
{
var match_result = (rule.$el.find('.rule-value-container [name*=_value_'+l+']').val().match(/^([01]?[0-9]|2[0-3]):[0-5][0-9]$/));
if(match_result==null)
return "Enter valid Time format hh:mm";
if(l==1)
{
var c= new Date();
var stime = moment(c.getMonth()+1+"/"+c.getDate()+"/"+c.getFullYear()+" "+rule.$el.find('.rule-value-container [name*=_value_0]').val(),'MM/DD/YYYY HH:mm');
var etime = moment(c.getMonth()+1+"/"+c.getDate()+"/"+c.getFullYear()+" "+rule.$el.find('.rule-value-container [name*=_value_1]').val(),'MM/DD/YYYY HH:mm');
if(stime>etime)
return 'Start Time greater than End Time';
}
}
return true;
}
},
    operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  },
    {
    id: 'LAST_ACTIVE_PERIOD',
    label: 'Last Activity Period',
    type: 'double',
    operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  },{
    id: 'DEVICE_ID',
    label: 'Device Id',
    type: 'integer',
    operators: ['equal', 'begins_with', 'ends_with', 'contains', 'not_contains', 'not_equal','countEqual','countGreater','countGreaterEqual','countLesser','countLesserEqual','countNotEqual']
     },
  {
    id: 'CHARGE_BACK_COUNT',
    label: 'Charge Back',
    type: 'string',
    operators: ['countEqual','countGreater','countGreaterEqual','countLesser','countLesserEqual','countNotEqual'],
    validation: {
    callback: function(value,rule) {
      var match_result1 = (rule.$el.find('.rule-value-container [name$=_5]').val().match('^\\d+$'));
      if (match_result1==null) {
        return 'Enter valid charge back Count';
      }
      var match_result = (rule.$el.find('.rule-value-container [name$=_6]').val().match('^\\d+$'));
      if(match_result==null){
        return 'Enter valid charge back Period';
      }
     return true;
}
}, input: function(rule, name) {
      return '\
          <input onclick="onCountClick(this);" onblur="onCountBlur(this);" value="Charge back count"  class="form-control" type="text" name="'+ name +'_5"/>\
          <input onclick="onClick(this);" onblur="onBlur(this);" class="form-control"  value="Period in days" type="text"  name="'+ name +'_6"/>';
    },
    valueGetter: function(rule) {
      return rule.$el.find('.rule-value-container [name$=_5]').val()
      +'.'+rule.$el.find('.rule-value-container [name$=_6]').val();
    },
    valueSetter: function(rule, value) {
      if (rule.operator.nb_inputs > 0) {
        var val = value.split('.');
        rule.$el.find('.rule-value-container [name$=_5]').val(val[0]);
        rule.$el.find('.rule-value-container [name$=_6]').val(val[1]);
      }
    }
  },
  {
    id: 'WALLET_ID',
    label: 'Wallet Identifier',
    type: 'string',
    operators: ['equal', 'begins_with', 'ends_with', 'contains', 'not_contains', 'not_equal','countEqual','countGreater','countGreaterEqual','countLesser','countLesserEqual','countNotEqual']

  },
  {
    id: 'RISK_ASSESMENT',
    label: 'Assesment',
    type: 'string',
    operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  },
  {
    id: 'TOKEN_SCORE',
    label: 'Token Score',
    type: 'double',
     operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  },   {
    id: 'DEVICE_LOCATION_DISTANCE',
    label: 'Device Location Distance',
    type: 'double',
     operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  },{
    id: 'DEVICE_LOCATION_COUNTRY',
    label: 'Device Location Country',
     type: 'string',
    operators: ['equal', 'not_equal','begins_with','ends_with','contains','not_contains']
  },
  {
    id: 'DEVICE_SCORE',
    label: 'Device Score',
    type: 'double',
     operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  },
  {
    id: 'ACCOUNT_SCORE',
    label: 'Account Score',
    type: 'double',
     operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  },
  {
    id: 'NETWORK_TOKEN_DECISION',
    label: 'Network Provision Decision',
    type: 'string',
    operators: ['equal', 'not_equal','begins_with','ends_with','contains','not_contains']
  },
  {
    id: 'PAN_SOURCE',
    label: 'PAN Source',
    type: 'string',
     operators: ['equal', 'not_equal','begins_with','ends_with','contains','not_contains']
  },
  {
    id: 'DEVICE_TYPE',
    label: 'Device Type',
    type: 'string',
     operators: ['equal', 'not_equal','begins_with','ends_with','contains','not_contains']
  },{
    id: 'TOKEN_STORAGE_TECHNOLOGY',
    label: 'Token Storage technology',
    type: 'string',
     operators: ['equal', 'not_equal','begins_with','ends_with','contains','not_contains']
  },
  {
    id: 'TOKEN_TYPE',
    label: 'Token Type',
    type: 'string',
     operators: ['equal', 'not_equal','begins_with','ends_with','contains','not_contains']
  },
  {
    id: 'DEVICE_ID_ADDRESS',
    label: 'Device IP Address',
    type: 'string',
    operators: ['equal', 'not_equal','begins_with','ends_with','contains','not_contains']
  },
  {
    id: 'ADDR_VERIFI_ZIP',
    label: 'Address Verification Zip',
    type: 'string',
    input: 'select',
   values: {
     'U': 'U',
      'W': 'W',
      'Y': 'Y',
      'Z': 'Z',
      'N': 'N'
    },
     operators: ['equal', 'not_equal']
  },
  {
    id: 'ADDR_VERIFI_ADDR',
    label: 'Address Verification Address',
    type: 'string',
     input: 'select',
    values: {
     'U': 'U',
      'W': 'W',
      'Y': 'Y',
      'Z': 'Z',
      'N': 'N'
    },
    operators: ['equal', 'not_equal']
  },
  {
    id: 'ADDR_VERIFI_BOTH',
    label: 'Address Verification',
    type: 'string',
     input: 'select',
    values: {
     'U': 'U',
      'W': 'W',
      'Y': 'Y',
      'Z': 'Z',
      'N': 'N'
    },
      operators: ['equal', 'not_equal']
  }, {
    id: 'BLACKLIST_PAN',
    label: 'BlackList Pan',
    type: 'string',
     input: 'textarea',
      operators: ['contains','not_contains']
  }
  ,
   {
    id: 'CVV_Length',
    label: 'CVV Length',
    type: 'double',
     operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  },
  {
    id: 'PROBABILITY_SCORE',
    label: 'Probability Score',
    type: 'string',
     operators: ['equal', 'not_equal','begins_with','ends_with','contains','not_contains']
  },
  {
    id: 'DYNAMIC_RULE_CODE',
    label: 'Dynamic Rule Code',
    type: 'string',
     operators: ['equal','not_equal','begins_with','ends_with','contains','not_contains']
  },
  {
    id: 'ACQRINST_COUNTRY_CODE',
    label: 'Acquiring Institution Country Code',
    type: 'string',
     operators: ['equal','not_equal']
  },
  {
    id: 'LAST_FOUR_DIGIT_PAN',
    label: 'Last Four Digit PAN',
    type: 'double',
    operators: ['equal', 'greater', 'greater_or_equal', 'less', 'less_or_equal', 'not_equal']
  },
  {
    id: 'PAYMENT_TYPE',
    label: 'Payment Type',
    type: 'string',
     operators: ['equal','not_equal','begins_with','ends_with','contains','not_contains']
  }  
  ]');
