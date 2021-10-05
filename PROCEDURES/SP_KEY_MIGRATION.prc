CREATE OR REPLACE PROCEDURE VMSCMS.SP_KEY_MIGRATION(PRM_RESULT OUT VARCHAR2) IS

  /*************************************************
      * Created Date     :  20/03/2012
      * Created By       :  T.Narayanaswamy
      * Modified Date     :  18/05/2012
      * Modified By       :  T.Narayanaswamy
      * Modified Reason  :  Condition added for Validating the encrypted data
      * PURPOSE          :  For Key Migration
      * Reviewer         :  NandaKumar R.
      * Reviewed Date    :  28-May-2012
      * Build Number     :  CMS3.5.1_RI0008_B00022
  *************************************************/

  V_TABLE_NAME   VARCHAR2(100);
  V_ENCR_COLUMN  VARCHAR2(100);
  V_HASH_COLUMN  VARCHAR2(100);
  V_CURSOR_QUERY VARCHAR2(400);
  V_QUERY        VARCHAR2(400);
  TYPE RC_TAB_1_BY_1_QRY IS REF CURSOR;
  C_TAB_1_BY_1_QRY RC_TAB_1_BY_1_QRY;
  V_DECR_VALUE     VARCHAR2(100);
  V_ENCR_NEW_VALUE RAW(2000);
  V_COUNT          NUMBER;
  V_ERR_MSG        VARCHAR2(400);
  V_ENCR_DATA      VARCHAR2(100);
  V_HASH_DATA      VARCHAR2(90);
  V_RAISE_EXP EXCEPTION;

  CURSOR C_SELECT_TABLE IS
    SELECT CKR_TABLE_NAME, CKR_HASH_COLUMN, CKR_ENCR_COLUMN
	 FROM CMS_KEY_ROTATE_TABLE
	WHERE CKR_ROTATE_FLAG = 'N'
	ORDER BY CKR_SNO;

