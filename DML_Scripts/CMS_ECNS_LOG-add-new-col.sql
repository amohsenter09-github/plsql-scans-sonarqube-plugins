-- Script to add new column CEL_ECNS_RETRY_COUNT to CMS_ECNS_LOG table 
ALTER TABLE CMS_ECNS_LOG
ADD CEL_ECNS_RETRY_COUNT NUMBER(5,0) DEFAULT 0;

commit;

-- select cel_ecns_retry_count from CMS_ECNS_LOG;

-- Revert Script
-- ALTER TABLE CMS_ECNS_LOG DROP COLUMN CEL_ECNS_RETRY_COUNT;

acxewceqceqc 