-- Autumn 2021 edition
-- Postgres 13

DROP SCHEMA IF EXISTS patstat CASCADE;
CREATE SCHEMA patstat AUTHORIZATION patstat;

CREATE TABLE patstat.tls201_appln 
(
	appln_id int NOT NULL DEFAULT ('0'),
	appln_auth char(2) NOT NULL DEFAULT (''),
	appln_nr varchar(15)  NOT NULL DEFAULT (''),
	appln_kind char(2) NOT NULL DEFAULT ('  '),
	appln_filing_date date NOT NULL DEFAULT ('9999-12-31'),
	appln_filing_year smallint NOT NULL DEFAULT '9999',
	appln_nr_epodoc varchar(20)  NOT NULL DEFAULT (''),
	appln_nr_original varchar(100) NOT NULL DEFAULT (''),
	ipr_type char(2) NOT NULL DEFAULT (''),
	receiving_office char(2) NOT NULL DEFAULT (''),
	internat_appln_id int NOT NULL DEFAULT ('0'),
	int_phase char(1) NOT NULL DEFAULT ('N'),
	reg_phase char(1) NOT NULL DEFAULT ('N'),
	nat_phase char(1) NOT NULL DEFAULT ('N'),
	earliest_filing_date date NOT NULL DEFAULT ('9999-12-31'),
	earliest_filing_year smallint NOT NULL DEFAULT '9999',
	earliest_filing_id int NOT NULL DEFAULT '0',
	earliest_publn_date date NOT NULL DEFAULT ('9999-12-31'),
	earliest_publn_year smallint NOT NULL DEFAULT '9999',
	earliest_pat_publn_id int NOT NULL DEFAULT '0',
	granted char(1) NOT NULL DEFAULT ('N'),
	docdb_family_id int NOT NULL DEFAULT ('0'),
	inpadoc_family_id int NOT NULL DEFAULT ('0'),
	docdb_family_size smallint NOT NULL default '0',
	nb_citing_docdb_fam smallint NOT NULL default '0',
	nb_applicants smallint NOT NULL default '0',
	nb_inventors smallint NOT NULL default '0',
  CONSTRAINT pk_appln_id_auth PRIMARY KEY(appln_id, appln_auth)
) PARTITION BY LIST (appln_auth);

ALTER TABLE patstat.tls201_appln
  OWNER TO patstat;
  
create table patstat.tls201_appln_cn PARTITION OF patstat.tls201_appln FOR VALUES IN ('CN');
create table patstat.tls201_appln_jp PARTITION OF patstat.tls201_appln FOR VALUES IN ('JP');
create table patstat.tls201_appln_us PARTITION OF patstat.tls201_appln FOR VALUES IN ('US');
create table patstat.tls201_appln_de PARTITION OF patstat.tls201_appln FOR VALUES IN ('DE');
create table patstat.tls201_appln_kr PARTITION OF patstat.tls201_appln FOR VALUES IN ('KR');
create table patstat.tls201_appln_wo PARTITION OF patstat.tls201_appln FOR VALUES IN ('WO');
create table patstat.tls201_appln_ep PARTITION OF patstat.tls201_appln FOR VALUES IN ('EP');
create table patstat.tls201_appln_default PARTITION OF patstat.tls201_appln DEFAULT;

ALTER TABLE patstat.tls201_appln_cn OWNER TO patstat;
ALTER TABLE patstat.tls201_appln_jp OWNER TO patstat;
ALTER TABLE patstat.tls201_appln_us OWNER TO patstat;
ALTER TABLE patstat.tls201_appln_de OWNER TO patstat;
ALTER TABLE patstat.tls201_appln_kr OWNER TO patstat;
ALTER TABLE patstat.tls201_appln_wo OWNER TO patstat;
ALTER TABLE patstat.tls201_appln_ep OWNER TO patstat;
ALTER TABLE patstat.tls201_appln_default OWNER TO patstat;
  
  
CREATE TABLE patstat.tls202_appln_title 
(
appln_id int NOT NULL DEFAULT ('0'),
appln_title_lg char(2) NOT NULL DEFAULT (''),
appln_title text NOT NULL,
  CONSTRAINT pk_appln_title_appln_id PRIMARY KEY(appln_id)
);
ALTER TABLE patstat.tls202_appln_title
OWNER TO patstat;

