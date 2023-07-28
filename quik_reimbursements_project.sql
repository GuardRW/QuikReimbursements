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
  type_id int(36) NOT NULL,
  type_name varchar(120) NOT NULL,
  PRIMARY KEY (type_id)
);
-- TABLE TO STORE REIMBURSEMENT STATUS
CREATE TABLE reimbursement_status (
  status_id int(36) NOT NULL,
  status_name varchar(120) NOT NULL,
  PRIMARY KEY (status_id),
  CHECK(status_name = 'PENDING' or status_name = 'APPROVED' or status_name = 'DENIED')
);

-- TABLE TO STORE EMPLOYEE ROLE OR TITLE LIKE
-- Manager, Developer, Assistant, CEO, etc
CREATE TABLE employee_roles (
  role_id int(36) NOT NULL,
  role_name varchar(120) NOT NULL,
  can_approve boolean NOT NULL,
  PRIMARY KEY (role_id)
);
-- TABLE TO STORE COMPANY DEPARTMENTS LIKE
-- Marketing, Finance, Operations management, Human Resource, IT, etc
CREATE TABLE departments(
	department_id int(11) NOT NULL AUTO_INCREMENT,
    name varchar(120) NOT NULL,
	PRIMARY KEY (department_id)
);

-- TABLE TO STORE COMPANY DETAILS
CREATE TABLE company(
	company_id int(36) NOT NULL AUTO_INCREMENT,
	name varchar(120) NOT NULL,
    company_type varchar(36) NOT NULL,
    city varchar(120) NOT NULL,
    State varchar(120) NOT NULL,
    zip varchar(120) NOT NULL,
    PRIMARY KEY (company_id)
);
-- TABLE TO STORE COMPANY EMPLOYEES
CREATE TABLE employees (
  employee_id int(36) NOT NULL AUTO_INCREMENT,
  company_id int(36) NOT NULL,
  department_id int(36) NOT NULL,
  email varchar(120) NOT NULL,
  first_name varchar(120) NOT NULL,
  last_name varchar(120) NOT NULL,
  user_name varchar(120) NOT NULL,
  password varchar(120) NOT NULL,
  role_id int(36) NOT NULL,
  PRIMARY KEY (employee_id),
  UNIQUE KEY (user_name),
  FOREIGN KEY (role_id) REFERENCES employee_roles (role_id),
  FOREIGN KEY (company_id) REFERENCES company (company_id),
  FOREIGN KEY (department_id) REFERENCES departments (department_id)
);

-- TABLE TO STORE REIMBURSEMENT REQUESTS
CREATE TABLE reimbursement (
  reimbursement_id int(36) NOT NULL AUTO_INCREMENT,
  amount double NOT NULL,
  description varchar(250) NOT NULL,
  receipt varchar(150) DEFAULT NULL,
  resolved date DEFAULT NULL,
  submitted date NOT NULL,
  author_id int(36) NOT NULL,
  status_id int(36) NOT NULL,
  type_id int(36) NOT NULL,
  resolver_id int(36) DEFAULT NULL,
  PRIMARY KEY (reimbursement_id),  
  FOREIGN KEY (type_id) REFERENCES reimbursement_type (type_id),
  FOREIGN KEY (status_id) REFERENCES reimbursement_status (status_id),
  FOREIGN KEY (resolver_id) REFERENCES employees (employee_id),
  FOREIGN KEY (author_id) REFERENCES employees (employee_id)
);

-- PART B

INSERT INTO reimbursement_type (type_id, type_name) VALUES
(1, 'Food'),
(2, 'Travel'),
(3, 'Lodging'),
(4, 'Catering'),
(5, 'Relocation'),
(6, 'Entertainment'),
(7, 'Office Supplies'),
(8, 'Training'),
(9, 'Miscellaneous'),
(10, 'Transportation');

INSERT INTO reimbursement_status (status_id, status_name) VALUES
(1, 'PENDING'),
(2, 'APPROVED'),
(3, 'DENIED'),
(4, 'PENDING'),
(5, 'APPROVED'),
(6, 'DENIED'),
(7, 'PENDING'),
(8, 'APPROVED'),
(9, 'DENIED'),
(10, 'PENDING');

INSERT INTO employee_roles (role_id, role_name, can_approve) VALUES
(1, 'Manager', TRUE),
(2, 'Developer', TRUE),
(3, 'Assistant', FALSE),
(4, 'CEO', TRUE),
(5, 'HR Manager', TRUE),
(6, 'Accountant', FALSE),
(7, 'Designer', FALSE),
(8, 'Project Manager', TRUE),
(9, 'Sales Executive', FALSE),
(10, 'IT Specialist', TRUE);

