CREATE OR REPLACE PROCEDURE VMSCMS.SP_CARDRENEWAL_ERRLOG (
   INSTCODE        IN NUMBER,
   PANCODE         IN NUMBER,
   ACTIVITY_TYPE   IN VARCHAR2,
   REMARKS         IN VARCHAR2,
   DISPNAME        IN VARCHAR2,
   ACCTNO          IN VARCHAR2,
   CARDSTAT        IN VARCHAR2,
   EXPRYDATE       IN DATE,
   APPLBRAN        IN VARCHAR2,
   PROCESS_MODE    IN CHAR,
   FLAG            IN CHAR,
   TXN_CODE        IN VARCHAR2,
   DEL_CHANNEL     IN VARCHAR2,
   ERRMSG          IN VARCHAR2,
   LUPDUSER        IN NUMBER)
IS
   PRAGMA AUTONOMOUS_TRANSACTION;

   V_ENCR_PAN   CMS_APPL_PAN.CAP_PAN_CODE_ENCR%TYPE;
BEGIN
   V_ENCR_PAN := FN_EMAPS_MAIN (PANCODE);
END;
/

SHOW ERROR