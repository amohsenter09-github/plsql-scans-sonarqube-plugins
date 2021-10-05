DECLARE
    CURSOR cur_pan_inv IS
    SELECT
        *
    FROM
        cms_appl_pan_inv a
    WHERE
        cap_issue_stat = 'T'
        AND ROWNUM <= 10;

    TYPE type_pan_inv IS
        TABLE OF cur_pan_inv%rowtype;
    t_pan_inv   type_pan_inv;
    v_err_cnt   NUMBER;
    v_errno     NUMBER;
    v_errmsg    VARCHAR2(500);
    v_idx       NUMBER;
BEGIN
    OPEN cur_pan_inv;
    LOOP
        FETCH cur_pan_inv BULK COLLECT INTO t_pan_inv LIMIT 1000;
        EXIT WHEN t_pan_inv.count = 0;
        BEGIN
            FORALL i IN 1..t_pan_inv.count SAVE 
                UPDATE vmscms.CMS_APPL_PAN_INV
                SET
                    cap_issue_stat = 'N'
                WHERE
                    cap_pan_code = t_pan_inv(i).cap_pan_code;

        EXCEPTION
            WHEN OTHERS THEN
                v_err_cnt := sql%bulk_exceptions.count;
                FOR i IN 1..v_err_cnt LOOP
                    v_errno := SQL%bulk_exceptions(i).error_code;
                    v_errmsg := sqlerrm(-v_errno);
                    v_idx := SQL%bulk_exceptions(i).error_index;
                    dbms_output.put_line('Error while updating t_pan_inv (i).CAP_MASK_PAN '
                                         || v_errno
                                         || ': '
                                         || v_errmsg);
                END LOOP;

        END;

        COMMIT;
    END LOOP;

    CLOSE cur_pan_inv;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('main Excp:'
                             || substr(sqlerrm, 1, 200));
END