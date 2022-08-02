--liquibase formatted sql

--changeset herronrb:indicators1

create table tbl_filter_types (
	id_ numeric primary key,
	name_en text not null,
	name_es text not null
);

create table tbl_filter_options (
	id_ numeric primary key,
	type_id numeric not null references tbl_filter_types,
	name_en text not null,
	name_es text not null,
	sort_order numeric not null
);

create table tbl_sources (
	id_ numeric primary key,
	name_en text not null,
	name_es text not null,
	url_ text,
	trend_interval numeric
);

create table tbl_indicator_categories (
	id_ numeric primary key,
	name_en text not null,
	name_es text not null,
	sort_order numeric not null unique,
	parent_category_id numeric references tbl_indicator_categories
);

create table tbl_indicator_types (
	id_ numeric primary key,
	name_ text not null
);

create table tbl_indicators (
	id_ numeric primary key,
	indicator_category_id numeric not null references tbl_indicator_categories,
	indicator_type_id numeric not null references tbl_indicator_types,
	name_en text not null,
	name_es text not null,
	description_en text not null,
	description_es text not null,
	base_filter_type_id numeric references tbl_filter_types,
	source_id numeric references tbl_sources,
	featured boolean default false
);

create table tbl_indicator_values (
	indicator_id numeric not null references tbl_indicators,
	year_ text not null,
	location_id text not null,
	location_type_id numeric not null,
	indicator_value numeric,
	moe_low numeric,
	moe_high numeric,
	universe_value numeric,
	race_id numeric references tbl_filter_options,
	age_id numeric references tbl_filter_options,
	sex_id numeric references tbl_filter_options,
	education_id numeric references tbl_filter_options,
	income_id numeric references tbl_filter_options,
	suppressed smallint default 0 check (suppressed in (0, 1)),
	foreign key(location_id, location_type_id) references tbl_locations(id_, location_type_id)
);
create unique index idx_indicator_values on tbl_indicator_values (indicator_id, year_, location_id, location_type_id, race_id, age_id, sex_id, education_id, income_id);

insert into tbl_filter_types(id_, name_en, name_es)
values (1, 'Race or Ethnicity', 'Race or Ethnicity (es)'),
(2, 'Age', 'Age (es)'),
(3, 'Sex', 'Sex (es)'),
(4, 'Education Level', 'Education Level (es)'),
(5, 'Income Level', 'Income Level (es)');

insert into tbl_filter_options (id_, type_id, name_en, name_es, sort_order) values
(100, 1, 'American Indian or Alaska Native', 'American Indian or Alaska Native (es)', 1),
(101, 1, 'Asian', 'Asian (es)', 2),
(102, 1, 'Black or African American', 'Black or African American (es)', 3),
(103, 1, 'Hispanic or Latino', 'Hispanic or Latino (es)', 4),
(104, 1, 'Native Hawaiian and Other Pacific Islander', 'Native Hawaiian and Other Pacific Islander (es)', 5),
(105, 1, 'Other Race', 'Other Race (es)', 6),
(106, 1, 'Two or more races', 'Two or more races (es)', 7),
(107, 1, 'White, not Hispanic or Latino', 'White, not Hispanic or Latino (es)', 8),
(200, 2, 'Female', 'Female (es)', 1),
(201, 2, 'Male', 'Male (es)', 2),
(300, 3, 'Under 5 years', 'Under 5 years (es)', 1),
(301, 3, '5 to 9 years', '5 to 9 years (es)', 2),
(302, 3, '10 to 14 years', '10 to 14 years (es)', 3),
(303, 3, '15 to 17 years', '15 to 17 years (es)', 4),
(304, 3, '18 and 19 years', '18 and 19 years (es)', 5),
(305, 3, '20 to 24 years', '20 to 24 years (es)', 6),
(306, 3, '25 to 29 years', '25 to 29 years (es)', 7),
(307, 3, '30 to 34 years', '30 to 34 years (es)', 8),
(308, 3, '35 to 44 years', '35 to 44 years (es)', 9),
(309, 3, '45 to 54 years', '45 to 54 years (es)', 10),
(310, 3, '55 to 64 years', '55 to 64 years (es)', 11),
(311, 3, '65 to 74 years', '65 to 74 years (es)', 12),
(312, 3, '75 to 84 years', '75 to 84 years (es)', 13),
(313, 3, '85 years and over', '85 years and over (es)', 14),
(400, 4, 'Less than high school graduate', 'Less than high school graduate (es)', 1),
(401, 4, 'High school graduate (includes equivalency)', 'High school graduate (includes equivalency) (es)', 2),
(402, 4, 'Some college or associate''s degree', 'Some college or associate''s degree (es)', 3),
(403, 4, 'Bachelor''s degree', 'Bachelor''s degree (es)', 4),
(404, 4, 'Graduate or professional degree', 'Graduate or professional degree (es)', 5),
(405, 4, 'Bachelor''s degree or higher', 'Bachelor''s degree or higher (es)', 6),
(500, 5, 'Below poverty level', 'Below poverty level (es)', 1),
(501, 5, 'Less than 200 percent poverty', 'Less than 200 percent poverty (es)', 2),
(502, 5, 'Less than 300 percent poverty', 'Less than 300 percent poverty (es)', 3);

