create or replace
PROCEDURE                  vmscms.SP_GENERATE_UPDATE_PROXY (
   p_inst_code   IN       NUMBER,
   p_user        IN       NUMBER,
   p_errmsg      OUT      VARCHAR2,
   p_starer_gpr_type IN     VARCHAR2 default null,  --Added for MVHOST-389
   p_file_name     IN VARCHAR2 default null  --Added for FSS-1757
)
IS
   v_proxy_number       cms_appl_pan.cap_proxy_number%type;
   v_proxylength        cms_prod_cattype.cpc_proxy_length%TYPE;
   exp_reject_record    EXCEPTION;
   v_seqno              cms_program_id_cnt.cpi_sequence_no%TYPE;
   v_programid          cms_prod_cattype.cpc_program_id%TYPE;
   card_status          VARCHAR2 (2)                              := '2';
   v_cap_card_stat      cms_appl_pan.cap_card_stat%TYPE           := '9';
   rowid_ctrlno         rowid;
   l_serials          shuffle_array_typ;
   v_sourceone_count   NUMBER;
   v_sourceone_id   NUMBER;
   v_cpi_count   NUMBER;
   v_cpi_id   NUMBER;
 --  v_file_name         varchar2(100); --Added for FSS-1757
/*************************************************
* Created By       : Saravanakumar
* Created Date     :  31-Dec-2012
* Purpose          : For generating and updating proxy number while CCF file generation.
* Modified By      : Saravanakumar
* Modified Date    :  10-Jan-2013
* Modified Reason  : defect 9971-Excluding closed card while generating proxy
* Reviewer         : Dhiraj
* Reviewed Date    : 10-Jan-13
* Build Number     : CMS3.5.1_RI0023_B0017
* Modified By       : Pankaj S.
* Modified Date     : 27-Feb-2013
* Modified For      : DFCHOST-249
* Modified Reason   : Modify Cursor query to filter out GPR cards for which proxy number is already available.
* Reviewer          : Dhiraj
* Reviewed Date     :
* Release Number    : RI0023.2_B0011
* Modified By       : Dhiraj Gaikwad
* Modified Date     : 13-Mar-2013
* Modified For      : Defect 10749
* Modified Reason   : Performance Changes
* Reviewer          : Dhiraj Gaikwad
* Reviewed Date     :
* Release Number    : RI0024_B0012

* Modified By       : Ramesh
* Modified Date     : 03-Dec-2013
* Modified For      : DFCHOST-367
* Modified Reason   : Generates proxynumber order by location and order ref number for Inventory cards.
* Reviewer          : Dhiraj
* Reviewed Date     : 03-Dec-2013
* Release Number    : RI0027_B0003

* Modified By       : Ramesh
* Modified Date     : 30-Sep-2014
* Modified For      : MFCHOST-389
* Reviewer          : Spankaj
* Release Number    : RI0027.4_B0002

* Modified By       : Dhina
* Modified Date     : 02-Oct-2014
* Modified For      : MFCHOST-389
*Build No           : RI0027.4_B0003

* Modified By       : Ramesh
* Modified Date     : 30-JAN-2015
* Modified For      : Mantis ID:16017
* Release Number    : RI0027.4.3.1_B0002

* Modified By       : Ramesh
* Modified Date     : 19-FEB-2015
* Modified For      : FSS-2236
* Release Number    :

* Modified By       : T.Narayanaswamy
* Modified Date     : 21-Oct-2016
* Modified For      : FSS-4853 - Duplicate Proxy Number issue
* Release Number    : 4.10

* Modified By       : Sai Prasad
* Modified Date     : 16-Nov-2016
* Modified For      : FSS- Performance changes III
* Release Number    : 4.11

* Modified By       : dhinakaran B
* Modified Date     : 31-Jul-2017
* Modified For      : FSS-B2B
* Release Number    : 17.07

* Modified By       : Saravanakumar
* Modified Date     : 31-AUG-2017
* Modified For      : FSS-B2B
* Release Number    : 17.08
*************************************************/
-- p_starer_gpr_type ( C -> starterCard , I - Inventory Card , G -> GPR Card) --Added for MVHOST-389
   CURSOR cur_sourceone (bin NUMBER,prod_code VARCHAR2,card_type NUMBER)
   IS
      SELECT   a.ROWID row_id, c.cpc_prod_code, c.cpc_card_type, cap_pan_code
          FROM cms_cardissuance_status,
               cms_appl_pan a,
               cms_prod_bin,
               cms_prod_cattype c,
               cms_prod_cardpack cp,
               CMS_APPL_MAST  --Added for FSS-1757
               ,VMS_PACKAGEID_MAST PACKIDMAST
         WHERE ccs_inst_code = cap_inst_code
           AND ccs_pan_code = cap_pan_code
           AND ccs_card_status = card_status
           AND cpb_inst_code = cap_inst_code
           AND cpb_prod_code = cap_prod_code
		   AND c.cpc_prod_code = prod_code
		   AND c.cpc_card_type = card_type
           AND cpb_inst_bin = bin
           AND c.cpc_inst_code = cap_inst_code      --Modified for MVHOST-389
           AND c.cpc_prod_code = cap_prod_code        --Modified for MVHOST-389
           AND c.cpc_card_type = cap_card_type      --Modified for MVHOST-389

           AND cp.CPC_INST_CODE = c.cpc_inst_code   --Added for MVHOST-389
           AND cp.CPC_PROD_CODE = c.cpc_prod_code   --Added for MVHOST-389
           AND cp.CPC_CARD_ID = c.CPC_CARD_ID       --Added for MVHOST-389
          -- AND cp.CPC_PRINT_VENDOR ='SourceOne'     --Added for MVHOST-389 --Commented for for FSS-2236
            --AND cp.CPC_PRINT_VENDOR like 'SourceOne%' --Added for FSS-2236
            AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
            AND CP.CPC_CARD_ID           =C.CPC_CARD_ID
            AND CP.CPC_PROD_CODE         =C.CPC_PROD_CODE
            AND PACKIDMAST.VPM_VENDOR_ID like 'SourceOne%'
            and nvl(c.CPC_B2B_FLAG,'N')='N'


           AND cam_inst_code=cap_inst_code  --Added for FSS-1757
           AND cam_appl_code=cap_appl_code  --Added for FSS-1757
           AND cam_appl_stat = 'O'        --Added for FSS-1757
           AND ((p_file_name is not null and cam_file_name in(SELECT regexp_substr(p_file_name,'[^,]+', 1, level) items
            FROM dual
            CONNECT BY regexp_substr(p_file_name, '[^,]+', 1, level) is not null)) or p_file_name is null) --Added for FSS-1757

         --  AND cpc_package_id IS NOT NULL
           AND cap_proxy_number IS NULL
           AND cap_inst_code = p_inst_code
           and CAP_CARD_STAT <> V_CAP_CARD_STAT
         --  and ((P_STARER_GPR_TYPE is not null and CAP_STARTERCARD_FLAG=DECODE(P_STARER_GPR_TYPE,'C','Y','I','Y','N')) or P_STARER_GPR_TYPE is null)  --Added for MVHOST-389
           and ((P_STARER_GPR_TYPE is not null and CAP_STARTERCARD_FLAG=DECODE(P_STARER_GPR_TYPE,'C','Y','I','Y','B','Y','N')) or P_STARER_GPR_TYPE is null) --Added for MVHOST-389
      ORDER BY cap_startercard_flag DESC,cam_file_name,cp.CPC_PRINT_VENDOR; --Added order by filename --Modified for FSS-2236
   TYPE cur_sourceone_type IS TABLE OF cur_sourceone%ROWTYPE;
   cur_sourceone_data   cur_sourceone_type;

   CURSOR cur_cpifile (bin NUMBER, prod_code VARCHAR2, card_type NUMBER )
   IS
      SELECT   a.ROWID row_id, c.cpc_prod_code, c.cpc_card_type, cap_pan_code
          FROM cms_cardissuance_status,
               cms_appl_pan a,
               cms_prod_bin,
               cms_prod_cattype c,
               cms_prod_cardpack cp,
               CMS_APPL_MAST  --Added for FSS-1757
               ,VMS_PACKAGEID_MAST PACKIDMAST
         WHERE ccs_inst_code = cap_inst_code
           AND ccs_pan_code = cap_pan_code
           AND ccs_card_status = card_status
           AND cpb_inst_code = cap_inst_code
           AND cpb_prod_code = cap_prod_code
           AND cpb_inst_bin = bin
           AND c.cpc_inst_code = cap_inst_code
           AND c.cpc_prod_code = cap_prod_code
           AND c.cpc_card_type = cap_card_type
		   AND c.cpc_prod_code = prod_code
		   AND c.cpc_card_type = card_type

           AND cp.CPC_INST_CODE = c.cpc_inst_code   --Added for MVHOST-389
           AND cp.CPC_PROD_CODE = c.cpc_prod_code --Added for MVHOST-389
           AND cp.CPC_CARD_ID = c.CPC_CARD_ID    --Added for MVHOST-389
          -- AND cp.CPC_PRINT_VENDOR ='CPI'    --Added for MVHOST-389 --Commented for fss-2236
         -- AND CP.CPC_PRINT_VENDOR LIKE 'CPI%' --Added for FSS-2236
           AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
            AND CP.CPC_CARD_ID           =C.CPC_CARD_ID
            AND CP.CPC_PROD_CODE         =C.CPC_PROD_CODE
            AND PACKIDMAST.VPM_VENDOR_ID like 'CPI%'
            and nvl(c.CPC_B2B_FLAG,'N')='N'
           AND cam_inst_code=cap_inst_code
           AND cam_appl_code=cap_appl_code
           AND cam_appl_stat = 'O'
           AND ((p_file_name is not null and cam_file_name in(SELECT regexp_substr(p_file_name,'[^,]+', 1, level) items
            FROM dual
            CONNECT BY regexp_substr(p_file_name, '[^,]+', 1, level) is not null)) or p_file_name is null)

         --  AND cpc_prod_id IS NOT NULL
           AND cap_proxy_number IS NULL
           AND cap_inst_code = p_inst_code
           AND cap_card_stat <> v_cap_card_stat
     --      and ((P_STARER_GPR_TYPE is not null and CAP_STARTERCARD_FLAG=DECODE(P_STARER_GPR_TYPE,'C','Y','I','Y','N')) or P_STARER_GPR_TYPE is null) --Added for MVHOST-389
           and ((P_STARER_GPR_TYPE is not null and CAP_STARTERCARD_FLAG=DECODE(P_STARER_GPR_TYPE,'C','Y','I','Y','B','Y','N')) or P_STARER_GPR_TYPE is null) --Added for MVHOST-389
      ORDER BY cap_startercard_flag DESC,cam_file_name,cp.CPC_PRINT_VENDOR; --Added order by filename --Modifeid for fss-2236
   TYPE cur_cpifile_type IS TABLE OF cur_cpifile%ROWTYPE;
   cur_cpifile_data     cur_cpifile_type;

   CURSOR cur_sourceone_cardstock (bin NUMBER, prod_code VARCHAR2, card_type NUMBER)
   IS
      SELECT   a.ROWID row_id, c.cpc_prod_code, c.cpc_card_type, cap_pan_code
          FROM cms_cardissuance_status,
               cms_appl_pan_temp a,
               cms_prod_bin,
               cms_prod_cattype c,
               cms_prod_cardpack cp,
               CMS_APPL_MAST  --Added for FSS-1757
                ,VMS_PACKAGEID_MAST PACKIDMAST
         WHERE ccs_inst_code = cap_inst_code
           AND ccs_pan_code = cap_pan_code
           AND ccs_card_status = card_status
           AND cpb_inst_code = cap_inst_code
           AND cpb_prod_code = cap_prod_code
		   AND c.cpc_prod_code = prod_code
		   AND c.cpc_card_type = card_type
           AND cpb_inst_bin = bin
           AND c.cpc_inst_code = cap_inst_code      --Modified for MVHOST-389
           AND c.cpc_prod_code = cap_prod_code        --Modified for MVHOST-389
           AND c.cpc_card_type = cap_card_type      --Modified for MVHOST-389

           AND cp.CPC_INST_CODE = c.cpc_inst_code   --Added for MVHOST-389
           AND cp.CPC_PROD_CODE = c.cpc_prod_code   --Added for MVHOST-389
           AND cp.CPC_CARD_ID = c.CPC_CARD_ID       --Added for MVHOST-389
          -- AND cp.CPC_PRINT_VENDOR ='SourceOne'     --Added for MVHOST-389 --Commented for for FSS-2236
          -- AND cp.CPC_PRINT_VENDOR like 'SourceOne%' --Added for FSS-2236
            AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
            AND CP.CPC_CARD_ID           =C.CPC_CARD_ID
            AND CP.CPC_PROD_CODE         =C.CPC_PROD_CODE
            AND PACKIDMAST.VPM_VENDOR_ID like 'SourceOne%'


           AND cam_inst_code=cap_inst_code  --Added for FSS-1757
           AND cam_appl_code=cap_appl_code  --Added for FSS-1757
           AND cam_appl_stat = 'O'        --Added for FSS-1757
           AND ((p_file_name is not null and cam_file_name in(SELECT regexp_substr(p_file_name,'[^,]+', 1, level) items
            FROM dual
            CONNECT BY regexp_substr(p_file_name, '[^,]+', 1, level) is not null)) or p_file_name is null) --Added for FSS-1757

         --  AND cpc_package_id IS NOT NULL
           AND cap_proxy_number IS NULL
           AND cap_inst_code = p_inst_code
           AND cap_card_stat <> v_cap_card_stat
           and ((p_starer_gpr_type is not null and cap_startercard_flag=decode(p_starer_gpr_type,'C','Y','I','Y','N')) or p_starer_gpr_type is null)  --Added for MVHOST-389
      ORDER BY cap_startercard_flag DESC,cam_file_name,cp.CPC_PRINT_VENDOR; --Added order by filename --Modified for FSS-2236
   TYPE cur_sourceone_cardstock_type IS TABLE OF cur_sourceone_cardstock%ROWTYPE;
   cur_sourceone_cardstock_data   cur_sourceone_cardstock_type;

   CURSOR cur_cpifile_cardstock (bin NUMBER, prod_code VARChar2, card_type NUMBER)
   IS
      SELECT   a.ROWID row_id, c.cpc_prod_code, c.cpc_card_type, cap_pan_code
          FROM cms_cardissuance_status,
               cms_appl_pan_temp a,
               cms_prod_bin,
               cms_prod_cattype c,
               cms_prod_cardpack cp,
               CMS_APPL_MAST  --Added for FSS-1757
                ,VMS_PACKAGEID_MAST PACKIDMAST
         WHERE ccs_inst_code = cap_inst_code
           AND ccs_pan_code = cap_pan_code
           AND ccs_card_status = card_status
           AND cpb_inst_code = cap_inst_code
           AND cpb_prod_code = cap_prod_code
		   AND c.cpc_prod_code = prod_code
		   AND c.cpc_card_type = card_type
           AND cpb_inst_bin = bin
           AND c.cpc_inst_code = cap_inst_code
           AND c.cpc_prod_code = cap_prod_code
           AND c.cpc_card_type = cap_card_type

           AND cp.CPC_INST_CODE = c.cpc_inst_code   --Added for MVHOST-389
           AND cp.CPC_PROD_CODE = c.cpc_prod_code --Added for MVHOST-389
           AND cp.CPC_CARD_ID = c.CPC_CARD_ID    --Added for MVHOST-389
          -- AND cp.CPC_PRINT_VENDOR ='CPI'    --Added for MVHOST-389 --Commented for fss-2236
          --AND cp.CPC_PRINT_VENDOR like 'CPI%' --Added for FSS-2236
          AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
            AND CP.CPC_CARD_ID           =C.CPC_CARD_ID
            AND CP.CPC_PROD_CODE         =C.CPC_PROD_CODE
            AND PACKIDMAST.VPM_VENDOR_ID like 'CPI%'
           AND cam_inst_code=cap_inst_code
           AND cam_appl_code=cap_appl_code
           AND cam_appl_stat = 'O'
           AND ((p_file_name is not null and cam_file_name in(SELECT regexp_substr(p_file_name,'[^,]+', 1, level) items
            FROM dual
            CONNECT BY regexp_substr(p_file_name, '[^,]+', 1, level) is not null)) or p_file_name is null)

         --  AND cpc_prod_id IS NOT NULL
           AND cap_proxy_number IS NULL
           AND cap_inst_code = p_inst_code
           AND cap_card_stat <> v_cap_card_stat
           and ((p_starer_gpr_type is not null and cap_startercard_flag=decode(p_starer_gpr_type,'C','Y','I','Y','N')) or p_starer_gpr_type is null) --Added for MVHOST-389
      ORDER BY cap_startercard_flag DESC,cam_file_name,cp.CPC_PRINT_VENDOR; --Added order by filename --Modifeid for fss-2236
   TYPE cur_cpifile_cs_type IS TABLE OF cur_cpifile_cardstock%ROWTYPE;
   cur_cpifile_cs_data     cur_cpifile_cs_type;

   --St Added for DFCHOST-367 on 03/12/13
   CURSOR cur_sourceone_inv (bin NUMBER, prod_code VARCHAR2, card_type NUMBER)
   IS
      SELECT   a.ROWID row_id, pcat.cpc_prod_code, pcat.cpc_card_type, cap_pan_code
          FROM cms_cardissuance_status,
               cms_appl_pan_temp a,
               cms_prod_bin,
               cms_prod_cattype pcat,cms_merinv_merpan
               ,CMS_MERINV_PRODCAT,CMS_PROD_CARDPACK CRD       --Added for MVHOST-389
                ,VMS_PACKAGEID_MAST PACKIDMAST
         WHERE ccs_inst_code = cap_inst_code
           AND ccs_pan_code = cap_pan_code
           AND ccs_card_status = card_status
           AND cpb_inst_code = cap_inst_code
           AND cpb_prod_code = cap_prod_code
		   AND pcat.cpc_prod_code = prod_code
		   AND pcat.cpc_card_type = card_type
           AND cpb_inst_bin = bin
           AND pcat.cpc_inst_code = cap_inst_code
           AND pcat.cpc_prod_code = cap_prod_code
           AND pcat.cpc_card_type = cap_card_type
           and cap_inst_code=cmm_inst_code
           and cap_pan_code=cmm_pan_code

           AND cmm_merprodcat_id = cmp_merprodcat_id      --Added for MVHOST-389
           AND cmp_inst_code = pcat.cpc_inst_code
           AND cmp_prod_code = pcat.cpc_prod_code
           AND cmp_prod_cattype = pcat.cpc_card_type
           AND crd.CPC_INST_CODE = cmp_inst_code
           AND crd.CPC_PROD_CODE = cmp_prod_code
           AND crd.CPC_CARD_ID = CMP_CARD_ID
          -- AND crd.CPC_PRINT_VENDOR = 'SourceOne' --Commented  for FSS-2236
         -- AND CRD.CPC_PRINT_VENDOR LIKE 'SourceOne%' --Added for FSS-2236
          AND PACKIDMAST.VPM_PACKAGE_ID=CRD.CPC_CARD_DETAILS
            --AND CRD.CPC_CARD_ID           =pcat.CPC_CARD_ID
            AND CRD.CPC_PROD_CODE         =pcat.CPC_PROD_CODE
            AND PACKIDMAST.VPM_VENDOR_ID like 'SourceOne%'

           AND ((p_file_name is not null and cmm_ordr_refrno in(SELECT regexp_substr(p_file_name,'[^,]+', 1, level) items
            FROM dual
            CONNECT BY regexp_substr(p_file_name, '[^,]+', 1, level) is not null)) or p_file_name is null)  --Added for FSS-1757

          -- AND cpc_package_id IS NOT NULL
           AND cap_proxy_number IS NULL
           AND cap_inst_code = p_inst_code
           AND cap_card_stat <> v_cap_card_stat
      ORDER BY cmm_location_id,cmm_ordr_refrno,crd.CPC_PRINT_VENDOR; --Added for FSS-2236
   TYPE cur_sourceone_type_inv IS TABLE OF cur_sourceone_inv%ROWTYPE;
   cur_sourceone_data_inv   cur_sourceone_type_inv;

   CURSOR cur_cpifile_inv (bin NUMBER, prod_code VARCHAR2, card_type NUMBER)
   IS
      SELECT   a.ROWID row_id, pcat.cpc_prod_code, pcat.cpc_card_type, cap_pan_code
          FROM cms_cardissuance_status,
               cms_appl_pan_temp a,
               cms_prod_bin,
               cms_prod_cattype pcat,cms_merinv_merpan
               ,CMS_MERINV_PRODCAT,CMS_PROD_CARDPACK CRD   --Added for MVHOST-389
                ,VMS_PACKAGEID_MAST PACKIDMAST
         WHERE ccs_inst_code = cap_inst_code
           AND ccs_pan_code = cap_pan_code
           AND ccs_card_status = card_status
           AND cpb_inst_code = cap_inst_code
           AND cpb_prod_code = cap_prod_code
		   AND pcat.cpc_prod_code = prod_code
		   AND pcat.cpc_card_type = card_type
           AND cpb_inst_bin = bin
           AND pcat.cpc_inst_code = cap_inst_code
           AND pcat.cpc_prod_code = cap_prod_code
           AND pcat.cpc_card_type = cap_card_type
           and cap_inst_code=cmm_inst_code
           and cap_pan_code=cmm_pan_code

          AND cmm_merprodcat_id = cmp_merprodcat_id       --Added for MVHOST-389
          AND cmp_inst_code = pcat.cpc_inst_code
          AND cmp_prod_code = pcat.cpc_prod_code
          AND cmp_prod_cattype = pcat.cpc_card_type
          AND crd.CPC_INST_CODE = cmp_inst_code
          AND crd.CPC_PROD_CODE = cmp_prod_code
          AND crd.CPC_CARD_ID = CMP_CARD_ID
         -- AND crd.CPC_PRINT_VENDOR = 'CPI'  --Commented for FSS-2236
          --AND crd.CPC_PRINT_VENDOR like 'CPI%'  --Added for FSS-2236
            AND PACKIDMAST.VPM_PACKAGE_ID=Crd.CPC_CARD_DETAILS
            --AND CRD.CPC_CARD_ID           =pcat.CPC_CARD_ID
            AND CRD.CPC_PROD_CODE         =PCAT.CPC_PROD_CODE
            AND PACKIDMAST.VPM_VENDOR_ID like 'CPI%'

          AND ((p_file_name is not null and cmm_ordr_refrno in(SELECT regexp_substr(p_file_name,'[^,]+', 1, level) items
            FROM dual
            CONNECT BY regexp_substr(p_file_name, '[^,]+', 1, level) is not null)) or p_file_name is null) --Added for FSS-1757

          -- AND cpc_prod_id IS NOT NULL
           AND cap_proxy_number IS NULL
           AND cap_inst_code = p_inst_code
           AND cap_card_stat <> v_cap_card_stat
      ORDER BY cmm_location_id,cmm_ordr_refrno,crd.CPC_PRINT_VENDOR; --Added for FSS-2236
   TYPE cur_cpifile_type_inv IS TABLE OF cur_cpifile_inv%ROWTYPE;
   cur_cpifile_data_inv     cur_cpifile_type_inv;
   --End Added for DFCHOST-367 on 03/12/13
   
   
   
  CURSOR cur_sourceone_b2b (bin NUMBER,prod_code VARCHAR2,card_type NUMBER,orderId VARCHAR2,partnerId VARCHAR2)
