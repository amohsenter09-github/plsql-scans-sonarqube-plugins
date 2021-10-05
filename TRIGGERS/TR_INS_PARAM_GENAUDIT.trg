create or replace
TRIGGER VMSCMS.TR_INS_PARAM_GENAUDIT 
AFTER  INSERT OR UPDATE OR DELETE ON  vmscms.CMS_INST_PARAM
FOR EACH ROW
DECLARE
  ------------------------------------------------------------------------------------------------
  ERRMSG      VARCHAR2(300) := '0K';
  V_SEQ_NO    NUMBER;
  V_TAB_ID    NUMBER(5);
  V_TABLE_NM  VARCHAR2(60);
  V_INST_CODE NUMBER(5);
  ERROR_EXCPTION EXCEPTION;

  ------------------------------------------------------------------------------------------------

  TYPE REC_TR_INFO IS RECORD(
    COL_NAME VARCHAR2(60),
    OLD_VAL  VARCHAR2(200),
    NEW_VAL  VARCHAR2(200));

  TYPE TAB_DTL_INFO IS TABLE OF REC_TR_INFO INDEX BY BINARY_INTEGER;

  P_DTL_INFO TAB_DTL_INFO;

BEGIN

  V_TABLE_NM := 'CMS_INST_PARAM';

  IF INSERTING THEN
    V_INST_CODE := :NEW.CIP_INST_CODE;
  ELSE
    V_INST_CODE := :OLD.CIP_INST_CODE;
  END IF;

  BEGIN
    SELECT CGM_TABLE_ID
     INTO V_TAB_ID
     FROM CMS_GENAUDIT_MAST
    WHERE CGM_TABLE_NAME = V_TABLE_NM AND CGM_INST_CODE = V_INST_CODE;
  EXCEPTION
    WHEN OTHERS THEN
     ERRMSG := 'Table ' || V_TABLE_NM || ' not found in audit master ' ||
             SUBSTR(SQLERRM, 1, 200);
     RAISE ERROR_EXCPTION;
  END;

  P_DTL_INFO(1).COL_NAME := 'CIP_PARAM_KEY';
  P_DTL_INFO(2).COL_NAME := 'CIP_PARAM_DESC';
  P_DTL_INFO(3).COL_NAME := 'CIP_INS_USER';
  P_DTL_INFO(4).COL_NAME := 'CIP_INS_DATE';
  P_DTL_INFO(5).COL_NAME := 'CIP_LUPD_USER';
  P_DTL_INFO(6).COL_NAME := 'CIP_LUPD_DATE';

  P_DTL_INFO(1).OLD_VAL := :OLD.CIP_PARAM_KEY;
  P_DTL_INFO(2).OLD_VAL := :OLD.CIP_PARAM_DESC;
  P_DTL_INFO(3).OLD_VAL := :OLD.CIP_INS_USER;
  P_DTL_INFO(4).OLD_VAL := :OLD.CIP_INS_DATE;
  P_DTL_INFO(5).OLD_VAL := :OLD.CIP_LUPD_USER;
  P_DTL_INFO(6).OLD_VAL := :OLD.CIP_LUPD_DATE;

  P_DTL_INFO(1).NEW_VAL := :NEW.CIP_PARAM_KEY;
  P_DTL_INFO(2).NEW_VAL := :NEW.CIP_PARAM_DESC;
  P_DTL_INFO(3).NEW_VAL := :NEW.CIP_INS_USER;
  P_DTL_INFO(4).NEW_VAL := :NEW.CIP_INS_DATE;
  P_DTL_INFO(5).NEW_VAL := :NEW.CIP_LUPD_USER;
  P_DTL_INFO(6).NEW_VAL := :NEW.CIP_LUPD_DATE;

  IF INSERTING THEN
    SELECT SEQ_AUDIT_NO.NEXTVAL INTO V_SEQ_NO FROM DUAL;
    FOR T IN 1 .. P_DTL_INFO.COUNT LOOP
     SP_POPULATE_AUDIT(V_INST_CODE,
                    V_TAB_ID,
                    P_DTL_INFO(T).COL_NAME,
                    NULL,
                    P_DTL_INFO(T).NEW_VAL,
                    :NEW.CIP_INS_USER,
                    'INSERT',
                    V_SEQ_NO,
                    ERRMSG);

     IF ERRMSG <> 'OK' THEN
       ERRMSG := 'From Insert ' || ERRMSG;
       RAISE ERROR_EXCPTION;
     END IF;
    END LOOP;

  END IF;

  IF UPDATING THEN

    SELECT SEQ_AUDIT_NO.NEXTVAL INTO V_SEQ_NO FROM DUAL;

    FOR T IN 1 .. P_DTL_INFO.COUNT LOOP
     SP_POPULATE_AUDIT(V_INST_CODE,
                    V_TAB_ID,
                    P_DTL_INFO(T).COL_NAME,
                    P_DTL_INFO(T).OLD_VAL,
                    P_DTL_INFO(T).NEW_VAL,
                    :NEW.CIP_LUPD_USER,
                    'UPDATE',
                    V_SEQ_NO,
                    ERRMSG);

     IF ERRMSG <> 'OK' THEN
       ERRMSG := 'From Upadte ' || ERRMSG;
       RAISE ERROR_EXCPTION;
     END IF;
    END LOOP;

  END IF;

  IF DELETING THEN

    SELECT SEQ_AUDIT_NO.NEXTVAL INTO V_SEQ_NO FROM DUAL;

    FOR T IN 1 .. P_DTL_INFO.COUNT LOOP
     SP_POPULATE_AUDIT(V_INST_CODE,
                    V_TAB_ID,
                    P_DTL_INFO(T).COL_NAME,
                    P_DTL_INFO(T).OLD_VAL,
                    NULL,
                    :OLD.CIP_LUPD_USER,
                    'DELETE',
                    V_SEQ_NO,
                    ERRMSG);

     IF ERRMSG <> 'OK' THEN
       ERRMSG := 'From Delete ' || ERRMSG;
       RAISE ERROR_EXCPTION;
     END IF;
    END LOOP;

  END IF;

EXCEPTION
  WHEN ERROR_EXCPTION THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error - ' || ERRMSG);
  WHEN OTHERS THEN
    ERRMSG := 'Main Error  - ' || SUBSTR(SQLERRM, 1, 250);
    RAISE_APPLICATION_ERROR(-20002, ERRMSG);
END; 
/
show error