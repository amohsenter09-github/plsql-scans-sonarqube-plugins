CREATE INDEX vmscms.indx_cid_acct_no ON vmscms.cms_interest_detl(cid_inst_code,cid_acct_no) TABLESPACE cms_big_idx ONLINE;