CREATE TABLE patstat.tls203_appln_abstr 
(
	appln_id int NOT NULL DEFAULT ('0'),
	appln_abstract_lg char(2) NOT NULL DEFAULT (''),
	appln_abstract text NOT NULL DEFAULT (''),
    CONSTRAINT pk_appln_abstr PRIMARY KEY(appln_id, appln_abstract_lg)
) PARTITION BY LIST (appln_abstract_lg);
ALTER TABLE patstat.tls203_appln_abstr
OWNER TO patstat;

create table patstat.tls203_appln_abstr_de PARTITION OF patstat.tls203_appln_abstr FOR VALUES IN ('de');
create table patstat.tls203_appln_abstr_en PARTITION OF patstat.tls203_appln_abstr FOR VALUES IN ('en');
create table patstat.tls203_appln_abstr_es PARTITION OF patstat.tls203_appln_abstr FOR VALUES IN ('es');
create table patstat.tls203_appln_abstr_fr PARTITION OF patstat.tls203_appln_abstr FOR VALUES IN ('fr');
create table patstat.tls203_appln_abstr_ja PARTITION OF patstat.tls203_appln_abstr FOR VALUES IN ('ja');
create table patstat.tls203_appln_abstr_ko PARTITION OF patstat.tls203_appln_abstr FOR VALUES IN ('ko');
create table patstat.tls203_appln_abstr_pt PARTITION OF patstat.tls203_appln_abstr FOR VALUES IN ('pt');
create table patstat.tls203_appln_abstr_zh PARTITION OF patstat.tls203_appln_abstr FOR VALUES IN ('zh');
create table patstat.tls203_appln_abstr_default PARTITION OF patstat.tls203_appln_abstr DEFAULT;

ALTER TABLE patstat.tls203_appln_abstr_de OWNER TO patstat;
ALTER TABLE patstat.tls203_appln_abstr_en OWNER TO patstat;
ALTER TABLE patstat.tls203_appln_abstr_es OWNER TO patstat;
ALTER TABLE patstat.tls203_appln_abstr_fr OWNER TO patstat;
ALTER TABLE patstat.tls203_appln_abstr_ja OWNER TO patstat;
ALTER TABLE patstat.tls203_appln_abstr_ko OWNER TO patstat;
ALTER TABLE patstat.tls203_appln_abstr_pt OWNER TO patstat;
ALTER TABLE patstat.tls203_appln_abstr_zh OWNER TO patstat;
ALTER TABLE patstat.tls203_appln_abstr_default OWNER TO patstat;

CREATE TABLE patstat.tls204_appln_prior 
(
	appln_id int NOT NULL DEFAULT ('0'),
	prior_appln_id int NOT NULL DEFAULT ('0'),
	prior_appln_seq_nr smallint NOT NULL DEFAULT ('0'),
  CONSTRAINT pk_appln_prior PRIMARY KEY(appln_id, prior_appln_id)
);
ALTER TABLE patstat.tls204_appln_prior
OWNER TO patstat;

CREATE TABLE patstat.tls205_tech_rel 
(
	appln_id int NOT NULL DEFAULT ('0'),
	tech_rel_appln_id int NOT NULL DEFAULT ('0'),
  CONSTRAINT pk_tech_rel PRIMARY KEY(appln_id, tech_rel_appln_id)
);
ALTER TABLE patstat.tls205_tech_rel
OWNER TO patstat;

