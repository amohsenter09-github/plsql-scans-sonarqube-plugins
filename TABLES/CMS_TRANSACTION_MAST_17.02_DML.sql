update vmscms.cms_transaction_mast set ctm_card_activation='N';

UPDATE vmscms.CMS_TRANSACTION_MAST SET CTM_CARD_ACTIVATION='Y'
WHERE (
        (CTM_DELIVERY_CHANNEL='07' AND CTM_TRAN_CODE='02')
        OR
        (CTM_DELIVERY_CHANNEL='10' AND CTM_TRAN_CODE='02')
        OR
        (CTM_DELIVERY_CHANNEL='13' AND CTM_TRAN_CODE='21')
        OR
        (CTM_DELIVERY_CHANNEL='07' AND CTM_TRAN_CODE='09')
        OR
        (CTM_DELIVERY_CHANNEL='03' AND CTM_TRAN_CODE='74')
        OR
        (CTM_DELIVERY_CHANNEL='06' AND CTM_TRAN_CODE='03')
        OR
        (CTM_DELIVERY_CHANNEL='03' AND CTM_TRAN_CODE='03')
        OR
        (CTM_DELIVERY_CHANNEL='13' AND CTM_TRAN_CODE='19')
        OR
        (CTM_DELIVERY_CHANNEL='04' AND CTM_TRAN_CODE='68')
        OR
        (CTM_DELIVERY_CHANNEL='14' AND CTM_TRAN_CODE='07')
        OR
        (CTM_DELIVERY_CHANNEL='06' AND CTM_TRAN_CODE='05')
        OR
        (CTM_DELIVERY_CHANNEL='03' AND CTM_TRAN_CODE='90')
      );