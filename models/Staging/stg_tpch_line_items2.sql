COPY INTO IDENTIFIER($V_TABLE_FULL_LANDING) (value, file_name, loaded_at, EXTRACTED_AT)
             FROM (
                 SELECT 
                    $1, 
                    metadata$filename, 
                    CURRENT_TIMESTAMP as loaded_at,
                    TO_TIMESTAMP_NTZ (SPLIT_PART(SPLIT_PART(metadata$filename, '/', 5),'=',2) || SPLIT_PART(SPLIT_PART(metadata$filename, '/',6),'=',2) ||SPLIT_PART(SPLIT_PART(metadata$filename, '/', 7),'=',2), 'YYYYMMDD') AS EXTRACTED_AT
                 FROM @dev_SAP_batch_stage
                (PATTERN => $V_PATTERN ,
                FILE_FORMAT => CDP_FIN_DEV_SRC.SAP_LANDING.SAP_json_format_zied);