CREATE TABLE patstat.tls206_person 
(
	person_id int NOT NULL DEFAULT ('0'),
	person_name text NOT NULL DEFAULT (''),
	person_name_orig_lg text NOT NULL DEFAULT (''),
	person_address varchar(1000) NOT NULL DEFAULT (''),
	person_ctry_code char(2) NOT NULL DEFAULT (''),
	nuts varchar(5) NOT NULL DEFAULT '',
	nuts_level smallint NOT NULL DEFAULT ('9'),
	doc_std_name_id int NOT NULL DEFAULT ('0'),
	doc_std_name text  NOT NULL DEFAULT (''),
	psn_id int NOT NULL DEFAULT ('0'),
	psn_name text NOT NULL DEFAULT (''),
	psn_level smallint NOT NULL DEFAULT ('0'),
	psn_sector varchar(50) NOT NULL DEFAULT (''),
	han_id int NOT NULL DEFAULT ('0'),
	han_name text NOT NULL DEFAULT (''),
	han_harmonized int NOT NULL DEFAULT ('0'),
  CONSTRAINT pk_person PRIMARY KEY(person_id)
);
ALTER TABLE patstat.tls206_person
OWNER TO patstat;

CREATE TABLE patstat.tls207_pers_appln 
(
	person_id int NOT NULL DEFAULT ('0'),
	appln_id int NOT NULL DEFAULT ('0'),
	applt_seq_nr smallint NOT NULL DEFAULT ('0'),
	invt_seq_nr smallint NOT NULL DEFAULT ('0'),
  CONSTRAINT pk_pers_appln PRIMARY KEY(person_id, appln_id, applt_seq_nr, invt_seq_nr)
);
ALTER TABLE patstat.tls207_pers_appln
OWNER TO patstat;

CREATE TABLE patstat.tls209_appln_ipc 
(
	appln_id int NOT NULL DEFAULT ('0'),
	ipc_class_symbol varchar(15) NOT NULL DEFAULT (''),
	ipc_class_level char(1) NOT NULL DEFAULT (''),
	ipc_version date NOT NULL DEFAULT ('9999-12-31'),
	ipc_value char(1) NOT NULL DEFAULT (''),
	ipc_position char(1) NOT NULL DEFAULT (''),
	ipc_gener_auth char(2) NOT NULL DEFAULT (''),
  CONSTRAINT pk_appln_ipc PRIMARY KEY(appln_id, ipc_class_symbol)
);
ALTER TABLE patstat.tls209_appln_ipc
OWNER TO patstat;

CREATE TABLE patstat.tls210_appln_n_cls 
(
	appln_id int NOT NULL DEFAULT ('0'),
	nat_class_symbol varchar(15) NOT NULL DEFAULT (''),
  CONSTRAINT pk_appln_n_cls PRIMARY KEY(appln_id, nat_class_symbol)
 );
ALTER TABLE patstat.tls210_appln_n_cls
OWNER TO patstat; 

CREATE TABLE patstat.tls211_pat_publn 
(
	pat_publn_id int NOT NULL DEFAULT ('0'),
	publn_auth char(2) NOT NULL DEFAULT (''),
	publn_nr varchar(15) NOT NULL DEFAULT (''),
	publn_nr_original varchar(100) NOT NULL DEFAULT (''),
	publn_kind char(2) NOT NULL DEFAULT (''),
	appln_id int NOT NULL DEFAULT ('0'),
	publn_date date NOT NULL DEFAULT ('9999-12-31'),
	publn_lg char(2) NOT NULL DEFAULT (''),
	publn_first_grant char(1) NOT NULL DEFAULT ('N'),
	publn_claims smallint NOT NULL DEFAULT ('0'),
  CONSTRAINT pk_pat_publn PRIMARY KEY(pat_publn_id)
   );
ALTER TABLE patstat.tls211_pat_publn
OWNER TO patstat; 

