CREATE OR REPLACE FUNCTION VMSCMS.FN_CNTRY_FLG (SETL_CRNCY_CDE   IN VARCHAR2,
                                                TERM_CNTRY_CDE   IN VARCHAR2)
   RETURN VARCHAR2
AS
   FLG   VARCHAR2 (5);
BEGIN
   FLG := 'DOM';

   IF (NOT (SETL_CRNCY_CDE = '356' OR SETL_CRNCY_CDE = '524')
       AND TERM_CNTRY_CDE != 'IN')
   THEN
      FLG := 'INT';
   END IF;

   RETURN FLG;
END;
/

SHOW ERROR