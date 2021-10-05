SET DEFINE OFF;
Insert into VMSCMS.MIGR_CTRL_TABLE
   (MCT_CTRL_CODE, MCT_CTRL_KEY, MCT_CTRL_NUMB, MCT_CTRL_DESC, MCT_INS_USER, MCT_INS_DATE, MCT_LUPD_USER, MCT_LUPD_DATE, MCT_INST_CODE)
 Values
   ('1', 'ACCOUNT_DATA', 1, 'Latest running number for acct data migr', 1, SYSDATE, 1, SYSDATE, 1);
Insert into VMSCMS.MIGR_CTRL_TABLE
   (MCT_CTRL_CODE, MCT_CTRL_KEY, MCT_CTRL_NUMB, MCT_CTRL_DESC, MCT_INS_USER, MCT_INS_DATE, MCT_LUPD_USER, MCT_LUPD_DATE, MCT_INST_CODE)
 Values
   ('1', 'CUSTOMER_DATA', 1, 'Latest running number for cust data migr', 1, SYSDATE, 1, SYSDATE, 1);
Insert into VMSCMS.MIGR_CTRL_TABLE
   (MCT_CTRL_CODE, MCT_CTRL_KEY, MCT_CTRL_NUMB, MCT_CTRL_DESC, MCT_INS_USER, MCT_INS_DATE, MCT_LUPD_USER, MCT_LUPD_DATE, MCT_INST_CODE)
 Values
   ('1', 'SUPPORT_DATA', 1, 'Latest running number for supprt data migr', 1, SYSDATE, 1, SYSDATE, 1);
Insert into VMSCMS.MIGR_CTRL_TABLE
   (MCT_CTRL_CODE, MCT_CTRL_KEY, MCT_CTRL_NUMB, MCT_CTRL_DESC, MCT_INS_USER, MCT_INS_DATE, MCT_LUPD_USER, MCT_LUPD_DATE, MCT_INST_CODE)
 Values
   ('1', 'TRANSACTION_DATA', 1, 'Latest running number for txn data migr', 1, SYSDATE, 1, SYSDATE, 1);
Insert into VMSCMS.MIGR_CTRL_TABLE
   (MCT_CTRL_CODE, MCT_CTRL_KEY, MCT_CTRL_NUMB, MCT_CTRL_DESC, MCT_INS_USER, MCT_INS_DATE, MCT_LUPD_USER, MCT_LUPD_DATE, MCT_INST_CODE)
 Values
   ('1', 'CALL_DATA', 1, 'Latest running number for calllog data migr', 1, SYSDATE, 1, SYSDATE, 1);      
Insert into VMSCMS.MIGR_CTRL_TABLE
   (MCT_CTRL_CODE, MCT_CTRL_KEY, MCT_CTRL_NUMB, MCT_CTRL_DESC, MCT_INS_USER, MCT_INS_DATE, MCT_LUPD_USER, MCT_LUPD_DATE, MCT_INST_CODE)
 Values
   ('1', 'COMMIT_PARAM', 1000, 'Commit Parameter for migration', 1, SYSDATE, 1, SYSDATE, 1);
COMMIT;