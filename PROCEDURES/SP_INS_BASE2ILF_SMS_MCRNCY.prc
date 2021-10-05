CREATE OR REPLACE PROCEDURE VMSCMS.sp_ins_base2ilf_sms_mcrncy(errmsg	OUT		VARCHAR2)
AS
C_RBR_RECON NUMBER(1):= 5;
BEGIN
	ERRMSG:= 'OK';
    UPDATE REC_BASE2_ILF_SMSTEMP_MCRNCY SET rbi_crd_iss_cntry = fn_get_CrdIssuing_Id(SUBSTR(Rbi_PAN,1,6));
--Imran 22 Aug 2003
	UPDATE REC_BASE2_ILF_SMSTEMP_MCRNCY SET rbi_pan=trim(rbi_pan),rbi_resp_cde=trim(rbi_resp_cde);
--imran 28 May 03
--	INSERT INTO REC_BASE2_ILF (SELECT * FROM REC_BASE2_ILF_SMSTEMP where rbi_resp in('000','001') AND RBI_TRAN_DAT<>'000000');
DELETE FROM REC_BASE2_ILF_SMSTEMP_MCRNCY WHERE RBI_TRAN_DAT='000000';
UPDATE REC_BASE2_ILF_SMSTEMP_MCRNCY SET rbi_dup_flag='Y' WHERE rbi_tran_typ NOT IN ('0220','0422') AND RBI_PAN||RBI_RESP_CDE||RBI_SEQ_NUM||RBI_TRAN_DAT||RBI_REC_TYP||RBI_RVSL_CDE    IN (SELECT RBI_PAN||RBI_RESP_CDE||RBI_SEQ_NUM||RBI_TRAN_DAT||RBI_REC_TYP||RBI_RVSL_CDE FROM REC_BASE2_ILF_MCRNCY);
	INSERT INTO REC_BASE2_ILF_MCRNCY (SELECT * FROM REC_BASE2_ILF_SMSTEMP_MCRNCY WHERE rbi_dup_flag='N' AND rbi_resp IN ('000','001') AND rbi_tran_typ NOT IN ('0220','0422'));
--Imran 23 Jun 2003
	DELETE FROM REC_BASE2_RECON_TEMP_MCRNCY;
	INSERT INTO REC_BASE2_RECON_TEMP_MCRNCY	(
		RBR_RECON,		RBR_PROCESS_DATE,	RBR_FILE_TYPE,		RBR_FILE_NAME,		RBR_REC_TYP,
		RBR_TRAN_TYP,		RBR_RESP_CDE,		RBR_RVSL_CDE,		RBR_POST_DAT,		RBR_ACQ_INST_ID_NUM,
		RBR_ILF_TERM_ID,	RBR_TERM_NAME_LOC,	RBR_TERM_OWNER_NAME,	RBR_TERM_CITY,		RBR_TERM_ST_X,
		RBR_TERM_CNTRY_X,	RBR_SEQ_NUM,		RBR_INVOICE_NUM,	RBR_RETL_ID,		RBR_TRAN_CDE,
		RBR_RESPONDER,		RBR_PAN,		RBR_MBR_NUM,		RBR_AMT1,		RBR_AMT2,
		RBR_SETL_CRNCY_CDE,	RBR_SETL_CONV_RATE,	RBR_TRAN_DAT,		RBR_TRAN_TIM,		RBR_PT_SRV_COND_CDE,
		RBR_PT_SRV_ENTRY_MDE,	RBR_FROM_ACCT_TYP,	RBR_FROM_ACCT,		RBR_ORIG_CRNCY_CDE,	RBR_RESP,
		RBR_MAT_CAT_CODE)
	SELECT  C_RBR_RECON,		SYSDATE,		A.RBI_FILE_TYPE,	A.RBI_FILE_NAME,	A.RBI_REC_TYP,
		A.RBI_TRAN_TYP,		A.RBI_RESP_CDE,		A.RBI_RVSL_CDE,		A.RBI_POST_DAT,		A.RBI_ACQ_INST_ID_NUM,
		A.RBI_TERM_ID,		A.RBI_TERM_NAME_LOC,	A.RBI_TERM_OWNER_NAME,	A.RBI_TERM_CITY,	A.RBI_TERM_ST_X,
		A.RBI_TERM_CNTRY_X,	A.RBI_SEQ_NUM,		A.RBI_INVOICE_NUM,	A.RBI_RETL_ID,		A.RBI_TRAN_CDE,
		A.RBI_RESPONDER,	A.RBI_PAN,		A.RBI_MBR_NUM,		A.RBI_AMT1,		A.RBI_AMT2,
		A.RBI_SETL_CRNCY_CDE,	A.RBI_SETL_CONV_RATE,	A.RBI_TRAN_DAT,		A.RBI_TRAN_TIM,		A.RBI_PT_SRV_COND_CDE,
		A.RBI_PT_SRV_ENTRY_MDE,	A.RBI_FROM_ACCT_TYP,	A.RBI_FROM_ACCT,	A.RBI_ORIG_CRNCY_CDE,	A.RBI_RESP,
		A.RBI_MAT_CAT_CODE
		FROM	REC_BASE2_ILF_SMSTEMP_MCRNCY A
		WHERE rbi_dup_flag='Y' AND rbi_resp IN ('000','001');
--Imran 4th Jun 2003, insert in test table, uncomment this and move in main table only when the user confirms the output
	INSERT INTO REC_BASE2_RECON_MCRNCY (SELECT * FROM REC_BASE2_RECON_TEMP_MCRNCY);
--	INSERT INTO REC_BASE2_RECON_test1 (SELECT * FROM REC_BASE2_RECON_TEMP);
	DELETE FROM REC_BASE2_RECON_TEMP_MCRNCY;
EXCEPTION
	WHEN OTHERS THEN
		ERRMSG:= 'Exep Main ......'||SQLERRM;
END;
/


