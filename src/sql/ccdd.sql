SET check_function_bodies = false;

CREATE SCHEMA ccdd;
-- ddl-end --
ALTER SCHEMA ccdd OWNER TO postgres;


-- object: ccdd.mp_whitelist | type: TABLE --
-- DROP TABLE IF EXISTS ccdd.mp_whitelist CASCADE;
CREATE TABLE ccdd.mp_whitelist(
	drug_code varchar NOT NULL,
	CONSTRAINT mp_whitelist_pk PRIMARY KEY (drug_code)

);
-- ddl-end --
ALTER TABLE ccdd.mp_whitelist OWNER TO postgres;
-- ddl-end --

-- object: ccdd.mp_blacklist | type: TABLE --
-- DROP TABLE IF EXISTS ccdd.mp_blacklist CASCADE;
CREATE TABLE ccdd.mp_blacklist(
	drug_code varchar NOT NULL,
	CONSTRAINT mp_blacklist_pk PRIMARY KEY (drug_code)

);
-- ddl-end --
ALTER TABLE ccdd.mp_blacklist OWNER TO postgres;

CREATE TABLE ccdd.ntp_deprecations(
	code varchar NOT NULL,
	CONSTRAINT ntp_deprecations_pk PRIMARY KEY (code)
);
-- ddl-end --
ALTER TABLE ccdd.ntp_deprecations OWNER TO postgres;

CREATE TABLE ccdd.tm_deprecations(
	code varchar NOT NULL,
	status_effective_time date NOT NULL,
	CONSTRAINT tm_deprecations_pk PRIMARY KEY (code)
);
-- ddl-end --
ALTER TABLE ccdd.tm_deprecations OWNER TO postgres;

CREATE TABLE ccdd.ntp_dosage_forms(
	ntp_dosage_form_code bigint,
	ntp_dosage_form text,
	route_of_administration_code text,
	route_of_administration text,
	route_of_administration_f text,
	pharm_form_code text,
	pharmaceutical_form text,
	pharmaceutical_form_f text,
	audit_id bigint
);
-- ddl-end --
ALTER TABLE ccdd.ntp_dosage_forms OWNER TO postgres;


CREATE TABLE ccdd.ingredient_stem_csv(
	ccdd varchar,
	top250name varchar,
	dpd_ingredient varchar,
	ing_stem varchar,
	hydrate varchar,
	ntp_ing varchar
);
-- ddl-end --
ALTER TABLE ccdd.ingredient_stem_csv OWNER TO postgres;
-- ddl-end --

-- object: ccdd.tm_definition | type: TABLE --
-- DROP TABLE IF EXISTS ccdd.tm_definition CASCADE;
CREATE TABLE ccdd.tm_definition(
	code bigint NOT NULL,
	formal_name text NOT NULL,
	CONSTRAINT tm_definition_pk PRIMARY KEY (code)
);
-- ddl-end --
ALTER TABLE ccdd.tm_definition OWNER TO postgres;

CREATE TABLE ccdd.unit_of_presentation_csv(
	drug_code bigint,
	unit_of_presentation varchar,
	uop_size varchar,
	uop_unit_of_measure varchar,
	calculation varchar,
	uop_size_insert varchar
);
-- ddl-end --
ALTER TABLE ccdd.unit_of_presentation_csv OWNER TO postgres;

CREATE TABLE ccdd.tm_filter(
	tm_code varchar
);
-- ddl-end --
ALTER TABLE ccdd.tm_filter OWNER TO postgres;

CREATE TABLE ccdd.mp_deprecations(
	mp_code varchar NOT NULL,
	CONSTRAINT mp_deprecations_pk PRIMARY KEY (mp_code)

);
ALTER TABLE ccdd.mp_deprecations OWNER TO postgres;

CREATE TABLE ccdd.mp_release_candidate(
	mp_code varchar,
	mp_formal_name text,
	mp_en_description text,
	mp_fr_description text,
	mp_status varchar,
	mp_status_effective_time varchar,
	mp_type varchar,
	"Health_Canada_identifier" text,
	"Health_Canada_product_name" text
);
-- ddl-end --
ALTER TABLE ccdd.mp_release_candidate OWNER TO postgres;

CREATE TABLE ccdd.mp_ntp_tm_relationship_release_candidate(
	mp_code varchar,
	mp_formal_name text,
	ntp_code varchar,
	ntp_formal_name text,
	tm_code varchar,
	tm_formal_name text
);
-- ddl-end --
ALTER TABLE ccdd.mp_ntp_tm_relationship_release_candidate OWNER TO postgres;

CREATE TABLE ccdd.tm_release_candidate(
	tm_code varchar,
	tm_formal_name text,
	tm_status varchar,
	tm_status_effective_time varchar
);
-- ddl-end --
ALTER TABLE ccdd.tm_release_candidate OWNER TO postgres;
-- ddl-end --