insert into tbl_sources (id_, name_en, name_es, url_, trend_interval) 
values (1, 'ACS 5-year', ' (es)', null, 5),
	(2, 'BCAD', 'BCAD (es)', null, null),
	(3, 'Bexar County Elections', 'Bexar County Elections (es)', null, null),
	(4, 'Bexar County Juvenile Probation Dept.', 'Bexar County Juvenile Probation Dept. (es)', null, null),
	(5, 'CDC', 'CDC (es)', null, null),
	(6, 'COSA', 'COSA (es)', null, null),
	(7, 'COSA NHSD', 'COSA NHSD (es)', null, null),
	(8, 'Decennial Census', 'Decennial Census (es)', null, null),
	(9, 'EDI', 'EDI (es)', null, null),
	(10, 'EPA NATA', 'EPA NATA (es)', null, null),
	(11, 'FBI UCR', 'FBI UCR (es)', null, null),
	(12, 'HASA', 'HASA (es)', null, null),
	(13, 'HHS', 'HHS (es)', null, null),
	(14, 'HUD', 'HUD (es)', null, null),
	(15, 'LEHD', 'LEHD (es)', null, null),
	(16, 'National Vital Statistics Report', 'National Vital Statistics Report (es)', null, null),
	(17, 'Natl Housing Preservation DB', 'Natl Housing Preservation DB (es)', null, null),
	(18, 'PLACES', 'PLACES (es)', null, null),
	(19, 'San Antonio Metro Health', 'San Antonio Metro Health (es)', null, null),
	(20, 'SAPD', 'SAPD (es)', null, null),
	(21, 'TDFPS', 'TDFPS (es)', null, null),
	(22, 'TDPS', 'TDPS (es)', null, null),
	(23, 'TDSHS', 'TDSHS (es)', null, null),
	(24, 'THCIC Hospital Discharge PUDF', 'THCIC Hospital Discharge PUDF (es)', null, null),
	(25, 'United Way of San Antonio and Bexar County', 'United Way of San Antonio and Bexar County (es)', null, null),
	(26, 'US Census', 'US Census (es)', null, null),
	(27, 'USDA Food Atlas', 'USDA Food Atlas (es)', null, null);

insert into tbl_indicator_categories (id_, name_en, name_es, sort_order, parent_category_id)
values (1, 'Civic & social', 'Civic & social (es)', 1, null),
(2, 'Criminal justice', 'Criminal justice (es)', 2, null),
(3, 'Demographic', 'Demographic (es)', 3, null),
(4, 'Economic', 'Economic (es)', 4, null),
(5, 'Education', 'Education (es)', 5, null),
(6, 'Environment', 'Environment (es)', 6, null),
(7, 'Health', 'Health (es)', 7, null),
(8, 'Housing', 'Housing (es)', 8, null),
(9, 'Age Group', 'Age Group (es)', 9, 3),
(10, 'Race/Ethnicity', 'Race/Ethnicity (es)', 10, 3),
(11, 'Sex', 'Sex (es)', 11, 3);

insert into tbl_indicator_types (id_, name_)
values (1, 'Count'), (2, 'Rate'), (3, 'Percent'), (4, 'Currency');