IS
  SELECT a.ROWID row_id,
    c.cpc_prod_code,
    c.cpc_card_type,
    cap_pan_code
  FROM cms_cardissuance_status,
    cms_appl_pan a,
    cms_prod_bin,
    cms_prod_cattype c,
    cms_prod_cardpack cp,
    CMS_APPL_MAST ,
    VMS_PACKAGEID_MAST PACKIDMAST ,
    vms_line_item_dtl
  WHERE ccs_inst_code          = cap_inst_code
  AND ccs_pan_code             = cap_pan_code
  AND vli_pan_code             = cap_pan_code
  AND VLI_ORDER_ID             =orderId
  AND VLI_PARTNER_ID           =partnerId
  --AND VLI_LINEITEM_ID          =lineItemId
  AND ccs_card_status          = card_status
  AND cpb_inst_code            = cap_inst_code
  AND cpb_prod_code            = cap_prod_code
  AND c.cpc_prod_code          = prod_code
  AND c.cpc_card_type          = card_type
  AND cpb_inst_bin             = bin
  AND c.cpc_inst_code          = cap_inst_code
  AND c.cpc_prod_code          = cap_prod_code
  AND c.cpc_card_type          = cap_card_type
  AND cp.CPC_INST_CODE         = c.cpc_inst_code
  AND cp.CPC_PROD_CODE         = c.cpc_prod_code
  AND cp.CPC_CARD_ID           = c.CPC_CARD_ID
  AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
  AND CP.CPC_CARD_ID           =C.CPC_CARD_ID
  AND CP.CPC_PROD_CODE         =C.CPC_PROD_CODE
  AND PACKIDMAST.VPM_VENDOR_ID LIKE 'SourceOne%'
  AND cam_inst_code  =cap_inst_code
  AND cam_appl_code  =cap_appl_code
  AND cam_appl_stat  = 'O'
  AND ((p_file_name IS NOT NULL
  AND cam_file_name IN
    (SELECT regexp_substr(p_file_name,'[^,]+', 1, level) items
    FROM dual
      CONNECT BY regexp_substr(p_file_name, '[^,]+', 1, level) IS NOT NULL
    ))
  OR p_file_name          IS NULL)
  AND cap_proxy_number    IS NULL
  AND cap_inst_code        = p_inst_code
  AND CAP_CARD_STAT       <> V_CAP_CARD_STAT
  AND ((P_STARER_GPR_TYPE IS NOT NULL
  AND CAP_STARTERCARD_FLAG =DECODE(P_STARER_GPR_TYPE,'C','Y','I','Y','B','Y','N'))
  OR P_STARER_GPR_TYPE    IS NULL)
  ORDER BY VLI_ORDER_ID,VLI_PARTNER_ID,VLI_LINEITEM_ID, cap_startercard_flag DESC,
    cam_file_name,
    cp.CPC_PRINT_VENDOR;