-- object: ccdd.ntp_release_candidate | type: TABLE --
-- DROP TABLE IF EXISTS ccdd.ntp_release_candidate CASCADE;
CREATE TABLE ccdd.ntp_release_candidate(
	ntp_code varchar,
	ntp_formal_name text,
	ntp_en_description text,
	ntp_fr_description text,
	ntp_status varchar,
	ntp_status_effective_time varchar,
	ntp_type varchar
);
-- ddl-end --
ALTER TABLE ccdd.ntp_release_candidate OWNER TO postgres;

CREATE TABLE ccdd.ntp_full_release(
	ntp_code varchar,
	ntp_formal_name text,
	ntp_en_description text,
	ntp_fr_description text,
	ntp_status varchar,
	ntp_status_effective_time varchar,
	ntp_type varchar
);
-- ddl-end --
ALTER TABLE ccdd.ntp_full_release OWNER TO postgres;
-- ddl-end --

-- object: ccdd.tm_full_release | type: TABLE --
-- DROP TABLE IF EXISTS ccdd.tm_full_release CASCADE;
CREATE TABLE ccdd.tm_full_release(
	tm_code varchar,
	tm_formal_name text,
	tm_status varchar,
	tm_status_effective_time varchar
);
-- ddl-end --
ALTER TABLE ccdd.tm_full_release OWNER TO postgres;

CREATE TABLE ccdd.combination_products_csv(
	drug_code bigint NOT NULL,
	drug_identification_number varchar,
	mp_formal_name varchar,
	ntp_formal_name varchar,
	ntp_type varchar,
	CONSTRAINT combination_products_csv_pk PRIMARY KEY (drug_code)

);
-- ddl-end --
ALTER TABLE ccdd.combination_products_csv OWNER TO postgres;

CREATE TABLE ccdd.mp_release(
	mp_code varchar,
	mp_formal_name text,
	mp_en_description text,
	mp_fr_description text,
	mp_status varchar,
	mp_status_effective_time varchar,
	mp_type varchar,
	"Health_Canada_identifier" text,
	"Health_Canada_product_name" text
);
-- ddl-end --
ALTER TABLE ccdd.mp_release OWNER TO postgres;

CREATE TABLE ccdd.ntp_definition(
	code bigint NOT NULL,
	formal_name text NOT NULL,
	CONSTRAINT ntp_definition_pk PRIMARY KEY (code),
	CONSTRAINT ntp_definition_name UNIQUE (formal_name)

);
-- ddl-end --
ALTER TABLE ccdd.ntp_definition OWNER TO postgres;

CREATE TABLE ccdd.pseudodin_map(
	pseudodin bigint NOT NULL,
	drug_code bigint NOT NULL,
	unit_of_presentation varchar NOT NULL,
	uop_size_amount varchar NOT NULL,
	uop_size_unit varchar NOT NULL,
	CONSTRAINT pseudodin_map_pk PRIMARY KEY (pseudodin)

);
-- ddl-end --
ALTER TABLE ccdd.pseudodin_map OWNER TO postgres;

CREATE TABLE ccdd.ntp_release(
	ntp_code varchar,
	ntp_formal_name text,
	ntp_en_description text,
	ntp_fr_description text,
	ntp_status varchar,
	ntp_status_effective_time varchar,
	ntp_type varchar
);
-- ddl-end --
ALTER TABLE ccdd.ntp_release OWNER TO postgres;

CREATE TABLE ccdd.tm_release(
	tm_code varchar,
	tm_formal_name text,
	tm_status varchar,
	tm_status_effective_time varchar
);
-- ddl-end --
ALTER TABLE ccdd.tm_release OWNER TO postgres;
-- ddl-end --

-- object: ccdd.mp_ntp_tm_relationship_release | type: TABLE --
-- DROP TABLE IF EXISTS ccdd.mp_ntp_tm_relationship_release CASCADE;
CREATE TABLE ccdd.mp_ntp_tm_relationship_release(
	mp_code varchar,
	mp_formal_name text,
	ntp_code varchar,
	ntp_formal_name text,
	tm_code varchar,
	tm_formal_name text
);
-- ddl-end --
ALTER TABLE ccdd.mp_ntp_tm_relationship_release OWNER TO postgres;

CREATE TABLE ccdd.tm_groupings(
	tm_code bigint NOT NULL,
	policy_type integer NOT NULL,
	policy_reference varchar NOT NULL
);
-- ddl-end --
ALTER TABLE ccdd.tm_groupings OWNER TO postgres;

CREATE TABLE ccdd.special_groupings(
	ccdd_code varchar NOT NULL,
	ccdd_formal_name text NOT NULL,
	ccdd_type varchar,
	policy_type varchar,
	policy_reference varchar,
	special_groupings_status text,
	special_groupings_status_effective_time text
);
-- ddl-end --
ALTER TABLE ccdd.special_groupings OWNER TO postgres;

CREATE TABLE ccdd.mp_brand_override(
	drug_code bigint NOT NULL,
	brand text,
	CONSTRAINT mp_brand_override_pk PRIMARY KEY (drug_code)

);
-- ddl-end --
ALTER TABLE ccdd.mp_brand_override OWNER TO postgres;
