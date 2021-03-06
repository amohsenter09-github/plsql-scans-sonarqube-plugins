CREATE OR REPLACE FUNCTION VMSCMS.FN_GET_DEPLOYMENT_FLAG (
   PRM_INST_CODE     IN NUMBER,
   PRM_TXN_CODE      IN VARCHAR2,
   PRM_DEL_CHANNEL   IN VARCHAR2)
   RETURN NUMBER
IS
   DEPLOYMENT_FLAG   NUMBER := 0;
BEGIN
   SELECT CTM_DEPLOYMENT_FLAG
     INTO DEPLOYMENT_FLAG
     FROM CMS_TRANSACTION_MAST
    WHERE     CTM_DELIVERY_CHANNEL = PRM_DEL_CHANNEL
          AND CTM_TRAN_CODE = PRM_TXN_CODE
          AND CTM_INST_CODE = PRM_INST_CODE;

   RETURN DEPLOYMENT_FLAG;
EXCEPTION
   WHEN OTHERS
   THEN
      DEPLOYMENT_FLAG := 0;
      RETURN DEPLOYMENT_FLAG;
END;
/

SHOW ERROR