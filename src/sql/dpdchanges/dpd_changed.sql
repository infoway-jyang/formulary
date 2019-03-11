CREATE SCHEMA if not exists dpd_changed;
DROP TABLE IF EXISTS dpd_changed.drug_codes;
DROP TABLE IF EXISTS dpd_changed.active_ingredient;
DROP TABLE IF EXISTS dpd_changed.companies;
DROP TABLE IF EXISTS dpd_changed.drug_product;
DROP TABLE IF EXISTS dpd_changed.packaging;
DROP TABLE IF EXISTS dpd_changed.pharmaceutical_form;
DROP TABLE IF EXISTS dpd_changed.pharmaceutical_std;
DROP TABLE IF EXISTS dpd_changed.route;
DROP TABLE IF EXISTS dpd_changed.schedule;
DROP TABLE IF EXISTS dpd_changed.status;
DROP TABLE IF EXISTS dpd_changed.therapeutic_class;
DROP TABLE IF EXISTS dpd_changed.vet_species;

SELECT distinct(drug_code) INTO dpd_changed.drug_codes FROM
 (
  	SELECT drug_code from dpd_changes.active_ingredient_changes UNION ALL
  	SELECT drug_code from dpd_changes.companies_changes UNION ALL
  	SELECT drug_code from dpd_changes.drug_product_changes UNION ALL
  	SELECT drug_code from dpd_changes.new_drug UNION ALL
  	SELECT drug_code from dpd_changes.pharmaceutical_form_changes UNION ALL
  	SELECT drug_code from dpd_changes.route_changes UNION ALL
  	SELECT drug_code from dpd_changes.status_changes
  ) as dpd_drug_codes
;

SELECT * INTO dpd_changed.active_ingredient from dpd.active_ingredient WHERE dpd.active_ingredient.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

SELECT * INTO dpd_changed.companies from dpd.companies WHERE dpd.companies.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

SELECT * INTO dpd_changed.drug_product from dpd.drug_product WHERE dpd.drug_product.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

SELECT * INTO dpd_changed.packaging from dpd.packaging WHERE dpd.packaging.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

SELECT * INTO dpd_changed.pharmaceutical_form from dpd.pharmaceutical_form WHERE dpd.pharmaceutical_form.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

SELECT * INTO dpd_changed.pharmaceutical_std from dpd.pharmaceutical_std WHERE dpd.pharmaceutical_std.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

SELECT * INTO dpd_changed.route from dpd.route WHERE dpd.route.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

SELECT * INTO dpd_changed.schedule from dpd.schedule WHERE dpd.schedule.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

SELECT * INTO dpd_changed.status from dpd.status WHERE dpd.status.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

SELECT * INTO dpd_changed.therapeutic_class from dpd.therapeutic_class WHERE dpd.therapeutic_class.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

SELECT * INTO dpd_changed.vet_species from dpd.vet_species WHERE dpd.vet_species.drug_code IN (SELECT drug_code from dpd_changed.drug_codes);

ALTER SCHEMA dpd RENAME TO dpd_new;
ALTER SCHEMA dpd_changed RENAME to dpd;
