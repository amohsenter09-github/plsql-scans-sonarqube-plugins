CREATE TABLE VMSCMS.CMS_DEFAULT_GLACCT_MAST
(
  CDM_INST_CODE          NUMBER(3)              NOT NULL,
  CDM_INS_USER           NUMBER(5)              NOT NULL,
  CDM_INS_DATE           DATE                   NOT NULL,
  CDM_LUPD_USER          NUMBER(5)              NOT NULL,
  CDM_LUPD_DATE          DATE                   NOT NULL,
  CDM_VALID_FROM         DATE                   NOT NULL,
  CDM_VALID_TO           DATE,
  CDM_FLOW_SOURCE        VARCHAR2(3 BYTE)       NOT NULL,
  CDM_CRGL_CODE          VARCHAR2(20 BYTE),
  CDM_CRSUBGL_CODE       VARCHAR2(20 BYTE),
  CDM_CRACCT_NO          VARCHAR2(20 BYTE),
  CDM_DRGL_CATG          VARCHAR2(20 BYTE),
  CDM_DRGL_CODE          VARCHAR2(20 BYTE),
  CDM_DRSUBGL_CODE       VARCHAR2(20 BYTE),
  CDM_DRACCT_NO          VARCHAR2(20 BYTE),
  CDM_CRGL_CATG          VARCHAR2(20 BYTE),
  CDM_ST_CRGL_CATG       VARCHAR2(20 BYTE),
  CDM_ST_CRGL_CODE       VARCHAR2(20 BYTE),
  CDM_ST_CRSUBGL_CODE    VARCHAR2(20 BYTE),
  CDM_ST_CRACCT_NO       VARCHAR2(20 BYTE),
  CDM_ST_DRGL_CATG       VARCHAR2(20 BYTE),
  CDM_ST_DRGL_CODE       VARCHAR2(20 BYTE),
  CDM_ST_DRSUBGL_CODE    VARCHAR2(20 BYTE),
  CDM_ST_DRACCT_NO       VARCHAR2(20 BYTE),
  CDM_CESS_CRGL_CATG     VARCHAR2(20 BYTE),
  CDM_CESS_CRGL_CODE     VARCHAR2(20 BYTE),
  CDM_CESS_CRSUBGL_CODE  VARCHAR2(20 BYTE),
  CDM_CESS_CRACCT_NO     VARCHAR2(20 BYTE),
  CDM_CESS_DRGL_CATG     VARCHAR2(20 BYTE),
  CDM_CESS_DRGL_CODE     VARCHAR2(20 BYTE),
  CDM_CESS_DRSUBGL_CODE  VARCHAR2(20 BYTE),
  CDM_CESS_DRACCT_NO     VARCHAR2(20 BYTE),
  CDM_ST_CALC_FLAG       NUMBER(1),
  CDM_CESS_CALC_FLAG     NUMBER(1)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


