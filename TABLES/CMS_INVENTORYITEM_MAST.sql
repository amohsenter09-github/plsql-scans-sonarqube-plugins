CREATE TABLE VMSCMS.CMS_INVENTORYITEM_MAST
(
  CIM_INVENTORYITEM_CODE  VARCHAR2(10 BYTE),
  CIM_INTERCHANGE_CODE    VARCHAR2(2 BYTE),
  CIM_INVENTORYCATG_CODE  VARCHAR2(10 BYTE),
  CIM_CARDTYPE_CODE       VARCHAR2(10 BYTE),
  CIM_INVENTORYITEM_DESC  VARCHAR2(30 BYTE),
  CIM_MAXSTOCK_LIMIT      NUMBER(10),
  CIM_REORDER_LEVEL       NUMBER(10),
  CIM_INS_USER            NUMBER(5),
  CIM_INS_DATE            DATE,
  CIM_LUPD_USER           NUMBER(5),
  CIM_LUPD_DATE           DATE,
  CIM_CURRENT_STOCK       NUMBER(10),
  CIM_INST_CODE           NUMBER(10)
)
TABLESPACE CMS_MAST
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING
/


ALTER TABLE VMSCMS.CMS_INVENTORYITEM_MAST ADD (
  CONSTRAINT PK_INVENTORYITEM_MAST
 PRIMARY KEY
 (CIM_INVENTORYITEM_CODE),
  CONSTRAINT UK_INVENTORYITEM_DESC
 UNIQUE (CIM_INVENTORYITEM_DESC))
/

ALTER TABLE VMSCMS.CMS_INVENTORYITEM_MAST ADD (
  CONSTRAINT FK_INTERCHANGE_CODE 
 FOREIGN KEY (CIM_INST_CODE, CIM_INTERCHANGE_CODE) 
 REFERENCES VMSCMS.CMS_INTERCHANGE_MAST (CIM_INST_CODE,CIM_INTERCHANGE_CODE),
  CONSTRAINT FK_INVENTORYCATG_CODE 
 FOREIGN KEY (CIM_INVENTORYCATG_CODE) 
 REFERENCES VMSCMS.CMS_INVENTORYCATG_MAST (CIM_INVENTORYCATG_CODE),
  CONSTRAINT FK_CARDTYPE_CODE 
 FOREIGN KEY (CIM_CARDTYPE_CODE) 
 REFERENCES VMSCMS.CMS_CARDTYPE_MAST (CCM_CARDTYPE_CODE))
/

