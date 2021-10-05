CREATE OR REPLACE PROCEDURE VMSCMS.sp_pancount(cnt IN NUMBER)
AS
PRAGMA autonomous_transaction;
BEGIN
UPDATE CMS_PANGEN_COUNT
SET cpc_pan_count = cnt;
COMMIT;
END;
/


SHOW ERRORS