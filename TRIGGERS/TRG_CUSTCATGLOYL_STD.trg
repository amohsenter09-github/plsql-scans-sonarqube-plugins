CREATE OR REPLACE TRIGGER VMSCMS.trg_custcatgloyl_std
	BEFORE INSERT OR UPDATE ON cms_custcatg_loyl
		FOR EACH ROW
BEGIN	--Trigger body begins
	IF INSERTING THEN
		:new.ccl_ins_date := sysdate	;
		:new.ccl_lupd_date := sysdate	;
	ELSIF UPDATING THEN
		:new.ccl_lupd_date := sysdate	;
	END IF;
END;	--Trigger body ends
/


