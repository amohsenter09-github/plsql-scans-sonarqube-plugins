INSERT INTO VMSCMS.cms_owner_mast
            (com_inst_code, com_owner_id, com_owner_desc, com_ins_user,
             com_ins_date, com_lupd_user, com_lupd_date
            )
     VALUES (1, (SELECT MAX (com_owner_id) + 1
                   FROM VMSCMS.cms_owner_mast), '&ENTER_OWNER_NAME', 1,
             SYSDATE, 1, SYSDATE
            );

COMMIT;
