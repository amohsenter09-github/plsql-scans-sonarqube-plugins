DECLARE
    v_rowcount      number;
    v_max_count     NUMBER;
    v_serl_no       shuffle_array_typ;
    excp_error      EXCEPTION;
    v_errmsg        VARCHAR2(4000);
	main_excep		EXCEPTION;
	
    type APPL_ARRAY is table of varchar2(4000);
    v_array APPL_ARRAY;
    
BEGIN

FOR J IN (SELECT COUNT(1) CAP_COUNT,CAP_PROD_CODE,CAP_CARD_TYPE FROM CMS_APPL_PAN_INV A WHERE A.CAP_ISSUE_STAT = 'N' GROUP BY CAP_PROD_CODE,CAP_CARD_TYPE)

LOOP

BEGIN
	v_errmsg 	:= '';
	v_max_count := '';
	
            
		

    BEGIN
		v_max_count := J.CAP_COUNT;
		
        IF
            v_max_count > 500000
        THEN
            v_max_count := 500000;
        END IF;

      select rowid bulk collect into v_array from cms_appl_pan_inv
            WHERE
            cap_issue_stat = 'N'
            AND   cap_prod_code = J.cap_prod_code
            AND   cap_card_type = J.cap_card_type
			and rownum <= v_max_count;

    
        BEGIN
            get_shuffle_serials(1,v_max_count,v_serl_no);
            
            FORALL i IN 1..v_serl_no.count
                UPDATE cms_appl_pan_inv
                    SET
                        cap_card_seq = v_serl_no(i)
                WHERE rowid = v_array(i);
					
			v_errmsg := 'OK';

        EXCEPTION
            WHEN OTHERS THEN
                v_errmsg := 'Error while Updating shuffle serials:'
                || substr(sqlerrm,1,200);
                RAISE excp_error;
        END;
		
		IF v_errmsg = 'OK' THEN
			BEGIN
				INSERT INTO VMS_INVENTORY_CONTROL
                    (VIC_PROD_CODE,
					 VIC_CARD_TYPE,    
                     VIC_CONTROL_NUMBER,    
                     VIC_INS_DATE,         
                     VIC_INS_USER,
					 vic_max_seqno)
				VALUES
					(J.cap_prod_code,
					 J.cap_card_type,
					 1,
					 sysdate,
					 1,
					 v_max_count);
      EXCEPTION
		WHEN DUP_VAL_ON_INDEX THEN
			UPDATE VMS_INVENTORY_CONTROL SET VIC_CONTROL_NUMBER = 1, vic_max_seqno = v_max_count WHERE VIC_PROD_CODE = J.cap_prod_code AND VIC_CARD_TYPE = J.cap_card_type;
        WHEN OTHERS THEN
            v_errmsg := 'Error while inserting VMS_INVENTORY_CONTROL '||substr(sqlerrm,1,200);  
			RAISE excp_error;
      END;

	END IF;
    END;

	EXCEPTION
			WHEN excp_error THEN
				ROLLBACK;
				dbms_output.put_line(v_errmsg);
			WHEN OTHERS THEN
				ROLLBACK;
				dbms_output.put_line('Loop Exception:'
					|| substr(sqlerrm,1,200) );
	
END;

COMMIT;

END LOOP;

EXCEPTION
WHEN main_excep THEN
		ROLLBACK;
		dbms_output.put_line(v_errmsg);
WHEN OTHERS THEN
		dbms_output.put_line('main Excp:'
					|| substr(sqlerrm,1,200) );
END;