CREATE TABLE patstat.tls212_citation 
(
	pat_publn_id int NOT NULL DEFAULT ('0'),
	citn_replenished int NOT NULL DEFAULT ('0'),
	citn_id smallint NOT NULL DEFAULT ('0'),
	citn_origin char(3) NOT NULL DEFAULT (''),
	cited_pat_publn_id int NOT NULL DEFAULT ('0'),
	cited_appln_id int NOT NULL DEFAULT ('0'),
	pat_citn_seq_nr smallint NOT NULL DEFAULT ('0'),
	cited_npl_publn_id char(32) NOT NULL DEFAULT ('0'),
	npl_citn_seq_nr smallint NOT NULL DEFAULT ('0'),
	citn_gener_auth char(2) NOT NULL DEFAULT (''),      
  CONSTRAINT pk_tls212_citation PRIMARY KEY(pat_publn_id, citn_replenished, citn_id)
   );
ALTER TABLE patstat.tls212_citation
OWNER TO patstat; 

CREATE TABLE patstat.tls214_npl_publn 
(
	npl_publn_id char(32) NOT NULL DEFAULT ('0'),
	xp_nr int NOT NULL DEFAULT('0'),
	npl_type char(1) NOT NULL DEFAULT (''),
	npl_biblio text NOT NULL DEFAULT (''),
	npl_author text NOT NULL DEFAULT (''),
	npl_title1 text NOT NULL DEFAULT (''),
	npl_title2 text NOT NULL DEFAULT (''),
	npl_editor character varying NOT NULL DEFAULT (''),
	npl_volume character varying NOT NULL DEFAULT (''),
	npl_issue character varying NOT NULL DEFAULT (''),
	npl_publn_date character varying NOT NULL DEFAULT (''),
	npl_publn_end_date character varying NOT NULL DEFAULT (''),
	npl_publisher character varying NOT NULL DEFAULT (''),
	npl_page_first character varying NOT NULL DEFAULT (''),
	npl_page_last character varying NOT NULL DEFAULT (''),
	npl_abstract_nr character varying NOT NULL DEFAULT (''),
	npl_doi character varying NOT NULL DEFAULT (''),
	npl_isbn character varying NOT NULL DEFAULT (''),
	npl_issn character varying NOT NULL DEFAULT (''),
	online_availability character varying NOT NULL DEFAULT (''),	
	online_classification character varying NOT NULL DEFAULT (''),
	online_search_date character varying NOT NULL DEFAULT (''),
    CONSTRAINT pk_tls214_npl_publn PRIMARY KEY(npl_publn_id)
   );
ALTER TABLE patstat.tls214_npl_publn
OWNER TO patstat; 

CREATE TABLE patstat.tls215_citn_categ
(
	pat_publn_id int NOT NULL DEFAULT ('0'),
	citn_replenished int NOT NULL DEFAULT ('0'),
	citn_id smallint NOT NULL DEFAULT ('0'),
	citn_categ varchar(10) NOT NULL DEFAULT (''),
	relevant_claim smallint NOT NULL DEFAULT ('0'),
  CONSTRAINT pk_tls215_citn_categ PRIMARY KEY(pat_publn_id, citn_replenished, citn_id, citn_categ, relevant_claim)
   );
ALTER TABLE patstat.tls215_citn_categ
OWNER TO patstat; 

CREATE TABLE patstat.tls216_appln_contn
(
	appln_id int NOT NULL DEFAULT ('0'),
	parent_appln_id int NOT NULL DEFAULT ('0'),
	contn_type char(3) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls216_appln_contn PRIMARY KEY(appln_id, parent_appln_id)
   );
ALTER TABLE patstat.tls216_appln_contn
OWNER TO patstat;   

CREATE TABLE patstat.tls222_appln_jp_class
(
	appln_id int NOT NULL DEFAULT ('0'),
	jp_class_scheme varchar(5) NOT NULL DEFAULT (''),
	jp_class_symbol varchar(50) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls222_appln_jp_class PRIMARY KEY(appln_id, jp_class_scheme, jp_class_symbol)
   );
