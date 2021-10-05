-- Add new param for maximum SMS retry limit
INSERT
INTO CMS_INST_PARAM
  (
    CIP_INST_CODE,
    CIP_PARAM_KEY,
    CIP_PARAM_DESC,
    CIP_PARAM_VALUE,
    CIP_INS_USER,
    CIP_INS_DATE,
    CIP_LUPD_USER,
    CIP_MANDATORY_FLAG,
    CIP_DISPLAY_FLAG,
    CIP_PARAM_DISP_TYPE
  )
  VALUES
  (
    1,
    'ECNS_MAX_RETRY_LIMIT',
    'ECNS Retry Limit',
    '5',
    1,
    SYSDATE,
    1,
    'Y',
    'Y',
    'TEXT'
  );
  commit;
  
  -- select * from CMS_INST_PARAM where cip_param_key = 'ECNS_MAX_RETRY_LIMIT';
  
  -- Revert script
  --delete CMS_INST_PARAM where cip_param_key = 'ECNS_MAX_RETRY_LIMIT';