CREATE OR REPLACE PROCEDURE vmscms.VMS_UPDATE_INV_SEQ  IS

    v_rowcount      number;
    v_max_count     NUMBER;
    v_serl_no       shuffle_array_typ;
    excp_error      EXCEPTION;
    v_errmsg        VARCHAR2(4000);
	main_excep		EXCEPTION;
    l_min_count     NUMBER;
	
    type APPL_ARRAY is table of varchar2(4000);
    v_array APPL_ARRAY;
    
BEGIN


FOR j IN (
    SELECT
        COUNT(1) cap_count,
        cap_prod_code,
        cap_card_type
    FROM
        cms_appl_pan_inv a
    WHERE
        a.cap_issue_stat = 'N'
        AND cap_card_seq > (
            SELECT
                nvl(vic_max_seqno, 0)
            FROM
                vms_inventory_control
            WHERE
                vic_prod_code = a.cap_prod_code
                AND vic_card_type = a.cap_card_type
    )
    GROUP BY
        cap_prod_code,
        cap_card_type
)
LOOP

BEGIN
	v_max_count := '';
	v_errmsg 	:= '';
	
    BEGIN
		v_max_count := J.CAP_COUNT;
		
        IF
            v_max_count > 999999
        THEN
            v_max_count := 999999;
        END IF;
		
		SELECT
            vic_max_seqno + 1 
            into l_min_count
        FROM
            VMS_INVENTORY_CONTROL
        WHERE
				  VIC_PROD_CODE = J.cap_prod_code
            AND   VIC_CARD_TYPE = J.cap_card_type;
        

		select rowid bulk collect into v_array from cms_appl_pan_inv
            WHERE
            cap_issue_stat = 'N'
            AND   cap_prod_code = J.cap_prod_code
            AND   cap_card_type = J.cap_card_type
            and   cap_card_seq > (
            SELECT
                nvl(vic_max_seqno, 0)
            FROM
                vms_inventory_control
            WHERE
                vic_prod_code = J.cap_prod_code
                AND vic_card_type = J.cap_card_type
                    )
			and rownum <= v_max_count;
            
            v_max_count := l_min_count + v_max_count -1;

    
        BEGIN
            get_shuffle_serials(l_min_count,v_max_count,v_serl_no);
                        
            FORALL i IN 1..v_serl_no.count
                UPDATE cms_appl_pan_inv
                    SET
                        cap_card_seq = v_serl_no(i)
                WHERE  rowid = v_array(i);
			
			v_errmsg := 'OK';
					
        EXCEPTION
            WHEN OTHERS THEN
                v_errmsg := 'Error while Updating shuffle serials:'
                || substr(sqlerrm,1,200);
                RAISE excp_error;
        END;
		
		IF v_errmsg = 'OK' THEN
			BEGIN
				UPDATE VMS_INVENTORY_CONTROL
					SET vic_max_seqno = v_max_count
						WHERE VIC_PROD_CODE = J.cap_prod_code
						AND VIC_CARD_TYPE = J.cap_card_type;
			EXCEPTION
				WHEN OTHERS THEN
					v_errmsg := 'Error while updating VMS_INVENTORY_CONTROL '||substr(sqlerrm,1,200);  
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