ALTER TABLE patstat.tls222_appln_jp_class
OWNER TO patstat;  

CREATE TABLE patstat.tls223_appln_docus
(
	appln_id int NOT NULL DEFAULT ('0'),
	docus_class_symbol varchar(50) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls223_appln_docus PRIMARY KEY(appln_id, docus_class_symbol)
   );
ALTER TABLE patstat.tls223_appln_docus
OWNER TO patstat;  

CREATE TABLE patstat.tls224_appln_cpc
(
	appln_id int NOT NULL DEFAULT ('0'),
	cpc_class_symbol varchar(19) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls224_appln_cpc PRIMARY KEY(appln_id, cpc_class_symbol)
   );
ALTER TABLE patstat.tls224_appln_cpc
OWNER TO patstat;  

CREATE TABLE patstat.tls225_docdb_fam_cpc
(
	docdb_family_id int NOT NULL DEFAULT ('0'),
	cpc_class_symbol varchar(19) NOT NULL DEFAULT (''),
	cpc_gener_auth char(2) NOT NULL DEFAULT (''),
	cpc_version date NOT NULL DEFAULT ('9999-12-31'),
	cpc_position char(1) NOT NULL DEFAULT (''),
	cpc_value char(1) NOT NULL DEFAULT (''),
	cpc_action_date date NOT NULL DEFAULT ('9999-12-31'),
	cpc_status char(1) NOT NULL DEFAULT (''),
	cpc_data_source char(1) NOT NULL DEFAULT (''),
	CONSTRAINT pk_tls225_docdb_fam_cpc PRIMARY KEY(docdb_family_id, cpc_class_symbol, cpc_gener_auth, cpc_version)
);
ALTER TABLE patstat.tls225_docdb_fam_cpc
OWNER TO patstat;  

CREATE TABLE patstat.tls226_person_orig
(
	person_orig_id int NOT NULL DEFAULT ('0'),
	person_id int NOT NULL DEFAULT ('0'),
	source char(5) NOT NULL DEFAULT (''),
	source_version character varying NOT NULL DEFAULT (''),
	name_freeform character varying NOT NULL DEFAULT (''),
	person_name_orig_lg character varying NOT NULL DEFAULT (''),
	last_name character varying NOT NULL DEFAULT (''),
	first_name character varying NOT NULL DEFAULT (''),
	middle_name character varying NOT NULL DEFAULT (''),
	address_freeform character varying NOT NULL DEFAULT (''),
	address_1 character varying NOT NULL DEFAULT (''),
	address_2 character varying NOT NULL DEFAULT (''),
	address_3 character varying NOT NULL DEFAULT (''),
	address_4 character varying NOT NULL DEFAULT (''),
	address_5 character varying NOT NULL DEFAULT (''),
	street character varying NOT NULL DEFAULT (''),
	city character varying NOT NULL DEFAULT (''),
  	zip_code character varying NOT NULL DEFAULT (''),
	state char(2) NOT NULL DEFAULT (''),
	person_ctry_code char(2) NOT NULL DEFAULT (''),
	residence_ctry_code char(2) NOT NULL DEFAULT (''),
	role varchar(2) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls226_person_orig PRIMARY KEY(person_orig_id)
   );
ALTER TABLE patstat.tls226_person_orig
OWNER TO patstat;

CREATE TABLE patstat.tls227_pers_publn
(
	person_id int NOT NULL DEFAULT ('0'),
	pat_publn_id int NOT NULL DEFAULT ('0'),
	applt_seq_nr smallint NOT NULL DEFAULT ('0'),
	invt_seq_nr smallint NOT NULL DEFAULT ('0'),
  CONSTRAINT pk_tls227_pers_publn PRIMARY KEY(person_id, pat_publn_id, applt_seq_nr, invt_seq_nr)
   );
