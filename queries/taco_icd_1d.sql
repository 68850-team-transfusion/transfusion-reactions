CREATE TEMPORARY TABLE all_blood_inputs AS
-- temp_table is from all_blood_inputs.sql
SELECT inputs.subject_id, 
    inputs.hadm_id, 
    inputs.icustay_id, 
    inputs.starttime, 
    inputs.endtime, 
    inputs.itemid, 
    items.label,
    CASE 
        WHEN inputs.amountuom = "uL" THEN inputs.amount * 1000 
        ELSE inputs.amount 
    END AS amount,
    CASE 
        WHEN inputs.amountuom = "uL" THEN "ml"
        ELSE inputs.amountuom 
    END AS amountuom,
    inputs.totalamount,
    inputs.totalamountuom,
    inputs.statusdescription, 
    inputs.cancelreason, 
    inputs.orderid, 
    inputs.linkorderid
FROM physionet-data.mimiciii_clinical.inputevents_mv inputs 
INNER JOIN physionet-data.mimiciii_clinical.d_items items ON inputs.itemid = items.itemid
WHERE inputs.itemid IN (225168, 225170, 225171, 227070, 227071, 227072, 220970, 227532, 226367, 226368, 226369, 226371)
GROUP BY inputs.subject_id, 
    inputs.hadm_id, 
    inputs.icustay_id, 
    inputs.starttime, 
    inputs.endtime, 
    inputs.itemid, 
    items.label,
    inputs.amount,
    inputs.amountuom,
    inputs.totalamount,
    inputs.totalamountuom,
    inputs.statusdescription, 
    inputs.cancelreason, 
    inputs.orderid, 
    inputs.linkorderid;

-- Get notes with matching patients records 
SELECT * 
FROM physionet-data.mimiciii_clinical.diagnoses_icd AS icd
LEFT JOIN physionet-data.mimiciii_clinical.d_icd_diagnoses AS d_icd 
    ON icd.ICD9_CODE = d_icd.ICD9_CODE
WHERE (SUBJECT_ID IN (SELECT subject_id FROM all_blood_inputs))
    AND icd.ICD9_CODE IN ('5184', '51881', '78609', '4280', '7850', '7851', '7852', '7823', '27669', '78605', '7867')
    