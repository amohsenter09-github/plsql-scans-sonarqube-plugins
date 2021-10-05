CREATE OR REPLACE TRIGGER VMSCMS.TRG_ADDRUPDATE_STD
	BEFORE INSERT OR UPDATE ON VMSCMS.CMS_ADDR_UPDATE 		FOR EACH ROW
BEGIN	--Trigger body begins
	IF INSERTING THEN
		:new.cau_process_date  := sysdate;
	END IF;
END;	--Trigger body ends
/