ALTER TABLE patstat.tls227_pers_publn
OWNER TO patstat;

CREATE TABLE patstat.tls228_docdb_fam_citn
(
	docdb_family_id int NOT NULL DEFAULT ('0'),
	cited_docdb_family_id int NOT NULL DEFAULT ('0'),
  CONSTRAINT pk_tls228_docdb_fam_citn PRIMARY KEY(docdb_family_id, cited_docdb_family_id)
   );
ALTER TABLE patstat.tls228_docdb_fam_citn
OWNER TO patstat;

CREATE TABLE patstat.tls229_appln_nace2
(
	appln_id int NOT NULL DEFAULT ('0'),
	nace2_code varchar(5) NOT NULL DEFAULT (''),
	weight real NOT NULL DEFAULT (1),
  CONSTRAINT pk_tls229_appln_nace2 PRIMARY KEY(appln_id, nace2_code)
   );
ALTER TABLE patstat.tls229_appln_nace2
OWNER TO patstat;

CREATE TABLE patstat.tls230_appln_techn_field
(
	appln_id int NOT NULL DEFAULT ('0'),
	techn_field_nr smallint NOT NULL DEFAULT ('0'),
	weight real NOT NULL DEFAULT (1),
  CONSTRAINT pk_tls230_appln_techn_field PRIMARY KEY(appln_id, techn_field_nr)
   );
ALTER TABLE patstat.tls230_appln_techn_field
OWNER TO patstat;

CREATE TABLE patstat.tls231_inpadoc_legal_event
(
	event_id int NOT NULL DEFAULT '0',
	appln_id int NOT NULL DEFAULT '0',
	event_seq_nr smallint NOT NULL default '0',
	event_type char(3) NOT NULL DEFAULT ('	'),
	event_auth char(2) NOT NULL DEFAULT ('  '),
	event_code varchar(4)  NOT NULL DEFAULT (''),
	event_filing_date date NOT NULL DEFAULT ('9999-12-31'),
	event_publn_date date NOT NULL DEFAULT ('9999-12-31'),
	event_effective_date date NOT NULL DEFAULT ('9999-12-31'),
	event_text varchar(1000) NOT NULL DEFAULT (''),
	ref_doc_auth char(2) NOT NULL DEFAULT ('  '),
	ref_doc_nr varchar(20) NOT NULL DEFAULT (''),
	ref_doc_kind char(2) NOT NULL DEFAULT ('  '),
	ref_doc_date date NOT NULL DEFAULT ('9999-12-31'),
	ref_doc_text varchar(1000) NOT NULL DEFAULT (''),
	party_type varchar(3) NOT NULL DEFAULT ('	'),
	party_seq_nr smallint NOT NULL default '0',
	party_new varchar(1000) NOT NULL DEFAULT (''),
	party_old varchar(1000) NOT NULL DEFAULT (''),
	spc_nr varchar(40) NOT NULL DEFAULT (''),
	spc_filing_date date NOT NULL DEFAULT ('9999-12-31'),
	spc_patstat_expiry_date date NOT NULL DEFAULT ('9999-12-31'),
	spc_extension_date date NOT NULL DEFAULT ('9999-12-31'),
	spc_text varchar(1000) NOT NULL DEFAULT (''),
	designated_states varchar(1000) NOT NULL DEFAULT (''),
	extension_states varchar(30) NOT NULL DEFAULT (''),
	fee_country char(2) NOT NULL DEFAULT ('  '),
	fee_payment_date date NOT NULL DEFAULT ('9999-12-31'),
	fee_renewal_year smallint NOT NULL default '9999',
	fee_text varchar(1000) NOT NULL DEFAULT (''),
	lapse_country char(2) NOT NULL DEFAULT ('  '),
	lapse_date date NOT NULL DEFAULT ('9999-12-31'),
	lapse_text varchar(1000) NOT NULL DEFAULT (''),
	reinstate_country char(2) NOT NULL DEFAULT ('  '),
	reinstate_date date NOT NULL DEFAULT ('9999-12-31'),
	reinstate_text varchar(1000) NOT NULL DEFAULT (''),
	class_scheme varchar(4) NOT NULL DEFAULT (''),
	class_symbol varchar(50) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls231_inpadoc_legal_event PRIMARY KEY(event_id)
   );
