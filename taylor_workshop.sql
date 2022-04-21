-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'week1_workshop' AND pid <> pg_backend_pid();
-- (re)create the database
DROP DATABASE IF EXISTS week1_workshop;
CREATE DATABASE week1_workshop;
-- connect via psql
\c week1_workshop

-- database configuration
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;


---
--- CREATE tables
---

CREATE TABLE products (
    id SERIAL,
    name TEXT NOT NULL,
    discontinued BOOLEAN NOT NULL,
    supplier_id INT,
    category_id INT,
    PRIMARY KEY(id)
);


CREATE TABLE categories (
    id SERIAL,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    picture TEXT,
    PRIMARY KEY (id)
);

-- TODO create more tables here...

--Task 1
CREATE TABLE suppliers (
    id SERIAL,
    suppliers_name TEXT NOT NULL,
    PRIMARY KEY(id)
);

--Task 2
CREATE TABLE customers (
    id SERIAL,
    company_name TEXT NOT NULL,
    PRIMARY KEY(id)
);


--Task 3
CREATE TABLE employees (
    id SERIAL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    PRIMARY KEY(id)
);

--Task 4
CREATE TABLE orders (
    id SERIAL,
    date DATE NOT NULL,  -- should be nullable (0.2)
    PRIMARY KEY(id),
    customers_id INT, -- should not be nullable (0.2)
    employees_id INT
);

--Task 5
CREATE TABLE orders_products (
    orders_id INT NOT NULL,  -- because orders_id and
    products_id INT NOT NULL, -- products_id are primary keys, they're already not null
    PRIMARY KEY (orders_id, products_id),
    discount DECIMAL,  -- should not be nullable (0.2)
    quantity INT NOT NULL
);

--Task 6
CREATE TABLE territories (
    id SERIAL,
    description SERIAL, -- description should be text and not nullable (0.2)
    PRIMARY KEY(id)     
);

--Task 7
CREATE TABLE employees_territories (
    employees_id INT NOT NULL,  -- the columns that are also part of the primary key do not need a NOT NULL
    territories_id INT NOT NULL,
    PRIMARY KEY (employees_id, territories_id)
);

--Task 8
CREATE TABLE offices (
    id SERIAL,
    address_line TEXT NOT NULL,
    territories_id INT NOT NULL, -- should also be unique (0.2)
    PRIMARY KEY(id)
);

--Task 9
CREATE TABLE us_states (
    id SERIAL,
    name TEXT UNIQUE NOT NULL,
    abbreviation CHAR(2) UNIQUE,  -- should also be not nullable (0.2)
    PRIMARY KEY(id)
);

---
--- Add foreign key constraints
---

ALTER TABLE products
ADD CONSTRAINT fk_products_categories 
FOREIGN KEY (category_id) 
REFERENCES categories;

-- TODO create more constraints here...

--Task 10
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customers_id) 
REFERENCES customers;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_employees
FOREIGN KEY (employees_id) 
REFERENCES employees;

--Task 11
ALTER TABLE products
ADD CONSTRAINT fk_products_suppliers
FOREIGN KEY (supplier_id)
REFERENCES suppliers;

--Task 12
ALTER TABLE orders_products
ADD CONSTRAINT fk_orders_products_orders
FOREIGN KEY (orders_id)
REFERENCES orders;

ALTER TABLE orders_products
ADD CONSTRAINT fk_orders_products_products
FOREIGN KEY (products_id)
REFERENCES products;

--Task 13
ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_territories_employees
FOREIGN KEY (employees_id)
REFERENCES employees;

ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_territories_territories
FOREIGN KEY (territories_id)
REFERENCES territories;

--Task 14
ALTER TABLE offices
ADD CONSTRAINT fk_offices_territories
FOREIGN KEY (territories_id)
REFERENCES territories;


-------------------

-- Grading for Week 1

-- Metrics:
-- (0.3) For major findings (material that we covered in the workshop and would break functionality)
-- (0.2) For minor findings (missing a constraint or adding an extra column)
-- (0.1) For spelling issues that would effect queries or relationships