TYPE cur_sourceone_b2b_type
IS
  TABLE OF cur_sourceone_b2b%ROWTYPE;
  cur_sourceone_b2b_data cur_sourceone_b2b_type;
  CURSOR cur_cpifile_b2b (bin NUMBER, prod_code VARCHAR2, card_type NUMBER ,orderId VARCHAR2,partnerId VARCHAR2)
  IS
    SELECT a.ROWID row_id,
      c.cpc_prod_code,
      c.cpc_card_type,
      cap_pan_code
    FROM cms_cardissuance_status,
      cms_appl_pan a,
      cms_prod_bin,
      cms_prod_cattype c,
      cms_prod_cardpack cp,
      CMS_APPL_MAST ,
      VMS_PACKAGEID_MAST PACKIDMAST,
    
      vms_line_item_dtl
    WHERE ccs_inst_code          = cap_inst_code
    AND ccs_pan_code             = cap_pan_code
    AND vli_pan_code             = cap_pan_code
    AND VLI_ORDER_ID             =orderId
    AND VLI_PARTNER_ID           =partnerId
    --AND VLI_LINEITEM_ID          =lineItemId
    AND ccs_card_status          = card_status
    AND cpb_inst_code            = cap_inst_code
    AND cpb_prod_code            = cap_prod_code
    AND cpb_inst_bin             = bin
    AND c.cpc_inst_code          = cap_inst_code
    AND c.cpc_prod_code          = cap_prod_code
    AND c.cpc_card_type          = cap_card_type
    AND c.cpc_prod_code          = prod_code
    AND c.cpc_card_type          = card_type
    AND cp.CPC_INST_CODE         = c.cpc_inst_code
    AND cp.CPC_PROD_CODE         = c.cpc_prod_code
    AND cp.CPC_CARD_ID           = c.CPC_CARD_ID
    AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
    AND CP.CPC_CARD_ID           =C.CPC_CARD_ID
    AND CP.CPC_PROD_CODE         =C.CPC_PROD_CODE
    AND PACKIDMAST.VPM_VENDOR_ID LIKE 'CPI%'
    AND cam_inst_code  =cap_inst_code
    AND cam_appl_code  =cap_appl_code
    AND cam_appl_stat  = 'O'
    AND ((p_file_name IS NOT NULL
    AND cam_file_name IN
      (SELECT regexp_substr(p_file_name,'[^,]+', 1, level) items
      FROM dual
        CONNECT BY regexp_substr(p_file_name, '[^,]+', 1, level) IS NOT NULL
      ))
    OR p_file_name          IS NULL)
    AND cap_proxy_number    IS NULL
    AND cap_inst_code        = p_inst_code
    AND cap_card_stat       <> v_cap_card_stat
    AND ((P_STARER_GPR_TYPE IS NOT NULL
    AND CAP_STARTERCARD_FLAG =DECODE(P_STARER_GPR_TYPE,'C','Y','I','Y','B','Y','N'))
    OR P_STARER_GPR_TYPE    IS NULL)
    ORDER BY VLI_ORDER_ID,VLI_PARTNER_ID,VLI_LINEITEM_ID, cap_startercard_flag DESC,
      cam_file_name,
      cp.CPC_PRINT_VENDOR;
  TYPE cur_cpifile_b2b_type
