CREATE OR REPLACE TRIGGER VMSCMS.trg_corpmast_std
	BEFORE INSERT OR UPDATE ON cms_corp_mast
		FOR EACH ROW
BEGIN	--Trigger body begins
	IF INSERTING THEN
		:new.ccm_ins_date := sysdate;
		:new.ccm_lupd_date := sysdate;
	ELSIF UPDATING THEN
		:new.ccm_lupd_date := sysdate;
	END IF;
END;	--Trigger body ends
/