BEGIN
  PRM_RESULT := 'OK';
  V_ERR_MSG  := 'OK';

  BEGIN
    OPEN C_SELECT_TABLE;
    LOOP
	 FETCH C_SELECT_TABLE
	   INTO V_TABLE_NAME, V_HASH_COLUMN, V_ENCR_COLUMN;
	 EXIT WHEN C_SELECT_TABLE%NOTFOUND;

	 --   V_CURSOR_QUERY := 'SELECT /*+RULE*/ DISTINCT ' || V_ENCR_COLUMN ||
	 /*          ' , ' || V_HASH_COLUMN || ' FROM ' || V_TABLE_NAME ||
      ' WHERE ' || V_ENCR_COLUMN || ' IS NOT NULL' ||
      ' AND  ' || V_HASH_COLUMN || ' IS NOT NULL';*/

	 V_CURSOR_QUERY := 'SELECT DISTINCT ' || V_ENCR_COLUMN || ' , ' ||
				    V_HASH_COLUMN || ' FROM ' || V_TABLE_NAME ||
				    ' WHERE ' || V_ENCR_COLUMN || ' IS NOT NULL' ||
				    ' AND  ' || V_HASH_COLUMN || ' IS NOT NULL';
	 OPEN C_TAB_1_BY_1_QRY FOR V_CURSOR_QUERY;
	 BEGIN
	   LOOP
		FETCH C_TAB_1_BY_1_QRY
		  INTO V_ENCR_DATA, V_HASH_DATA;
		EXIT WHEN C_TAB_1_BY_1_QRY%NOTFOUND;
		SELECT COUNT(*)
		  INTO V_COUNT
		  FROM CMS_KEY_ROTATE_LOG
		 WHERE CKR_HASH_DATA = V_HASH_DATA;
		IF V_COUNT = 0 THEN
		  V_DECR_VALUE     := FN_DMAPS_MAIN(V_ENCR_DATA);
		  V_ENCR_NEW_VALUE := FN_EMAPS_MAIN_PAN(V_DECR_VALUE);

		  /*
            * Validating the data has been done after decrypting using the constant value
            * INCOMM in the clear data. So removed the verification of data encrypted using the new key
            */
		  --T.Narayanan changed -  Condition added for Validating the encrypted data - beg
		  IF FN_DMAPS_MAIN_PAN(V_ENCR_NEW_VALUE) = V_DECR_VALUE THEN

		    V_QUERY := 'UPDATE ' || V_TABLE_NAME || ' SET ' ||
					V_ENCR_COLUMN || '=''' || V_ENCR_NEW_VALUE ||
					''' WHERE ' || V_HASH_COLUMN || ' IN (''' ||
					V_HASH_DATA || ''')';
		    EXECUTE IMMEDIATE V_QUERY;
		    IF (SQL%ROWCOUNT > 0) THEN
			 INSERT INTO CMS_KEY_ROTATE_LOG
			   (CKR_INST_CODE,
			    CKR_OLD_DATA,
			    CKR_NEW_DATA,
			    CKR_HASH_DATA,
			    CKR_DATA_OF,
			    CKR_REMARKS,
			    CKR_INS_USER,
			    CKR_INS_DATE)
			 VALUES
			   (1,
			    V_ENCR_DATA,
			    V_ENCR_NEW_VALUE,
			    V_HASH_DATA,
			    'PAN',
			    'SUCCESS',
			    1,
			    SYSDATE);
		    ELSE
			 V_ERR_MSG := 'Values not Updated';
			 RAISE V_RAISE_EXP;
		    END IF;

		  ELSE
		    V_ERR_MSG  := 'BOTH THE DATA ARE NOT MATCHING,PLEASE CHECK THE VALUE';
		    PRM_RESULT := V_ERR_MSG;
		    RAISE V_RAISE_EXP;
		  END IF;
		  --T.Narayanan changed -  Condition added for Validating the encrypted data - end

		ELSE

		  --     SELECT /*+RULE*/
		  /*      CKR_NEW_DATA
             INTO V_ENCR_VALUE
             FROM CMS_KEY_ROTATE_LOG
            WHERE CKR_HASH_DATA = V_HASH_DATA;*/

		  SELECT CKR_NEW_DATA
		    INTO V_ENCR_NEW_VALUE
		    FROM CMS_KEY_ROTATE_LOG
		   WHERE CKR_HASH_DATA = V_HASH_DATA;
		  IF (V_ENCR_NEW_VALUE IS NOT NULL) THEN
		    V_QUERY := 'UPDATE ' || V_TABLE_NAME || ' SET ' ||
					V_ENCR_COLUMN || '=''' || V_ENCR_NEW_VALUE ||
					''' WHERE ' || V_HASH_COLUMN || ' IN (''' ||
					V_HASH_DATA || ''')';
		    EXECUTE IMMEDIATE V_QUERY;
		    IF (SQL%ROWCOUNT < 1) THEN
			 V_ERR_MSG := 'Values not Updated';
			 RAISE V_RAISE_EXP;
		    END IF;
		  ELSE
		    V_DECR_VALUE     := FN_DMAPS_MAIN(V_ENCR_DATA);
		    V_ENCR_NEW_VALUE := FN_EMAPS_MAIN_PAN(V_DECR_VALUE);

		    /*
              * Validating the data has been done after decrypting using the constant value
              * INCOMM in the clear data. So removed the verification of data encrypted using the new key
              */
		    --T.Narayanan changed -  Condition added for Validating the encrypted data - beg
		    IF FN_DMAPS_MAIN_PAN(V_ENCR_NEW_VALUE) = V_DECR_VALUE THEN

			 V_QUERY := 'UPDATE ' || V_TABLE_NAME || ' SET ' ||
					  V_ENCR_COLUMN || '=''' || V_ENCR_NEW_VALUE ||
					  ''' WHERE ' || V_HASH_COLUMN || ' IN (''' ||
					  V_HASH_DATA || ''')';
			 EXECUTE IMMEDIATE V_QUERY;
			 IF (SQL%ROWCOUNT > 0) THEN
			   INSERT INTO CMS_KEY_ROTATE_LOG
				(CKR_INST_CODE,
				 CKR_OLD_DATA,
				 CKR_NEW_DATA,
				 CKR_HASH_DATA,
				 CKR_DATA_OF,
				 CKR_REMARKS,
				 CKR_INS_USER,
				 CKR_INS_DATE)
			   VALUES
				(1,
				 V_ENCR_DATA,
				 V_ENCR_NEW_VALUE,
				 V_HASH_DATA,
				 'PAN',
				 'SUCCESS',
				 1,
				 SYSDATE);
			 ELSE
			   V_ERR_MSG := 'Values not Updated';
			   RAISE V_RAISE_EXP;
			 END IF;
		    ELSE
			 V_ERR_MSG  := 'BOTH THE DATA ARE NOT MATCHING,PLEASE CHECK THE VALUE';
			 PRM_RESULT := V_ERR_MSG;
			 RAISE V_RAISE_EXP;
		    END IF;
		    --T.Narayanan changed -  Condition added for Validating the encrypted data - end

		  END IF;
		END IF;
	   END LOOP;
	   V_QUERY := 'UPDATE  CMS_KEY_ROTATE_TABLE SET CKR_ROTATE_FLAG=''Y'',CKR_REMARKS=''KEY MIGRATION SUCCESS'',CKR_LUPD_USER=1,CKR_LUPD_DATE=:1' ||
			    '  WHERE CKR_TABLE_NAME = ''' || V_TABLE_NAME ||
			    ''' AND CKR_ENCR_COLUMN=''' || V_ENCR_COLUMN || '''';
	   EXECUTE IMMEDIATE V_QUERY
		USING SYSDATE;
	   COMMIT;

	 EXCEPTION
	   WHEN OTHERS THEN
		V_ERR_MSG  := 'EXCEPTION WHEN KEY MIGRATION PROCESS : ' ||
				    SQLERRM;
		PRM_RESULT := V_ERR_MSG;
		ROLLBACK;
		V_QUERY := 'UPDATE  CMS_KEY_ROTATE_TABLE SET CKR_ROTATE_FLAG=''N'',CKR_REMARKS=''' ||
				 SUBSTR(SQLERRM, 0, 400) || ' : ' || 'TABLE NAME : ' ||
				 V_TABLE_NAME || 'VALUE : ' || V_HASH_DATA ||
				 ''' ,CKR_LUPD_USER=1,CKR_LUPD_DATE=:1' ||
				 '  WHERE CKR_TABLE_NAME = ''' || V_TABLE_NAME ||
				 ''' AND CKR_ENCR_COLUMN=''' || V_ENCR_COLUMN || '''';
		EXECUTE IMMEDIATE V_QUERY
		  USING SYSDATE;
		COMMIT;
		RAISE;
	 END;
	 CLOSE C_TAB_1_BY_1_QRY;
    END LOOP;
    CLOSE C_SELECT_TABLE;

  EXCEPTION
    WHEN V_RAISE_EXP THEN
	 V_ERR_MSG  := 'EXCEPTION WHEN KEY ROTATION PROCESS :' || SQLERRM;
	 PRM_RESULT := V_ERR_MSG;
	 ROLLBACK;
    WHEN OTHERS THEN
	 V_ERR_MSG  := 'EXCEPTION WHEN KEY MIGRATION PROCESS :' || SQLERRM;
	 PRM_RESULT := V_ERR_MSG;
	 ROLLBACK;
  END;
  PRM_RESULT := V_ERR_MSG;
END;
/