ALTER TABLE patstat.tls231_inpadoc_legal_event
OWNER TO patstat;

CREATE TABLE patstat.tls801_country
(
	ctry_code char(2) NOT NULL DEFAULT (''),
	iso_alpha3 char(3) NOT NULL DEFAULT (''),
	st3_name varchar(100) NOT NULL DEFAULT (''),
	state_indicator char(1) NOT NULL DEFAULT (''),
	continent varchar(25) NOT NULL DEFAULT (''),
	eu_member char(1) NOT NULL DEFAULT (''),
	epo_member char(1) NOT NULL DEFAULT (''),
	oecd_member char(1) NOT NULL DEFAULT (''),
	discontinued char(1) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls801_country PRIMARY KEY(ctry_code)
   );
ALTER TABLE patstat.tls801_country
OWNER TO patstat;

CREATE TABLE patstat.tls803_legal_event_code
(
	event_auth char(2) NOT NULL DEFAULT (''),
	event_code varchar(4) NOT NULL DEFAULT (''),
	event_impact char(1) NOT NULL DEFAULT (''),
	event_descr varchar(250) NOT NULL DEFAULT (''),
	event_descr_orig varchar(250) NOT NULL DEFAULT (''),
	event_category_code char(1) NOT NULL DEFAULT (''),
	event_category_title varchar(100) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls803_legal_event_code PRIMARY KEY(event_auth, event_code)
   );
ALTER TABLE patstat.tls803_legal_event_code
OWNER TO patstat;

CREATE TABLE patstat.tls901_techn_field_ipc
(
	ipc_maingroup_symbol varchar(8) NOT NULL DEFAULT (''),
	techn_field_nr smallint NOT NULL DEFAULT ('0'),
	techn_sector varchar(50) NOT NULL DEFAULT (''),
	techn_field varchar(50) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls901_techn_field_ipc PRIMARY KEY(ipc_maingroup_symbol)
   );
ALTER TABLE patstat.tls901_techn_field_ipc
OWNER TO patstat;

CREATE TABLE patstat.tls902_ipc_nace2
(
	ipc varchar(8) NOT NULL DEFAULT (''),
	not_with_ipc varchar(8) NOT NULL DEFAULT (''),
	unless_with_ipc varchar(8) NOT NULL DEFAULT (''),
	nace2_code varchar(5) NOT NULL DEFAULT (''),
	nace2_weight smallint NOT NULL DEFAULT (1),
	nace2_descr varchar(150) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls902_ipc_nace2 PRIMARY KEY(ipc, not_with_ipc, unless_with_ipc, nace2_code)
   );
ALTER TABLE patstat.tls902_ipc_nace2
OWNER TO patstat;

CREATE TABLE patstat.tls904_nuts
(
	nuts varchar(5) NOT NULL DEFAULT (''),
	nuts_level smallint NOT NULL DEFAULT ('0'),
	nuts_label varchar(250) NOT NULL DEFAULT (''),
  CONSTRAINT pk_tls904_nuts PRIMARY KEY(nuts)
   );
ALTER TABLE patstat.tls904_nuts
OWNER TO patstat;


--index
create index tls201_appln_filing_date on patstat.tls201_appln using btree (appln_filing_date);
CREATE INDEX tls201_appln_inpadoc_family_id ON patstat.tls201_appln USING btree (inpadoc_family_id);
create index tls207_pers_appln_id on patstat.tls207_pers_appln using btree (appln_id);
