DECLARE
   v_chk_tab   VARCHAR2 (10);
   v_err       VARCHAR2 (1000);
   v_cnt       NUMBER (2);
BEGIN
   SELECT COUNT (1)
     INTO v_chk_tab
     FROM all_objects
    WHERE owner = 'VMSCMS'
      AND object_type = 'TABLE'
      AND object_name = 'CMS_PRM_MSGQUEUE_SPEC_R1705B2';

   IF v_chk_tab = 1
   THEN
		    UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='WalletIdentifier' WHERE CPM_DELIVERY_CHANNEL='16'
			AND CPM_PRM_TYPE='MRIF' and CPM_FIELD_NAME='SEC-ST' AND CPM_TRANSACTION_CODE='11';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='CorrelationID' WHERE CPM_DELIVERY_CHANNEL='16'
			AND CPM_PRM_TYPE='MRIF' AND CPM_FIELD_NAME='FILTER-FLD' AND CPM_TRANSACTION_CODE='11';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='FinalTokenizationDecision' WHERE CPM_DELIVERY_CHANNEL='16'
			AND CPM_PRM_TYPE='MRIF' and CPM_FIELD_NAME='STAT' AND CPM_TRANSACTION_CODE='11';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='TCDateandTime' WHERE CPM_DELIVERY_CHANNEL='16'
			AND CPM_PRM_TYPE='MRIF' and CPM_FIELD_NAME='RETL-ADDR2' AND CPM_TRANSACTION_CODE='11';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='NumberofActivationAttempts' WHERE CPM_DELIVERY_CHANNEL='16'
			AND CPM_PRM_TYPE='MRIF' AND CPM_FIELD_NAME='ACTVITY.STAT' AND CPM_TRANSACTION_CODE='11';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='TokenizationReasonCode' WHERE CPM_DELIVERY_CHANNEL='16'
			AND CPM_PRM_TYPE='MRIF' and CPM_FIELD_NAME='RETL-ST' AND CPM_TRANSACTION_CODE='11';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='EventRequestor' WHERE CPM_DELIVERY_CHANNEL='16'
			AND CPM_PRM_TYPE='MRIF' and CPM_FIELD_NAME='FRGN-FLG' AND CPM_TRANSACTION_CODE='11';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='WalletIdentifier' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='ERIF' and CPM_FIELD_NAME='PRI-ACCT.PROD-CDE';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='CorrelationID' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='ERIF' AND CPM_FIELD_NAME='USER.GOVT-ID';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='FinalTokenizationDecision' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='ERIF' and CPM_FIELD_NAME='TLR-APPR-CDE';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='TCDateandTime' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='ERIF' and CPM_FIELD_NAME='BEN-WIR-ACCT-IDENT';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='NumberofActivationAttempts' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='ERIF' AND CPM_FIELD_NAME='CASH-IND';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='WalletIdentifier' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='MRIF' and CPM_FIELD_NAME='SEC-ST';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='CorrelationID' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='MRIF' AND CPM_FIELD_NAME='FILTER-FLD';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='FinalTokenizationDecision' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='MRIF' and CPM_FIELD_NAME='STAT';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='TCDateandTime' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='MRIF' and CPM_FIELD_NAME='RETL-ADDR2';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='NumberofActivationAttempts' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='MRIF' AND CPM_FIELD_NAME='ACTVITY.STAT';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE vmscms.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='TokenizationReasonCode' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='MRIF' and CPM_FIELD_NAME='RETL-ST';
			
			DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');

			UPDATE VMSCMS.CMS_PRM_MSGQUEUE_SPEC SET CPM_TXN_FIELDNAME='EventRequestor' WHERE CPM_DELIVERY_CHANNEL IN ('16','02')
			AND CPM_PRM_TYPE='MRIF' and CPM_FIELD_NAME='FRGN-FLG';

		DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows updated ');
   ELSE
      DBMS_OUTPUT.put_line ('Backup Object Not Found');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;
      v_err := SUBSTR (SQLERRM, 1, 100);
      DBMS_OUTPUT.put_line ('Main Excp ' || v_err);
END;
/