set serveroutput on;
DECLARE
   v_chk_tab   VARCHAR2 (10);
   v_err       VARCHAR2 (1000);
   v_cnt       NUMBER (2);
BEGIN
   SELECT COUNT (1)
     INTO v_chk_tab
     FROM all_objects
    WHERE object_type = 'TABLE'
      AND owner = 'VMSCMS'
      AND object_name = 'CMS_INST_PARAM_R16B3';

   IF v_chk_tab = 1
   THEN      	  
   
		SELECT COUNT(1) 
		INTO v_cnt 
		FROM vmscms.CMS_INST_PARAM
		WHERE CIP_INST_CODE = 1
		AND CIP_PARAM_KEY = 'CHARGEBACK_TIMEFRAME'
		AND CIP_PARAM_VALUE = 0;

		IF v_cnt = 0
		THEN 

			INSERT
			INTO vmscms.CMS_INST_PARAM_R16B3
			(
				CIP_INST_CODE,
				CIP_PARAM_KEY,
				CIP_PARAM_DESC,
				CIP_PARAM_VALUE,
				CIP_INS_USER,
				CIP_INS_DATE,
				CIP_LUPD_USER,
				CIP_LUPD_DATE,
				CIP_ALLOWED_VALUES,
				CIP_MANDATORY_FLAG,
				CIP_DISPLAY_FLAG,
				CIP_PARAM_UNIT,
				CIP_PARAM_DISP_TYPE,
				CIP_MULTILING_DESC,
				CIP_VALIDATION_TYPE
			) VALUES (
				1,
				'CHARGEBACK_TIMEFRAME',
				'Chargeback Timeframe',
				0,
				1,
				SYSDATE,
				1,
				SYSDATE,
				NULL,
				'N',
				'N',
				'Nos.',
				NULL,
				NULL,
				NULL
			);

		END IF;	
		
	
		   INSERT INTO VMSCMS.CMS_INST_PARAM
            SELECT *
              FROM VMSCMS.CMS_INST_PARAM_R16B3
             WHERE (CIP_INST_CODE,
					CIP_PARAM_KEY,
					CIP_PARAM_VALUE) NOT IN (
                       SELECT CIP_INST_CODE,
					          CIP_PARAM_KEY,
					          CIP_PARAM_VALUE
                         FROM VMSCMS.CMS_INST_PARAM);
						 

      DBMS_OUTPUT.put_line (SQL%ROWCOUNT || ' rows Inserted ');
	  
	    ELSE
      DBMS_OUTPUT.put_line ('Backup Object Not Found');
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      v_err := SUBSTR (SQLERRM, 1, 100);
      DBMS_OUTPUT.put_line ('Main Excp ' || v_err);
END;
/			  