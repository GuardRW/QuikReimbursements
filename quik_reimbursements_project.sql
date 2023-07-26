-- Start of TCSS 455 project SQL Script
/* ********************************
Project Phase II
Group QuikReimbursements (MySQL)
This SQL Script was tested on MySQL. 
To run, create a database called QuikReimbursements:
create database QuikReimbursements;
then select the database and run this script.
********************************
*/

-- TABLE TO STORE REIMBURSEMENT TYPES
-- LIKE FOOD, TRAVEL, LODGING, CATERING, RELOCATION, ETC
CREATE TABLE reimbursement_type (
  type_id int(11) NOT NULL,
  type_name varchar(25) NOT NULL,
  PRIMARY KEY (type_id)
);
-- TABLE TO STORE REIMBURSEMENT STATUS
CREATE TABLE reimbursement_status (
  status_id int(11) NOT NULL,
  status_name varchar(25) NOT NULL,
  PRIMARY KEY (status_id),
  CHECK(status_name = 'PENDING' or status_name = 'APPROVED' or status_name = 'DENIED')
);

-- TABLE TO STORE EMPLOYEE ROLE OR TITLE LIKE
-- Manager, Developer, Assistant, CEO, etc
CREATE TABLE employee_roles (
  role_id int(11) NOT NULL,
  role_name varchar(25) NOT NULL,
  can_approve boolean NOT NULL,
  PRIMARY KEY (role_id)
);
-- TABLE TO STORE COMPANY DEPARTMENTS LIKE
-- Marketing, Finance, Operations management, Human Resource, IT, etc
CREATE TABLE departments(
	department_id int(11) NOT NULL AUTO_INCREMENT,
    name varchar(25) NOT NULL,
	PRIMARY KEY (department_id)
);

-- TABLE TO STORE COMPANY DETAILS
CREATE TABLE company(
	company_id int(11) NOT NULL AUTO_INCREMENT,
	name varchar(25) NOT NULL,
    company_type varchar(15) NOT NULL,
    city varchar(12) NOT NULL,
    State varchar(2) NOT NULL,
    zip varchar(5) NOT NULL,
    PRIMARY KEY (company_id)
);
-- TABLE TO STORE COMPANY EMPLOYEES
CREATE TABLE employees (
  employee_id int(11) NOT NULL AUTO_INCREMENT,
  company_id int(11) NOT NULL,
  department_id int(11) NOT NULL,
  email varchar(25) NOT NULL,
  first_name varchar(10) NOT NULL,
  last_name varchar(10) NOT NULL,
  user_name varchar(10) NOT NULL,
  password varchar(10) NOT NULL,
  role_id int(11) NOT NULL,
  PRIMARY KEY (employee_id),
  UNIQUE KEY (user_name),
  FOREIGN KEY (role_id) REFERENCES employee_roles (role_id),
  FOREIGN KEY (company_id) REFERENCES company (company_id),
  FOREIGN KEY (department_id) REFERENCES departments (department_id)
);

-- TABLE TO STORE REIMBURSEMENT REQUESTS
CREATE TABLE reimbursement (
  reimbursement_id int(11) NOT NULL AUTO_INCREMENT,
  amount double NOT NULL,
  description varchar(250) NOT NULL,
  receipt varchar(150) DEFAULT NULL,
  resolved date DEFAULT NULL,
  submitted date NOT NULL,
  author_id int(11) NOT NULL,
  status_id int(11) NOT NULL,
  type_id int(11) NOT NULL,
  resolver_id int(11) DEFAULT NULL,
  PRIMARY KEY (reimbursement_id),  
  FOREIGN KEY (type_id) REFERENCES reimbursement_type (type_id),
  FOREIGN KEY (status_id) REFERENCES reimbursement_status (status_id),
  FOREIGN KEY (resolver_id) REFERENCES employees (employee_id),
  FOREIGN KEY (author_id) REFERENCES employees (employee_id)
);

-- PART B

INSERT INTO reimbursement_status (status_id, status_name) values (1, 'PENDING');
INSERT INTO reimbursement_status (status_id, status_name) values (2, 'APPROVED');
INSERT INTO reimbursement_status (status_id, status_name) values (3, 'DENIED');
