CREATE TABLE VMSCMS.VMS_CARD_STATUS_TOKEN_MAPPING
  (
    VCS_CARD_OLD_STAT VARCHAR2(2),
    VCS_CARD_NEW_STAT VARCHAR2(2),
    VCS_TOKEN_STAT   VARCHAR2(2),
    VCS_INS_DATE TIMESTAMP,
    VCS_LUPD_DATE TIMESTAMP
  )TABLESPACE CMS_MAST;
  
ALTER TABLE VMSCMS.VMS_CARD_STATUS_TOKEN_MAPPING ADD
(
  CONSTRAINT PK_CARD_STAT_TOKEN_MAP PRIMARY KEY (VCS_CARD_OLD_STAT, VCS_CARD_NEW_STAT)
)
/
