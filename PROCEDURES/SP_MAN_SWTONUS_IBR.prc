CREATE OR REPLACE PROCEDURE VMSCMS.SP_MAN_SWTONUS_IBR(ERRMSG OUT VARCHAR2) IS
  C_TRAN_FLAG VARCHAR2(3) := 'SWT';
  c_ReconCode NUMBER(2) := 2;
BEGIN
  errmsg := 'OK';
  INSERT INTO REC_SWTHOST_BASE2ONUS_IBR
    (RSB_RECON,
     RSB_PROCESS_DATE,
     RSB_FILE_NAME,
     RSB_TRAN_TYP,
     RSB_RESP_CDE,
     RSB_RVSL_CDE,
     RSB_POST_DAT,
     RSB_ACQ_INST_ID_NUM,
     RSB_TERM_ID,
     RSB_TERM_NAME_LOC,
     RSB_TERM_OWNER_NAME,
     RSB_TERM_CITY,
     RSB_TERM_ST_X,
     RSB_TERM_CNTRY_X,
     RSB_SEQ_NUM,
     RSB_INVOICE_NUM,
     RSB_RETL_ID,
     RSB_TRAN_CDE,
     RSB_RESPONDER,
     RSB_PAN,
     RSB_MBR_NUM,
     RSB_AMT1,
     RSB_AMT2,
     RSB_SETL_CRNCY_CDE,
     RSB_SETL_CONV_RATE,
     RSB_TRAN_DAT,
     RSB_TRAN_TIM,
     RSB_PT_SRV_COND_CDE,
     RSB_PT_SRV_ENTRY_MDE,
     RSB_FROM_ACCT_TYP,
     RSB_FROM_ACCT,
     RSB_ORIG_CRNCY_CDE,
     RSB_RESP,
     RSB_MAT_CAT_CODE,
     RSB_TRACE_NUM,
     RSB_RRN,
     RSB_TYPE_FLAG,
     RSB_MAN_REC)
    SELECT c_ReconCode,
           SYSDATE,
           RSB.RSB_FILE_NAME,
           RSB.RSB_TRAN_TYP,
           RSB.RSB_RESP_CDE,
           RSB.RSB_RVSL_CDE,
           RSB.RSB_POST_DAT,
           RSB.RSB_ACQ_INST_ID_NUM,
           RSB.RSB_TERM_ID,
           RSB.RSB_TERM_NAME_LOC,
           RSB.RSB_TERM_OWNER_NAME,
           RSB.RSB_TERM_CITY,
           RSB.RSB_TERM_ST_X,
           RSB.RSB_TERM_CNTRY_X,
           RSB.RSB_SEQ_NUM,
           RSB.RSB_INVOICE_NUM,
           RSB.RSB_RETL_ID,
           RSB.RSB_TRAN_CDE,
           RSB.RSB_RESPONDER,
           RSB.RSB_PAN,
           RSB.RSB_MBR_NUM,
           RSB.RSB_AMT1,
           RSB.RSB_AMT2,
           RSB.RSB_SETL_CRNCY_CDE,
           RSB.RSB_SETL_CONV_RATE,
           RSB.RSB_TRAN_DAT,
           RSB.RSB_TRAN_TIM,
           RSB.RSB_PT_SRV_COND_CDE,
           RSB.RSB_PT_SRV_ENTRY_MDE,
           RSB.RSB_FROM_ACCT_TYP,
           RSB.RSB_FROM_ACCT,
           RSB.RSB_ORIG_CRNCY_CDE,
           RSB.RSB_RESP,
           RSB.RSB_MAT_CAT_CODE,
           RSB.RSB_TRACE_NUM,
           RSB.RSB_rrn,
           C_TRAN_FLAG,
           RSB_MAN_REC
      FROM REC_SWT_BASE2ONUS_IBR RSB
     WHERE RSB.RSB_MAN_REC >= '1';
  INSERT INTO REC_GEFU_SWTHOST_IBRONUS_TEMP
    (RGS_REC_TYPE,
     RGS_SEQ_NUM,
     RGS_TRAN_DATE,
     RGS_PAN_CODE,
     RGS_MBR_NUMB,
     RGS_ACCT_NO,
     RGS_ILF_AMT,
     RGS_CTF_AMT,
     RGS_TERM_ID,
     RGS_term_owner,
     RGS_RETL_ID,
     RGS_MAT_CAT_CODE,
     RGS_TRAN_CDE,
     RGS_ACQ_INST_ID_NUM,
     RGS_INS_USER,
     RGS_INS_DATE,
     RGS_LUPD_USER,
     RGS_LUPD_DATE,
     RGS_TYPE_FLAG,
     RGS_MAN_REC
     )
    SELECT RSB.RSB_REC_TYP,
           RSB.RSB_SEQ_NUM,
           RSB.RSB_TRAN_DAT,
           RSB.RSB_PAN,
           RSB.RSB_MBR_NUM,
           RSB.RSB_FROM_ACCT,
           RSB.RSB_AMT1,
           0,
           RSB.RSB_TERM_ID,
           RSB.RSB_TERM_OWNER_NAME,
           RSB.RSB_RETL_ID,
           RSB.RSB_MAT_CAT_CODE,
           RSB.RSB_TRAN_CDE,
           RSB.RSB_ACQ_INST_ID_NUM,
           1,
           SYSDATE,
           1,
           SYSDATE,
           C_TRAN_FLAG,
           RSB_MAN_REC
      FROM REC_SWT_BASE2ONUS_IBR RSB
     WHERE RSB.RSB_MAN_REC >= 2;
  DELETE FROM REC_SWT_BASE2ONUS_IBR RSB WHERE RSB.RSB_MAN_REC >= '1';
EXCEPTION
  WHEN OTHERS THEN
    errmsg := 'Main Excp --' || SQLERRM;
END SP_MAN_SWTONUS_IBR;
/