insert into tbl_indicators (id_, indicator_category_id, indicator_type_id, source_id, name_en, name_es, description_en, description_es)
values (1, 1, 3, 26, '2020 Census response rate', '2020 Census response rate (es)', '[description]...', '[description]...(es)'),
	(2, 1, 3, 18, 'Adequate social-emotional support', 'Adequate social-emotional support (es)', '[description]...', '[description]...(es)'),
	(3, 1, 3, 3, 'Voter registration', 'Voter registration (es)', '[description]...', '[description]...(es)'),
	(4, 1, 3, 3, 'Voter turnout', 'Voter turnout (es)', '[description]...', '[description]...(es)'),
	(5, 2, 3, 2, 'Absentee property owners with two or more property maintenance violations within a 12-month period', 'Absentee property owners with two or more property maintenance violations within a 12-month period (es)', '[description]...', '[description]...(es)'),
	(6, 2, 2, 22, 'Aggravated assaults per 100K', 'Aggravated assaults per 100K (es)', '[description]...', '[description]...(es)'),
	(7, 2, 2, 22, 'Burglaries per 100K', 'Burglaries per 100K (es)', '[description]...', '[description]...(es)'),
	(8, 2, 2, 21, 'Child abuse prevalence (intakes)', 'Child abuse prevalence (intakes) (es)', '[description]...', '[description]...(es)'),
	(9, 2, 2, 21, 'Child abuse prevalence (confirmed victims)', 'Child abuse prevalence (confirmed victims) (es)', '[description]...', '[description]...(es)'),
	(10, 2, 2, 21, 'Child abuse prevalence (revictimized)', 'Child abuse prevalence (revictimized) (es)', '[description]...', '[description]...(es)'),
	(11, 2, 2, 20, 'Drug-related arrest rate', 'Drug-related arrest rate (es)', '[description]...', '[description]...(es)'),
	(12, 2, 2, 22, 'Family violence rate', 'Family violence rate (es)', '[description]...', '[description]...(es)'),
	(13, 2, 2, 22, 'Homicide and manslaughter rate', 'Homicide and manslaughter rate (es)', '[description]...', '[description]...(es)'),
	(14, 2, 2, 4, 'Juvenile probation rate', 'Juvenile probation rate (es)', '[description]...', '[description]...(es)'),
	(15, 2, 3, 8, 'Incarcerated as of 2020 Census', 'Incarcerated as of 2020 Census (es)', '[description]...', '[description]...(es)'),
	(16, 2, 2, 20, 'Property crime rate', 'Property crime rate (es)', '[description]...', '[description]...(es)'),
	(17, 2, 2, 11, 'Reported hate crime offense rate', 'Reported hate crime offense rate (es)', '[description]...', '[description]...(es)'),
	(18, 2, 2, 20, 'Sexual assault rate', 'Sexual assault rate (es)', '[description]...', '[description]...(es)'),
	(19, 2, 2, 20, 'Arrest rate', 'Arrest rate (es)', '[description]...', '[description]...(es)'),
	(20, 2, 2, 20, 'Violent crime rate', 'Violent crime rate (es)', '[description]...', '[description]...(es)'),
	(21, 9, 3, 1, 'Under 5', 'Under 5 (es)', '[description]...', '[description]...(es)'),
	(22, 9, 3, 1, '5 to 17', '5 to 17 (es)', '[description]...', '[description]...(es)'),
	(23, 9, 3, 1, '18 to 34', '18 to 34 (es)', '[description]...', '[description]...(es)'),
	(24, 9, 3, 1, '35 to 64', '35 to 64 (es)', '[description]...', '[description]...(es)'),
	(25, 9, 3, 1, '65 and Older', '65 and Older (es)', '[description]...', '[description]...(es)'),
	(26, 3, 3, 1, 'Limited English proficiency', 'Limited English proficiency (es)', '[description]...', '[description]...(es)'),
	(27, 3, 3, 1, 'Increase in population in past 10 years', 'Increase in population in past 10 years (es)', '[description]...', '[description]...(es)'),
	(28, 3, 3, 1, 'Households that are multigenerational', 'Households that are multigenerational (es)', '[description]...', '[description]...(es)'),
	(29, 10, 3, 1, 'American Indian or Alaska Native (non-Hispanic)', 'American Indian or Alaska Native (non-Hispanic) (es)', '[description]...', '[description]...(es)'),
	(30, 10, 3, 1, 'Asian (non-Hispanic)', 'Asian (non-Hispanic) (es)', '[description]...', '[description]...(es)'),
	(31, 10, 3, 1, 'Black or African American (non-Hispanic)', 'Black or African American (non-Hispanic) (es)', '[description]...', '[description]...(es)'),
	(32, 10, 3, 1, 'Hispanic or Latino', 'Hispanic or Latino (es)', '[description]...', '[description]...(es)'),
	(33, 10, 3, 1, 'Native Hawaiian or Pacific Islander (non-Hispanic)', 'Native Hawaiian or Pacific Islander (non-Hispanic) (es)', '[description]...', '[description]...(es)'),
	(34, 10, 3, 1, 'Other Race (non-Hispanic)', 'Other Race (non-Hispanic) (es)', '[description]...', '[description]...(es)'),
	(35, 10, 3, 1, 'Two or More Races (non-Hispanic)', 'Two or More Races (non-Hispanic) (es)', '[description]...', '[description]...(es)'),
	(36, 10, 3, 1, 'White (non-Hispanic)', 'White (non-Hispanic) (es)', '[description]...', '[description]...(es)'),
	(37, 3, 3, 1, 'Racial/ethnic diversity (Theil index)', 'Racial/ethnic diversity (Theil index) (es)', '[description]...', '[description]...(es)'),
	(38, 11, 3, 1, 'Male', 'Male (es)', '[description]...', '[description]...(es)'),
	(39, 11, 3, 1, 'Female', 'Female (es)', '[description]...', '[description]...(es)'),
	(40, 3, 3, 1, 'Speak Spanish or Spanish Creole at home', 'Speak Spanish or Spanish Creole at home (es)', '[description]...', '[description]...(es)'),
	(41, 3, 3, 1, 'Veteran population', 'Veteran population (es)', '[description]...', '[description]...(es)'),
	(42, 4, 2, 14, 'Access to loans and capital', 'Access to loans and capital (es)', '[description]...', '[description]...(es)'),
	(43, 4, 3, 25, 'ALICE households', 'ALICE households (es)', '[description]...', '[description]...(es)'),
	(44, 4, 3, 14, 'Assistance (food, rent assistance)', 'Assistance (food, rent assistance) (es)', '[description]...', '[description]...(es)'),
	(45, 4, 2, 13, 'Child care capacity per 1K kids (measure tbd)', 'Child care capacity per 1K kids (measure tbd) (es)', '[description]...', '[description]...(es)'),
	(46, 4, 3, 1, 'Computer and broadband Subscription', 'Computer and broadband Subscription (es)', '[description]...', '[description]...(es)'),
	(47, 4, 3, 1, 'Employed', 'Employed (es)', '[description]...', '[description]...(es)'),
	(48, 4, 3, 1, 'Unemployed', 'Unemployed (es)', '[description]...', '[description]...(es)'),
	(49, 4, 3, 1, 'Not in labor force and not employed', 'Not in labor force and not employed (es)', '[description]...', '[description]...(es)'),
	(50, 4, 3, 1, 'Home ownership', 'Home ownership (es)', '[description]...', '[description]...(es)'),
	(51, 4, 3, 1, 'Housing cost burden', 'Housing cost burden (es)', '[description]...', '[description]...(es)'),
	(52, 4, 3, 1, 'Owner Occupied Housing cost burden', 'Owner Occupied Housing cost burden (es)', '[description]...', '[description]...(es)'),
	(53, 4, 3, 1, 'Renter Occupied Housing cost burden', 'Housing cost burden (es)', '[description]...', '[description]...(es)'),
	(54, 4, 2, 1, 'Income inequality (Gini Index)', 'Renter Occupied Housing cost burden (es)', '[description]...', '[description]...(es)'),
	(55, 4, 2, 15, 'Jobs per population', 'Jobs per population (es)', '[description]...', '[description]...(es)'),
	(56, 4, 4, 1, 'Family Income (median)', 'Family Income (median) (es)', '[description]...', '[description]...(es)'),
	(57, 4, 4, 1, 'Household Income (median)', 'Household Income (median) (es)', '[description]...', '[description]...(es)'),
	(58, 4, 4, 15, 'Monthly Earnings', 'Monthly Earnings (es)', '[description]...', '[description]...(es)'),
	(59, 4, 3, 1, 'Households with income <30% AMI', 'Households with income <30% AMI (es)', '[description]...', '[description]...(es)'),
	(60, 4, 3, 1, 'Households with income <60% AMI', 'Households with income <60% AMI (es)', '[description]...', '[description]...(es)'),
	(61, 4, 3, 1, 'Households with income <80% AMI', 'Households with income <80% AMI (es)', '[description]...', '[description]...(es)'),
	(62, 4, 3, 1, 'Population in Armed Forces', 'Population in Armed Forces (es)', '[description]...', '[description]...(es)'),
	(63, 4, 3, 1, 'Income below poverty', 'Income below poverty (es)', '[description]...', '[description]...(es)'),
	(64, 4, 2, 7, 'Rental assistance', 'Rental assistance (es)', '[description]...', '[description]...(es)'),
	(65, 4, 3, 1, 'Supplemental Security Income (SSI)', 'Supplemental Security Income (SSI) (es)', '[description]...', '[description]...(es)'),
	(66, 4, 3, 1, 'Uninsured', 'Uninsured (es)', '[description]...', '[description]...(es)'),
	(67, 4, 3, 1, 'Youth not in school or not working', 'Youth not in school or not working (es)', '[description]...', '[description]...(es)'),
	(68, 4, 2, 14, 'Low Transportation Cost Index', 'Low Transportation Cost Index (es)', '[description]...', '[description]...(es)'),
	(69, 5, 3, 1, 'Education less than high school diploma/GED', 'Education less than high school diploma/GED (es)', '[description]...', '[description]...(es)'),
	(70, 5, 3, 1, 'Education Bachelor''s degree or higher', 'Education Bachelor''s degree or higher (es)', '[description]...', '[description]...(es)'),
	(71, 5, 3, 1, 'Enrolled in preschool', 'Enrolled in preschool (es)', '[description]...', '[description]...(es)'),
	(72, 5, 3, 13, 'Children in high-quality pre-K or daycare', 'Children in high-quality pre-K or daycare (es)', '[description]...', '[description]...(es)'),
	(73, 5, 3, 9, 'Children scoring "Vulnerable" on kinder-readiness', 'Children scoring "Vulnerable" on kinder-readiness (es)', '[description]...', '[description]...(es)'),
	(74, 6, 2, 6, 'Access to parks and greenspace', 'Access to parks and greenspace (es)', '[description]...', '[description]...(es)'),
	(75, 6, 2, 10, 'Air toxins cancer risk index', 'Air toxins cancer risk index (es)', '[description]...', '[description]...(es)'),
	(76, 6, 2, 14, 'Environmental health hazard index', 'Environmental health hazard index (es)', '[description]...', '[description]...(es)'),
	(77, 6, 3, 27, 'Food insecurity/food deserts', 'Food insecurity/food deserts (es)', '[description]...', '[description]...(es)'),
	(78, 7, 3, 18, 'Sleeping less than seven hours among adults', 'Sleeping less than seven hours among adults (es)', '[description]...', '[description]...(es)'),
	(79, 7, 3, 18, 'Cholesterol screening among adults', 'Cholesterol screening among adults (es)', '[description]...', '[description]...(es)'),
	(80, 7, 3, 19, 'COVID-19 vaccination rates', 'COVID-19 vaccination rates (es)', '[description]...', '[description]...(es)'),
	(81, 7, 3, 18, 'Obesity among adults', 'Obesity among adults (es)', '[description]...', '[description]...(es)'),
	(82, 7, 3, 18, 'Older adults aged 65 years and older who are up to date on a core set of clinical preventive services', 'Older adults aged 65 years and older who are up to date on a core set of clinical preventive services (es)', '[description]...', '[description]...(es)'),
	(83, 7, 2, 23, 'Opioid prescription rate', 'Opioid prescription rate (es)', '[description]...', '[description]...(es)'),
	(84, 7, 3, 18, 'Cervical cancer Pap screening among adult women aged 21-65 years', 'Cervical cancer Pap screening among adult women aged 21-65 years (es)', '[description]...', '[description]...(es)'),
	(85, 7, 3, 18, 'Current smoking among adults', 'Current smoking among adults (es)', '[description]...', '[description]...(es)'),
	(86, 7, 3, 19, 'Prenatal care', 'Prenatal care (es)', '[description]...', '[description]...(es)'),
	(87, 7, 3, 18, 'Visits to dentist or dental clinic among adults', 'Visits to dentist or dental clinic among adults (es)', '[description]...', '[description]...(es)'),
	(88, 7, 3, 18, 'Visits to doctor for routine checkup within the past year among adults', 'Visits to doctor for routine checkup within the past year among adults (es)', '[description]...', '[description]...(es)'),
	(89, 7, 2, 12, 'Asthma hospitalization rate', 'Asthma hospitalization rate (es)', '[description]...', '[description]...(es)'),
	(90, 7, 2, 19, 'Birth rates', 'Birth rates (es)', '[description]...', '[description]...(es)'),
	(91, 7, 3, 18, 'Coronary heart disease among adults', 'Coronary heart disease among adults (es)', '[description]...', '[description]...(es)'),
	(92, 7, 2, 19, 'COVID-19 case rate', 'COVID-19 case rate (es)', '[description]...', '[description]...(es)'),
	(93, 7, 2, 19, 'COVID-19 death rate', 'COVID-19 death rate (es)', '[description]...', '[description]...(es)'),
	(94, 7, 2, 23, 'Death rate by age', 'Death rate by age (es)', '[description]...', '[description]...(es)'),
	(95, 7, 2, 12, 'Diabetes hospitalization rate', 'Diabetes hospitalization rate (es)', '[description]...', '[description]...(es)'),
	(96, 7, 3, 18, 'Diabetes among adults', 'Diabetes among adults (es)', '[description]...', '[description]...(es)'),
	(97, 7, 1, 1, 'Disability status', 'Disability status (es)', '[description]...', '[description]...(es)'),
	(98, 7, 2, 24, 'Hypertension hospitalization rate', 'Hypertension hospitalization rate (es)', '[description]...', '[description]...(es)'),
	(99, 7, 2, 24, 'Injury hospitalization rate', 'Injury hospitalization rate (es)', '[description]...', '[description]...(es)'),
	(100, 7, 2, 5, 'Invasive cancer incidence rate', 'Invasive cancer incidence rate (es)', '[description]...', '[description]...(es)'),
	(101, 7, 2, 23, 'Lead poisoning/elevated blood lead', 'Lead poisoning/elevated blood lead (es)', '[description]...', '[description]...(es)'),
	(102, 7, 2, 16, 'Life expectancy (average)', 'Life expectancy (average) (es)', '[description]...', '[description]...(es)'),
	(103, 7, 2, 24, 'Mental health hospitalization rate', 'Mental health hospitalization rate (es)', '[description]...', '[description]...(es)'),
	(104, 7, 3, 18, 'Mental health not good for >=14 days among adults', 'Mental health not good for >=14 days among adults (es)', '[description]...', '[description]...(es)'),
	(105, 7, 3, 18, 'Physical health not good for >=14 days among adults', 'Physical health not good for >=14 days among adults (es)', '[description]...', '[description]...(es)'),
	(106, 7, 3, 18, 'Stroke among adults', 'Stroke among adults (es)', '[description]...', '[description]...(es)'),
	(107, 8, 3, 1, 'Change in total housing units (10-year change)', 'Change in total housing units (10-year change) (es)', '[description]...', '[description]...(es)'),
	(108, 8, 3, 1, 'Multi-family housing units', 'Multi-family housing units (es)', '[description]...', '[description]...(es)'),
	(109, 8, 3, 17, 'Housing units subsidized', 'Housing units subsidized (es)', '[description]...', '[description]...(es)'),
	(110, 8, 3, 2, 'Residential buildings in fair or poor condition', 'Residential buildings in fair or poor condition (es)', '[description]...', '[description]...(es)'),
	(111, 8, 3, 1, 'Renter housing stability (moved in past year)', 'Renter housing stability (moved in past year) (es)', '[description]...', '[description]...(es)'),
	(112, 8, 3, 1, 'Vacant housing units', 'Vacant housing units (es)', '[description]...', '[description]...(es)');