IS
  TABLE OF cur_cpifile_b2b%ROWTYPE;
  cur_cpifile_b2b_data cur_cpifile_b2b_type;
   
   
   
   PROCEDURE lp_get_proxy (
      p_inst_code      IN       NUMBER,
      p_bin            IN       NUMBER,
      p_prod_code      IN       VARCHAR2,
      p_card_tpe       IN       NUMBER,
      p_user           IN       NUMBER,
      v_proxylength    IN       NUMBER,
      V_PROGRAMID      in       varchar2,
      p_check_digit_request in  varchar2,
      progrm_id_request     in  varchar2,
	  p_proxy_number   OUT      VARCHAR2,
      p_errmsg         OUT      VARCHAR2
   )
   IS
   BEGIN
      p_errmsg := 'OK';
      IF progrm_id_request = 'Y'
      THEN
         BEGIN
            SELECT cpi_sequence_no
              INTO v_seqno
              FROM cms_program_id_cnt
             WHERE cpi_program_id = v_programid
                   AND cpi_inst_code = p_inst_code;
            p_proxy_number :=
               fn_proxy_no (p_bin,
                            LPAD (p_card_tpe, 2, 0),
                            v_programid,
                            NVL (v_seqno, 0),
                            p_inst_code,
                            p_user,
                            p_check_digit_request,
                            v_proxylength
                           );
            IF p_proxy_number = '0'
            THEN
               p_errmsg := 'proxy number should not be zero';
               RAISE exp_reject_record;
            END IF;
         EXCEPTION
            WHEN exp_reject_record
            THEN
               RAISE exp_reject_record;
            WHEN OTHERS
            THEN
               p_errmsg :=
                     'Error while generating Proxy number '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;
      ELSIF progrm_id_request = 'N'
      THEN
         BEGIN
            SELECT ROWID, LPAD (cpc_prxy_cntrlno, v_proxylength, 0)
                  INTO rowid_ctrlno, p_proxy_number
                  FROM cms_prxy_cntrl
                 WHERE cpc_inst_code = p_inst_code
                   AND cpc_prxy_key = DECODE (v_proxylength,7, 'PRXYCTRL7',
											                8, 'PRXYCTRL8',
														    9, 'PRXYCTRL',
														    10, 'PRXYCTRL10',
														    11, 'PRXYCTRL11',
														    12, 'PRXYCTRL12')
			FOR UPDATE;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p_errmsg :=
                  'Proxy number not defined for institution  ' || p_inst_code;
               RAISE exp_reject_record;
            WHEN OTHERS
            THEN
               p_errmsg :=
                     'Error while selecting cms_prxy_cntrl'
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;
         BEGIN
            UPDATE cms_prxy_cntrl
               SET cpc_prxy_cntrlno = cpc_prxy_cntrlno + 1,
                   cpc_lupd_user = p_user,
                   cpc_lupd_date = SYSDATE
             WHERE ROWID = rowid_ctrlno;
            IF SQL%ROWCOUNT = 0
            THEN
               p_errmsg := 'Proxy number is not updated successfully';
               RAISE exp_reject_record;
            END IF;
         EXCEPTION
            WHEN exp_reject_record
            THEN
               RAISE exp_reject_record;
            WHEN OTHERS
            THEN
               p_errmsg :=
                     'Error while updating cms_prxy_cntrl '
                  || SUBSTR (SQLERRM, 1, 200);
               RAISE exp_reject_record;
         END;
      ELSE
         p_errmsg := 'Invalid length for proxy number generation';
         RAISE exp_reject_record;
      END IF;
   EXCEPTION
      WHEN exp_reject_record
      THEN
         NULL;
      WHEN OTHERS
      THEN
         p_errmsg :=
               'Error in local function LFN_GET_PROXY '
            || SUBSTR (SQLERRM, 1, 200);
   END lp_get_proxy;