INSERT INTO departments (department_id, name) VALUES
(1, 'Marketing'),
(2, 'Finance'),
(3, 'Operations Management'),
(4, 'Human Resource'),
(5, 'IT'),
(6, 'Sales'),
(7, 'Customer Support'),
(8, 'Research and Development'),
(9, 'Production'),
(10, 'Quality Assurance');

INSERT INTO company (company_id, name, company_type, city, State, zip) VALUES
(1, 'ABC Corporation', 'Public', 'New York', 'NY', '10001'),
(2, 'XYZ Tech Solutions', 'Private', 'San Francisco', 'CA', '94105'),
(3, 'Tech Innovators Inc.', 'Public', 'Seattle', 'WA', '98101'),
(4, 'Global Services Ltd.', 'Private', 'London', 'UK', 'SW1A 1AA'),
(5, 'TechGuru Enterprises', 'Public', 'Bangalore', 'KA', '560001'),
(6, 'Innovative Systems', 'Private', 'Berlin', 'BE', '10115'),
(7, 'Sunrise Technologies', 'Public', 'Sydney', 'NSW', '2000'),
(8, 'MegaCorp Inc.', 'Public', 'Chicago', 'IL', '60601'),
(9, 'Digital Solutions Ltd.', 'Private', 'Tokyo', 'JP', '100-0001'),
(10, 'DataTech Group', 'Public', 'Toronto', 'ON', 'M5H 1W7');

INSERT INTO employees (employee_id, company_id, department_id, email, first_name, last_name, user_name, password, role_id) VALUES
(1, 1, 1, 'john.doe@abc.com', 'John', 'Doe', 'johndoe', 'pass123', 1),
(2, 1, 2, 'jane.smith@abc.com', 'Jane', 'Smith', 'janesmith', 'abc456', 2),
(3, 2, 3, 'mike.johnson@xyz.com', 'Mike', 'Johnson', 'mikej', 'mikepass', 1),
(4, 2, 4, 'susan.wilson@xyz.com', 'Susan', 'Wilson', 'susiew', 'pass456', 3),
(5, 3, 5, 'chris.jackson@tech.com', 'Chris', 'Jackson', 'cjackson', 'tech2023', 4),
(6, 3, 6, 'laura.lee@tech.com', 'Laura', 'Lee', 'lauralee', 'lee123', 2),
(7, 4, 7, 'alex.green@globalservices.com', 'Alex', 'Green', 'alexg', 'green123', 1),
(8, 4, 8, 'ryan.brown@globalservices.com', 'Ryan', 'Brown', 'ryanb', 'rbrown456', 5),
(9, 5, 9, 'jessica.white@techguru.com', 'Jessica', 'White', 'jesswhite', 'jw123', 1),
(10, 5, 10, 'david.smith@techguru.com', 'David', 'Smith', 'davids', 'dave456', 2);

INSERT INTO reimbursement (reimbursement_id, amount, description, receipt, resolved, submitted, author_id, status_id, type_id, resolver_id) VALUES
(1, 50.00, 'Lunch meeting with clients', 'receipts/lunch_receipt.jpg', '2023-07-15', '2023-07-10', 1, 2, 1, 7),
(2, 250.00, 'Flight tickets for conference', 'receipts/flight_receipt.pdf', NULL, '2023-06-20', 3, 1, 2, NULL),
(3, 120.00, 'Hotel accommodation for business trip', 'receipts/hotel_receipt.png', '2023-06-25', '2023-06-18', 6, 2, 3, 1),
(4, 75.50, 'Team lunch expenses', 'receipts/team_lunch_receipt.jpg', NULL, '2023-07-05', 2, 1, 1, NULL),
(5, 300.00, 'Moving expenses', 'receipts/moving_receipt.pdf', NULL, '2023-07-01', 8, 3, 5, 4),
(6, 50.00, 'Office supplies purchase', 'receipts/office_supplies_receipt.jpg', NULL, '2023-07-12', 4, 2, 7, 3),
(7, 100.00, 'Training course fees', 'receipts/training_receipt.pdf', '2023-07-28', '2023-07-15', 9, 2, 8, 6),
(8, 25.00, 'Taxi fare for client meeting', 'receipts/taxi_receipt.jpg', NULL, '2023-07-08', 5, 1, 10, NULL),
(9, 80.00, 'Dinner expenses during business trip', 'receipts/dinner_receipt.png', NULL, '2023-07-18', 10, 2, 1, NULL),
(10, 40.00, 'Public transportation costs', 'receipts/transport_receipt.jpg', '2023-07-30', '2023-07-25', 7, 2, 10, 2);

