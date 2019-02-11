CREATE SCHEMA if not exists dpd_changes;

DROP TABLE IF EXISTS dpd_changes.new_drug;
DROP TABLE IF EXISTS dpd_changes.drug_product_changes;
DROP TABLE IF EXISTS dpd_changes.companies_changes;
DROP TABLE IF EXISTS dpd_changes.status_changes;
DROP TABLE IF EXISTS dpd_changes.route_changes;
DROP TABLE IF EXISTS dpd_changes.pharmaceutical_form_changes;
DROP TABLE IF EXISTS dpd_changes.active_ingredient_changes;
DROP TABLE IF EXISTS dpd_changes.drugs;

SELECT drug_new.* into dpd_changes.new_drug
FROM dpd_new.drug_product as drug_new LEFT JOIN dpd_old.drug_product as drug_old ON
     drug_new.drug_code = drug_old.drug_code
WHERE drug_old.drug_code is null AND drug_new."class" = 'Human';

SELECT drug_code into dpd_changes.drugs
From public.ccdd_mp_release_candidate
left join dpd_new.drug_product
on public.ccdd_mp_release_candidate."Health_Canada_identifier" = dpd_new.drug_product.drug_identification_number;

SELECT drug_new.brand_name as new_brand_name, drug_old.brand_name as old_brand_name, dpd_changes.drugs.drug_code into dpd_changes.drug_product_changes
FROM dpd_changes.drugs
LEFT JOIN dpd_new.drug_product as drug_new ON drug_new.drug_code = dpd_changes.drugs.drug_code
LEFT JOIN dpd_old.drug_product as drug_old ON drug_old.drug_code = dpd_changes.drugs.drug_code
WHERE drug_new.brand_name <> drug_old.brand_name;

SELECT drug_new.company_name as new_company_name, drug_old.company_name as old_company_name, dpd_changes.drugs.drug_code into dpd_changes.companies_changes
FROM dpd_changes.drugs
LEFT JOIN dpd_new.companies as drug_new ON drug_new.drug_code = dpd_changes.drugs.drug_code
LEFT JOIN dpd_old.companies as drug_old ON drug_old.drug_code = dpd_changes.drugs.drug_code
WHERE drug_new.company_name <> drug_old.company_name;

SELECT drug_new.status as new_status, drug_old.status as old_status, drug_new.history_date as new_history_date, drug_old.history_date as old_history_date, drug_new.drug_code into dpd_changes.status_changes
FROM dpd_new.status as drug_new LEFT JOIN dpd_old.status as drug_old ON
     drug_new.drug_code=drug_old.drug_code AND drug_new.current_status_flag = 'Y' AND drug_old.current_status_flag = 'Y'
WHERE (drug_new.status <> drug_old.status OR drug_new.history_date <> drug_old.history_date)
  AND drug_new.drug_code IN (SELECT drug_code from dpd_changes.drugs);

SELECT drug_code, route_of_administration_code, min(status) AS status into dpd_changes.route_changes
from
((SELECT route_of_administration_code, drug_code, 'ADDED' AS status
FROM dpd_new.route AS drug_new)
UNION ALL
(SELECT route_of_administration_code, drug_code, 'REMOVED' AS status
FROM dpd_old.route AS drug_old) ) s
GROUP BY (drug_code, route_of_administration_code)
HAVING count(*) <> 2;

SELECT drug_code, pharm_form_code, min(status) AS status into dpd_changes.pharmaceutical_form_changes
from
((SELECT pharm_form_code, drug_code, 'ADDED' AS status
FROM dpd_new.pharmaceutical_form AS drug_new)
UNION ALL
(SELECT pharm_form_code, drug_code, 'REMOVED' AS status
FROM dpd_old.pharmaceutical_form AS drug_old) ) s
GROUP BY (drug_code, pharm_form_code)
HAVING count(*) <> 2;

SELECT
  drug_new.drug_code,
  drug_new.active_ingredient_code,
  CAST('CHANGED' AS text) AS status,
  drug_new.dosage_unit as new_dosage_unit,
  drug_old.dosage_unit as old_dosage_unit,
  drug_new.dosage_value as new_dosage_value,
  drug_old.dosage_value as old_dosage_value,
  drug_new.strength_unit as new_strength_unit,
  drug_old.strength_unit as old_strength_unit,
  drug_new.strength as new_strength,
  drug_old.strength as old_strength,
  drug_new.ingredient as new_ingredient,
  drug_old.ingredient as old_ingredient
  INTO dpd_changes.active_ingredient_changes
FROM dpd_new.active_ingredient as drug_new INNER JOIN dpd_old.active_ingredient as drug_old ON
     drug_new.drug_code=drug_old.drug_code AND drug_new.active_ingredient_code=drug_old.active_ingredient_code AND drug_new.notes=drug_old.notes
WHERE (
  drug_new.ingredient <> drug_old.ingredient
  OR drug_new.active_ingredient_code <> drug_old.active_ingredient_code
  OR drug_new.strength <> drug_old.strength
  OR drug_new.strength_unit <> drug_old.strength_unit
  OR drug_new.dosage_value <> drug_old.dosage_value
  OR drug_new.dosage_unit <> drug_old.dosage_unit
) AND drug_new.drug_code IN (SELECT drug_code from dpd_changes.drugs);

INSERT INTO dpd_changes.active_ingredient_changes (drug_code, active_ingredient_code, status)
(SELECT drug_code, active_ingredient_code, min(status) AS status
FROM
((SELECT active_ingredient_code, drug_code, 'ADDED' AS status, notes
FROM dpd_new.active_ingredient AS drug_new)
UNION ALL
(SELECT active_ingredient_code, drug_code, 'REMOVED' AS status, notes
FROM dpd_old.active_ingredient AS drug_old) ) s
GROUP BY (drug_code, active_ingredient_code, notes)
HAVING count(*) = 1
);
