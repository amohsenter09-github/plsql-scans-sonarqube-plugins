CREATE OR REPLACE PROCEDURE prc_update_inv_batch(p_batch_count IN NUMBER) IS
  v_errmsg VARCHAR2(4000);
  main_excep EXCEPTION;
  v_upd_count NUMBER;
  l_cnt       PLS_INTEGER := 0;
  l_inner_cnt PLS_INTEGER := 0;
  l_cap_count NUMBER;
BEGIN
  FOR j IN (SELECT COUNT(1) cap_count, cap_prod_code, cap_card_type
              FROM cms_appl_pan_inv a
             WHERE a.cap_issue_stat = 'N'
             GROUP BY cap_prod_code, cap_card_type) LOOP
  
    l_cnt := l_cnt + 1;
    /*dbms_output.put_line('prod code ' || j.cap_prod_code);
    dbms_output.put_line('card_type ' || j.cap_card_type);
    dbms_output.put_line('initial cap_count ' || j.cap_count);
    dbms_output.put_line('p_batch_count ' || p_batch_count);
    dbms_output.put_line('l_cnt ' || l_cnt);*/
    /* 
    inner loop to update all the inventory for a product-category combination 
    */
    LOOP
      SELECT COUNT(1) cap_count
        INTO l_cap_count
        FROM cms_appl_pan_inv a
       WHERE a.cap_issue_stat = 'N'
         AND a.cap_prod_code = j.cap_prod_code
         AND a.cap_card_type = j.cap_card_type;
    
      l_inner_cnt := l_inner_cnt + 1;
    
      /* dbms_output.put_line('current cap_count ' || l_cap_count);
      dbms_output.put_line('l_inner_cnt ' || l_inner_cnt);*/
    
      IF l_cap_count >= p_batch_count THEN
        v_upd_count := p_batch_count;
      ELSE
        v_upd_count := l_cap_count;
      END IF;
      /*dbms_output.put_line('v_upd_count ' || v_upd_count);*/
      BEGIN
        UPDATE cms_appl_pan_inv
           SET cap_issue_stat = 'T'
         WHERE cap_issue_stat = 'N'
           AND cap_prod_code = j.cap_prod_code
           AND cap_card_type = j.cap_card_type
           AND rownum <= v_upd_count;
      
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          v_errmsg := 'Error while Updating serials:' ||
                      substr(SQLERRM, 1, 200);
          RAISE main_excep;
      END;
      /*  
      exit the loop if the v_upd_cnt falls below the p_batch_count
      as this means all the required data is updated.
      */
      IF v_upd_count < p_batch_count THEN
        EXIT;
      END IF;
    END LOOP;
  END LOOP;
EXCEPTION
  WHEN main_excep THEN
    ROLLBACK;
    dbms_output.put_line(v_errmsg);
  WHEN OTHERS THEN
    ROLLBACK;
    dbms_output.put_line('main Excp:' || substr(SQLERRM, 1, 200));
END;
/