BEGIN
   p_errmsg := 'OK';

   --select '''' || replace(p_file_name, ',', ''',''') || '''' into v_file_name from dual; --Added for FSS-1757
if p_starer_gpr_type = 'G'   then
   FOR i IN (
             /* START Added by Dhiraj Gaikwad For performance Issue  on 13032012*/
             SELECT   cpb_inst_code, cpb_inst_bin bin,cpc_card_type card_type,
                      a.cap_prod_code prod_code, a.cap_inst_code inst_code,
                      cpc_proxy_length proxy_length,
                      cpc_program_id progrm_id,CPC_CHECK_DIGIT_REQ check_digit_request,
					  CPC_PROGRAMID_REQ progrm_id_request
                 from cms_prod_bin,
                      (SELECT   cap_inst_code, cap_prod_code,cap_card_type
                           FROM cms_cardissuance_status, cms_appl_pan
                          WHERE ccs_pan_code = cap_pan_code
                            AND ccs_card_status = card_status
                            AND cap_inst_code = p_inst_code
                            and CAP_PROXY_NUMBER is null
                       GROUP BY cap_inst_code, cap_prod_code,cap_card_type) a,
                      cms_prod_cattype
                WHERE cpb_inst_code = a.cap_inst_code
                  and CPB_PROD_CODE = a.CAP_PROD_CODE
                  and a.CAP_CARD_TYPE = CPC_CARD_TYPE

                 AND cpb_inst_code = cpc_inst_code
                  AND cpb_prod_code = cpc_prod_code --AND cpb_inst_bin='456789'
             ORDER BY cpb_inst_bin
             /* END Added by Dhiraj Gaikwad For performance Issue  on 13032012*/
           )
   LOOP
    OPEN cur_sourceone (i.bin, i.prod_code, i.card_type);
      LOOP
         FETCH cur_sourceone
         BULK COLLECT INTO cur_sourceone_data LIMIT 10000;


         EXIT WHEN cur_sourceone_data.COUNT () = 0;



         FOR j IN 1 .. cur_sourceone_data.COUNT ()
         LOOP
            BEGIN
               lp_get_proxy (p_inst_code,
                             i.bin,
                             cur_sourceone_data (j).cpc_prod_code,
                             cur_sourceone_data (j).cpc_card_type,
                             p_user,
                             i.proxy_length,
                             i.progrm_id,
                             i.check_digit_request,
                             i.progrm_id_request,
							 v_proxy_number,
                             p_errmsg
                            );
               IF p_errmsg = 'OK'
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_number = v_proxy_number,
                         cap_proxy_msg = 'Success',
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_DATA (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
                  IF SQL%ROWCOUNT = 0
                  THEN
                     p_errmsg :=
                           'Proxy number is not updated correctly for pan '
                        || cur_sourceone_data (j).cap_pan_code;
                     RAISE exp_reject_record;
                  END IF;
               ELSE
                  RAISE exp_reject_record;
               END IF;
            EXCEPTION
               WHEN exp_reject_record
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_DATA (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
               WHEN OTHERS
               THEN
                  p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_DATA (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
            END;
         END LOOP;
      END LOOP;
      CLOSE cur_sourceone;
--*************************************************--
      OPEN cur_cpifile (i.bin, i.prod_code, i.card_type);
      LOOP

         FETCH cur_cpifile
         BULK COLLECT INTO cur_cpifile_data LIMIT 10000;

         EXIT WHEN cur_cpifile_data.COUNT () = 0;

         FOR k IN 1 .. cur_cpifile_data.COUNT ()
         LOOP
            BEGIN
               lp_get_proxy (p_inst_code,
                             i.bin,
                             cur_cpifile_data (k).cpc_prod_code,
                             cur_cpifile_data (k).cpc_card_type,
                             p_user,
                             i.proxy_length,
                             i.progrm_id,
                             i.check_digit_request,
                             i.progrm_id_request,
							 v_proxy_number,
                             p_errmsg
                            );
               IF p_errmsg = 'OK'
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_number = v_proxy_number,
                         cap_proxy_msg = 'Success',
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_DATA (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
                  IF SQL%ROWCOUNT = 0
                  THEN
                     p_errmsg :=
                           'Proxy number is not updated correctly for pan '
                        || cur_cpifile_data (k).cap_pan_code;
                     RAISE exp_reject_record;
                  END IF;
               ELSE
                  RAISE exp_reject_record;
               END IF;
            EXCEPTION
               WHEN exp_reject_record
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_DATA (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
               WHEN OTHERS
               THEN
                  p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_DATA (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
            END;
         END LOOP;
      END LOOP;
      CLOSE cur_cpifile;
      end loop; -- end of GPR
elsif p_starer_gpr_type = 'B' then
   FOR i IN (

             SELECT   cpb_inst_code, cpb_inst_bin bin, cpc_card_type card_type,
                      a.cap_prod_code prod_code, a.cap_inst_code inst_code,
                      cpc_proxy_length proxy_length,
                      cpc_program_id progrm_id,CPC_CHECK_DIGIT_REQ check_digit_request,
					  CPC_PROGRAMID_REQ progrm_id_request,cpc_product_id productid,NVL(CPC_CCF_SERIAL_FLAG,'N') serialFlag
              ,VLI_ORDER_ID orderId,VLI_PARTNER_ID partnerId 
                 from cms_prod_bin,
                      (SELECT   cap_inst_code, cap_prod_code,cap_card_type,VLI_ORDER_ID,VLI_PARTNER_ID
                           FROM cms_cardissuance_status, cms_appl_pan,VMS_LINE_ITEM_DTL
                          WHERE ccs_pan_code = cap_pan_code
                            AND VLI_pan_code = cap_pan_code
                            AND ccs_card_status = card_status
                            AND cap_inst_code = p_inst_code
                            and CAP_PROXY_NUMBER is null
                       GROUP BY cap_inst_code, cap_prod_code,cap_card_type,VLI_ORDER_ID,VLI_PARTNER_ID) a,
                      cms_prod_cattype
                WHERE cpb_inst_code = a.cap_inst_code
                  and CPB_PROD_CODE = a.CAP_PROD_CODE
                  and a.CAP_CARD_TYPE = CPC_CARD_TYPE
                  and CPC_B2B_FLAG='Y'
                  AND cpb_inst_code = cpc_inst_code
                  AND cpb_prod_code = cpc_prod_code
				  ORDER BY cpb_inst_bin

           )
   LOOP
    OPEN cur_sourceone_b2b (i.bin, i.prod_code, i.card_type,i.orderId,i.partnerId);
                
        IF i.serialFlag='Y'    THEN 
            SELECT count(cap_pan_code)
                INTO v_sourceone_count
        FROM cms_cardissuance_status,
          cms_appl_pan a,
          cms_prod_bin,
          cms_prod_cattype c,
          cms_prod_cardpack cp,
          CMS_APPL_MAST ,
          VMS_PACKAGEID_MAST PACKIDMAST ,
          vms_line_item_dtl
        WHERE ccs_inst_code          = cap_inst_code
        AND ccs_pan_code             = cap_pan_code
        AND vli_pan_code             = cap_pan_code
        AND VLI_ORDER_ID             =i.orderId
        AND VLI_PARTNER_ID           =i.partnerId
        AND ccs_card_status          = card_status
        AND cpb_inst_code            = cap_inst_code
        AND cpb_prod_code            = cap_prod_code
        AND c.cpc_prod_code          = i.prod_code
        AND c.cpc_card_type          = i.card_type
        AND cpb_inst_bin             = i.bin
        AND c.cpc_inst_code          = cap_inst_code
        AND c.cpc_prod_code          = cap_prod_code
        AND c.cpc_card_type          = cap_card_type
        AND cp.CPC_INST_CODE         = c.cpc_inst_code
        AND cp.CPC_PROD_CODE         = c.cpc_prod_code
        AND cp.CPC_CARD_ID           = c.CPC_CARD_ID
        AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
        AND CP.CPC_CARD_ID           =C.CPC_CARD_ID
        AND CP.CPC_PROD_CODE         =C.CPC_PROD_CODE
        AND PACKIDMAST.VPM_VENDOR_ID LIKE 'SourceOne%'
        AND cam_inst_code  =cap_inst_code
        AND cam_appl_code  =cap_appl_code
        AND cam_appl_stat  = 'O'
        AND ((p_file_name IS NOT NULL
        AND cam_file_name IN
          (SELECT regexp_substr(p_file_name,'[^,]+', 1, level) items
          FROM dual
            CONNECT BY regexp_substr(p_file_name, '[^,]+', 1, level) IS NOT NULL
          ))
        OR p_file_name          IS NULL)
        AND cap_proxy_number    IS NULL
        AND cap_inst_code        = p_inst_code
        AND CAP_CARD_STAT       <> V_CAP_CARD_STAT
        AND ((P_STARER_GPR_TYPE IS NOT NULL
        AND CAP_STARTERCARD_FLAG =DECODE(P_STARER_GPR_TYPE,'C','Y','I','Y','B','Y','N'))
        OR P_STARER_GPR_TYPE    IS NULL);
        
            vmsb2bapi.get_serials (i.productid, v_sourceone_count, l_serials, p_errmsg);
         end if;   
         v_sourceone_id :=0;
      LOOP
         FETCH cur_sourceone_b2b
         BULK COLLECT INTO cur_sourceone_b2b_data LIMIT 10000;


         EXIT WHEN cur_sourceone_b2b_data.COUNT () = 0;


         begin
        IF i.serialFlag='Y'    THEN 
            
         if p_errmsg = 'OK'
         then
         FOR j IN 1 .. cur_sourceone_b2b_data.COUNT ()
         LOOP
				 v_sourceone_id :=v_sourceone_id+1;
            begin
           
               lp_get_proxy (p_inst_code,
                             i.bin,
                             cur_sourceone_b2b_data (j).cpc_prod_code,
                             cur_sourceone_b2b_data (j).cpc_card_type,
                             p_user,
                             i.proxy_length,
                             i.progrm_id,
                             i.check_digit_request,
                             i.progrm_id_request,
							 v_proxy_number,
                             p_errmsg
                            );
               IF p_errmsg = 'OK'
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_number = v_proxy_number,
                         cap_proxy_msg = 'Success',
                         CAP_SERIAL_NUMBER = l_serials(v_sourceone_id),
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_b2b_DATA (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
                  IF SQL%ROWCOUNT = 0
                  THEN
                     p_errmsg :=
                           'Proxy number is not updated correctly for pan '
                        || cur_sourceone_b2b_data (j).cap_pan_code;
                     RAISE exp_reject_record;
                  END IF;
               ELSE
                  RAISE exp_reject_record;
               END IF;
            EXCEPTION
               WHEN exp_reject_record
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_b2b_DATA (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
               WHEN OTHERS
               THEN
                  p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_b2b_DATA (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
            END;
         END LOOP;
       ELSE
           raise exp_reject_record;
           END IF;  
          ELSE
              FOR j IN 1 .. cur_sourceone_b2b_data.COUNT ()
         LOOP
            begin
               lp_get_proxy (p_inst_code,
                             i.bin,
                             cur_sourceone_b2b_data (j).cpc_prod_code,
                             cur_sourceone_b2b_data (j).cpc_card_type,
                             p_user,
                             i.proxy_length,
                             i.progrm_id,
                             i.check_digit_request,
                             i.progrm_id_request,
							 v_proxy_number,
                             p_errmsg
                            );
               IF p_errmsg = 'OK'
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_number = v_proxy_number,
                         cap_proxy_msg = 'Success',
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_b2b_DATA (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
                  IF SQL%ROWCOUNT = 0
                  THEN
                     p_errmsg :=
                           'Proxy number is not updated correctly for pan '
                        || cur_sourceone_b2b_data (j).cap_pan_code;
                     RAISE exp_reject_record;
                  END IF;
               ELSE
                  RAISE exp_reject_record;
               END IF;
            EXCEPTION
               WHEN exp_reject_record
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_b2b_DATA (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
               WHEN OTHERS
               THEN
                  p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_b2b_DATA (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
            END;
         END LOOP;
            END IF;  
       EXCEPTION
       WHEN exp_reject_record
       then
           NULL;
       WHEN OTHERS
       THEN
       p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
          NULL;
       END;
      END LOOP;
      CLOSE cur_sourceone_b2b;
--*************************************************--
      OPEN cur_cpifile_b2b (i.bin, i.prod_code, i.card_type,i.orderId,i.partnerId);
        
        
    
    IF i.serialFlag='Y'    THEN  
    
    SELECT count(cap_pan_code)
        INTO v_cpi_count
    FROM cms_cardissuance_status,
      cms_appl_pan a,
      cms_prod_bin,
      cms_prod_cattype c,
      cms_prod_cardpack cp,
      CMS_APPL_MAST ,
      VMS_PACKAGEID_MAST PACKIDMAST,
    
      vms_line_item_dtl
    WHERE ccs_inst_code          = cap_inst_code
    AND ccs_pan_code             = cap_pan_code
    AND vli_pan_code             = cap_pan_code
    AND VLI_ORDER_ID             =i.orderId
    AND VLI_PARTNER_ID           =i.partnerId
    AND ccs_card_status          = card_status
    AND cpb_inst_code            = cap_inst_code
    AND cpb_prod_code            = cap_prod_code
    AND cpb_inst_bin             = i.bin
    AND c.cpc_inst_code          = cap_inst_code
    AND c.cpc_prod_code          = cap_prod_code
    AND c.cpc_card_type          = cap_card_type
    AND c.cpc_prod_code          = i.prod_code
    AND c.cpc_card_type          = i.card_type
    AND cp.CPC_INST_CODE         = c.cpc_inst_code
    AND cp.CPC_PROD_CODE         = c.cpc_prod_code
    AND cp.CPC_CARD_ID           = c.CPC_CARD_ID
    AND PACKIDMAST.VPM_PACKAGE_ID=CP.CPC_CARD_DETAILS
    AND CP.CPC_CARD_ID           =C.CPC_CARD_ID
    AND CP.CPC_PROD_CODE         =C.CPC_PROD_CODE
    AND PACKIDMAST.VPM_VENDOR_ID LIKE 'CPI%'
    AND cam_inst_code  =cap_inst_code
    AND cam_appl_code  =cap_appl_code
    AND cam_appl_stat  = 'O'
    AND ((p_file_name IS NOT NULL
    AND cam_file_name IN
      (SELECT regexp_substr(p_file_name,'[^,]+', 1, level) items
      FROM dual
        CONNECT BY regexp_substr(p_file_name, '[^,]+', 1, level) IS NOT NULL
      ))
    OR p_file_name          IS NULL)
    AND cap_proxy_number    IS NULL
    AND cap_inst_code        = p_inst_code
    AND cap_card_stat       <> v_cap_card_stat
    AND ((P_STARER_GPR_TYPE IS NOT NULL
    AND CAP_STARTERCARD_FLAG =DECODE(P_STARER_GPR_TYPE,'C','Y','I','Y','B','Y','N'))
    OR P_STARER_GPR_TYPE    IS NULL);
            vmsb2bapi.get_serials (i.productid, v_cpi_count, l_serials, p_errmsg);
     END IF;       
        v_cpi_id :=0;
      LOOP

         FETCH cur_cpifile_b2b
         BULK COLLECT INTO cur_cpifile_b2b_data LIMIT 10000;

         EXIT WHEN cur_cpifile_b2b_data.COUNT () = 0;
        begin
        IF i.serialFlag='Y'    THEN  
              
         if p_errmsg = 'OK'
         then
         FOR k IN 1 .. cur_cpifile_b2b_data.COUNT ()
         LOOP
					v_cpi_id :=v_cpi_id+1;
            BEGIN
               lp_get_proxy (p_inst_code,
                             i.bin,
                             cur_cpifile_b2b_data (k).cpc_prod_code,
                             cur_cpifile_b2b_data (k).cpc_card_type,
                             p_user,
                             i.proxy_length,
                             i.progrm_id,
                             i.check_digit_request,
                             i.progrm_id_request,
							 v_proxy_number,
                             p_errmsg
                            );
               IF p_errmsg = 'OK'
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_number = v_proxy_number,
                         cap_proxy_msg = 'Success',
                         CAP_SERIAL_NUMBER = l_serials(v_cpi_id),
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_b2b_DATA (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
                  IF SQL%ROWCOUNT = 0
                  THEN
                     p_errmsg :=
                           'Proxy number is not updated correctly for pan '
                        || cur_cpifile_b2b_data (k).cap_pan_code;
                     RAISE exp_reject_record;
                  END IF;
               ELSE
                  RAISE exp_reject_record;
               END IF;
            EXCEPTION
               WHEN exp_reject_record
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_b2b_DATA (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
               WHEN OTHERS
               THEN
                  p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_b2b_DATA (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
            END;
         end loop;
        ELSE
           raise exp_reject_record;
        END IF; 
       ELSE
               FOR k IN 1 .. cur_cpifile_b2b_data.COUNT ()
         LOOP
            BEGIN
               lp_get_proxy (p_inst_code,
                             i.bin,
                             cur_cpifile_b2b_data (k).cpc_prod_code,
                             cur_cpifile_b2b_data (k).cpc_card_type,
                             p_user,
                             i.proxy_length,
                             i.progrm_id,
                             i.check_digit_request,
                             i.progrm_id_request,
                             v_proxy_number,
                             p_errmsg
                            );
               IF p_errmsg = 'OK'
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_number = v_proxy_number,
                         cap_proxy_msg = 'Success',
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_b2b_DATA (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
                  IF SQL%ROWCOUNT = 0
                  THEN
                     p_errmsg :=
                           'Proxy number is not updated correctly for pan '
                        || cur_cpifile_b2b_data (k).cap_pan_code;
                     RAISE exp_reject_record;
                  END IF;
               ELSE
                  RAISE exp_reject_record;
               END IF;
            EXCEPTION
               WHEN exp_reject_record
               THEN
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_b2b_DATA (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
               WHEN OTHERS
               THEN
                  p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_b2b_DATA (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
            END;
         end loop;
        END IF;  
       EXCEPTION
       WHEN exp_reject_record
       then
           NULL;
       WHEN OTHERS
       then
       p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
          NULL;
       END;  
      END LOOP;
      close cur_cpifile_b2b;
      END loop; -- end of GPR
  Else --Start of Starter card from Temp
  FOR i IN (
             /* START Added by Dhiraj Gaikwad For performance Issue  on 13032012*/
             SELECT   cpb_inst_code, cpb_inst_bin bin, cpc_card_type card_type,
                      a.cap_prod_code prod_code, a.cap_inst_code inst_code,
                      cpc_proxy_length proxy_length,
                      cpc_program_id progrm_id,CPC_CHECK_DIGIT_REQ check_digit_request,
					  CPC_PROGRAMID_REQ progrm_id_request
                 from cms_prod_bin,
                      (SELECT   cap_inst_code, cap_prod_code,cap_card_type
                           FROM cms_cardissuance_status, cms_appl_pan_temp
                          WHERE ccs_pan_code = cap_pan_code
                            AND ccs_card_status = card_status
                            AND cap_inst_code = p_inst_code
                            and CAP_PROXY_NUMBER is null
                       GROUP BY cap_inst_code, cap_prod_code,cap_card_type) a,
                      cms_prod_cattype
                WHERE cpb_inst_code = a.cap_inst_code
                  AND cpb_prod_code = a.cap_prod_code
                  --and CPC_B2B_FLAG=(case when P_STARER_GPR_TYPE='B' then 'Y' else 'N' end)
                  and a.CAP_CARD_TYPE=CPC_CARD_TYPE
				  AND cpb_inst_code = cpc_inst_code
                  AND cpb_prod_code = cpc_prod_code --AND cpb_inst_bin='456789'
             ORDER BY cpb_inst_bin
             /* END Added by Dhiraj Gaikwad For performance Issue  on 13032012*/
           )
   LOOP

   --Added for DFCHOST-367 on 03/12/13
   --****************START INVENTORY***************************
 if p_starer_gpr_type is null or p_starer_gpr_type = 'I' then   --Added for MVHOST-389
   OPEN cur_sourceone_inv (i.bin, i.prod_code, i.card_type);
      LOOP
         FETCH cur_sourceone_inv
         BULK COLLECT INTO cur_sourceone_data_inv LIMIT 10000;


         EXIT WHEN cur_sourceone_data_inv.COUNT () = 0;



         FOR j IN 1 .. cur_sourceone_data_inv.COUNT ()
         LOOP
            BEGIN
               lp_get_proxy (p_inst_code,
                             i.bin,
                             cur_sourceone_data_inv (j).cpc_prod_code,
                             cur_sourceone_data_inv (j).cpc_card_type,
                             p_user,
                             i.proxy_length,
                             i.progrm_id,
                             i.check_digit_request,
                             i.progrm_id_request,
							 v_proxy_number,
                             p_errmsg
                            );
               IF p_errmsg = 'OK'
               THEN
                  UPDATE cms_appl_pan_temp
                     SET cap_proxy_number = v_proxy_number,
                         cap_proxy_msg = 'Success',
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_DATA_INV (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
                  IF SQL%ROWCOUNT = 0
                  THEN
                     p_errmsg :=
                           'Proxy number is not updated correctly for pan '
                        || cur_sourceone_data_inv (j).cap_pan_code;
                     RAISE exp_reject_record;
                  END IF;
               ELSE
                  RAISE exp_reject_record;
               END IF;
            EXCEPTION
               WHEN exp_reject_record
               THEN
                  UPDATE cms_appl_pan_temp
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_DATA_INV (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
               WHEN OTHERS
               THEN
                  p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
                  UPDATE cms_appl_pan_temp
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_SOURCEONE_DATA_INV (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
            END;
         END LOOP;
      END LOOP;
      CLOSE cur_sourceone_inv;
--*************************************************--
      OPEN cur_cpifile_inv (i.bin, i.prod_code, i.card_type);
      LOOP

         FETCH cur_cpifile_inv
         BULK COLLECT INTO cur_cpifile_data_inv LIMIT 10000;

         EXIT WHEN cur_cpifile_data_inv.COUNT () = 0;

         FOR k IN 1 .. cur_cpifile_data_inv.COUNT ()
         LOOP
            BEGIN
               lp_get_proxy (p_inst_code,
                             i.bin,
                             cur_cpifile_data_inv (k).cpc_prod_code,
                             cur_cpifile_data_inv (k).cpc_card_type,
                             p_user,
                             i.proxy_length,
                             i.progrm_id,
                             i.check_digit_request,
                             i.progrm_id_request,
							 v_proxy_number,
                             p_errmsg
                            );
               IF p_errmsg = 'OK'
               THEN
                  UPDATE cms_appl_pan_temp
                     SET cap_proxy_number = v_proxy_number,
                         cap_proxy_msg = 'Success',
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_DATA_INV (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
                  IF SQL%ROWCOUNT = 0
                  THEN
                     p_errmsg :=
                           'Proxy number is not updated correctly for pan '
                        || cur_cpifile_data_inv (k).cap_pan_code;
                     RAISE exp_reject_record;
                  END IF;
               ELSE
                  RAISE exp_reject_record;
               END IF;
            EXCEPTION
               WHEN exp_reject_record
               THEN
                  UPDATE cms_appl_pan_temp
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_DATA_INV (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
               WHEN OTHERS
               THEN
                  p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = CUR_CPIFILE_DATA_INV (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
            END;
         END LOOP;
      END LOOP;
      CLOSE cur_cpifile_inv;
      --End Added for DFCHOST-367 on 03/12/13
   end if;  --Added for MVHOST-389
     --******************END INVENTORY***********************************************************************
   if p_starer_gpr_type is null or p_starer_gpr_type = 'C'  then  --Added for MVHOST-389
      OPEN cur_sourceone_cardstock (i.bin, i.prod_code, i.card_type);
      LOOP
         FETCH cur_sourceone_cardstock
         BULK COLLECT INTO cur_sourceone_cardstock_data LIMIT 10000;


         EXIT WHEN cur_sourceone_cardstock_data.COUNT () = 0;



         FOR j IN 1 .. cur_sourceone_cardstock_data.COUNT ()
         LOOP
            BEGIN
               lp_get_proxy (p_inst_code,
                             i.bin,
                             cur_sourceone_cardstock_data (j).cpc_prod_code,
                             cur_sourceone_cardstock_data (j).cpc_card_type,
                             p_user,
                             i.proxy_length,
                             i.progrm_id,
                             i.check_digit_request,
                             i.progrm_id_request,
							 v_proxy_number,
                             p_errmsg
                            );
               IF p_errmsg = 'OK'
               THEN
                  UPDATE cms_appl_pan_temp
                     SET cap_proxy_number = v_proxy_number,
                         cap_proxy_msg = 'Success',
                         cap_lupd_user = p_user
                   WHERE ROWID = cur_sourceone_cardstock_data (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
                  IF SQL%ROWCOUNT = 0
                  THEN
                     p_errmsg :=
                           'Proxy number is not updated correctly for pan '
                        || cur_sourceone_cardstock_data (j).cap_pan_code;
                     RAISE exp_reject_record;
                  END IF;
               ELSE
                  RAISE exp_reject_record;
               END IF;
            EXCEPTION
               WHEN exp_reject_record
               THEN
                  UPDATE cms_appl_pan_temp
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = cur_sourceone_cardstock_data (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
               WHEN OTHERS
               THEN
                  p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
                  UPDATE cms_appl_pan_temp
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = cur_sourceone_cardstock_data (J).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
            END;
         END LOOP;
      END LOOP;
      CLOSE cur_sourceone_cardstock;
--*************************************************--
      OPEN cur_cpifile_cardstock (i.bin, i.prod_code, i.card_type);
      LOOP

         FETCH cur_cpifile_cardstock
         BULK COLLECT INTO cur_cpifile_cs_data LIMIT 10000;

         EXIT WHEN cur_cpifile_cs_data.COUNT () = 0;

         FOR k IN 1 .. cur_cpifile_cs_data.COUNT ()
         LOOP
            BEGIN
               lp_get_proxy (p_inst_code,
                             i.bin,
                             cur_cpifile_cs_data (k).cpc_prod_code,
                             cur_cpifile_cs_data (k).cpc_card_type,
                             p_user,
                             i.proxy_length,
                             i.progrm_id,
                             i.check_digit_request,
                             i.progrm_id_request,
							 v_proxy_number,
                             p_errmsg
                            );
               IF p_errmsg = 'OK'
               THEN
                  UPDATE cms_appl_pan_temp
                     SET cap_proxy_number = v_proxy_number,
                         cap_proxy_msg = 'Success',
                         cap_lupd_user = p_user
                   WHERE ROWID = cur_cpifile_cs_data (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
                  IF SQL%ROWCOUNT = 0
                  THEN
                     p_errmsg :=
                           'Proxy number is not updated correctly for pan '
                        || cur_cpifile_cs_data (k).cap_pan_code;
                     RAISE exp_reject_record;
                  END IF;
               ELSE
                  RAISE exp_reject_record;
               END IF;
            EXCEPTION
               WHEN exp_reject_record
               THEN
                  UPDATE cms_appl_pan_temp
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = cur_cpifile_cs_data (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
               WHEN OTHERS
               THEN
                  p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
                  UPDATE cms_appl_pan
                     SET cap_proxy_msg = p_errmsg,
                         cap_lupd_user = p_user
                   WHERE ROWID = cur_cpifile_cs_data (K).ROW_ID
                    AND cap_proxy_number IS NULL; -- FSS-4853 - Duplicate Proxy Number issue
            END;
         END LOOP;
      END LOOP;
      CLOSE cur_cpifile_cardstock;
    end if;   --Added for MVHOST-389
--*************************************************--
   --En Fetching records for generating proxy number for CPI file.
   END LOOP;
  End if;
--En Fetching distinct BIN number for card which are in printer pending status
EXCEPTION
   WHEN OTHERS
   THEN
      p_errmsg := 'Error in main ' || SUBSTR (SQLERRM, 1, 200);
END; 

/
show error