-------------  UC1 - Create payroll_services database ------------

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| payroll_services   |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
7 rows in set (0.00 sec)

mysql> use payroll_services;
Database changed
mysql> select database();
+------------------+
| database()       |
+------------------+
| payroll_services |
+------------------+
1 row in set (0.00 sec)

-------------  UC2 - Create employee_payroll table ------------
mysql> CREATE TABLE employee_payroll
    -> (
    -> id INT unsigned NOT NULL AUTO_INCREMENT,
    -> name VARCHAR(150) NOT NULL,
    -> salary DOUBLE NOT NULL,
    -> start DATE NOT NULL,
    -> PRIMARY KEY(id)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> desc employee_payroll;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int unsigned | NO   | PRI | NULL    | auto_increment |
| name   | varchar(150) | NO   |     | NULL    |                |
| salary | double       | NO   |     | NULL    |                |
| start  | date         | NO   |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
4 rows in set (0.02 sec)

-------------  UC3 - CRUD Operation(Insert in table) on employee_payroll table ------------
mysql> INSERT INTO employee_payroll (name, salary, start)
    -> VALUES
    -> ('Bill', 1000000.00, '2010-10-30'),
    -> ('Tersia', 2000000.00, '2019-11-13'),
    -> ('Charlie', 3000000.00, '2050-05-21');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

-------------  UC4 - Retrieve all data from table ------------
mysql> SELECT * FROM employee_payroll;
+----+---------+---------+------------+
| id | name    | salary  | start      |
+----+---------+---------+------------+
|  1 | Bill    | 1000000 | 2010-10-30 |
|  2 | Tersia  | 2000000 | 2019-11-13 |
|  3 | Charlie | 3000000 | 2050-05-21 |
+----+---------+---------+------------+
3 rows in set (0.00 sec)

-------------  UC5 - Retrieve specific data from table ------------
mysql> SELECT salary FROM employee_payroll WHERE name='Bill';
+---------+
| salary  |
+---------+
| 1000000 |
+---------+
1 row in set (0.00 sec)

mysql> SELECT * FROM employee_payroll WHERE start BETWEEN CAST('2018-10-01' AS DATE) AND DATE(NOW());
+----+--------+---------+------------+
| id | name   | salary  | start      |
+----+--------+---------+------------+
|  2 | Tersia | 2000000 | 2019-11-13 |
+----+--------+---------+------------+
1 row in set (0.01 sec)

-------------  UC6 - Alter table to add gender and update rows ------------
mysql> ALTER TABLE employee_payroll ADD gender CHAR(1) AFTER name;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc employee_payroll;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int unsigned | NO   | PRI | NULL    | auto_increment |
| name   | varchar(150) | NO   |     | NULL    |                |
| gender | char(1)      | YES  |     | NULL    |                |
| salary | double       | NO   |     | NULL    |                |
| start  | date         | NO   |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> UPDATE employee_payroll SET gender = 'M' WHERE name='Bill' OR name='Charlie';
Query OK, 2 rows affected (0.01 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+--------+---------+------------+
| id | name    | gender | salary  | start      |
+----+---------+--------+---------+------------+
|  1 | Bill    | M      | 1000000 | 2010-10-30 |
|  2 | Tersia  | NULL   | 2000000 | 2019-11-13 |
|  3 | Charlie | M      | 3000000 | 2050-05-21 |
+----+---------+--------+---------+------------+
3 rows in set (0.00 sec)

mysql> UPDATE employee_payroll SET gender = 'F' WHERE name='Tersia';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+--------+---------+------------+
| id | name    | gender | salary  | start      |
+----+---------+--------+---------+------------+
|  1 | Bill    | M      | 1000000 | 2010-10-30 |
|  2 | Tersia  | F      | 2000000 | 2019-11-13 |
|  3 | Charlie | M      | 3000000 | 2050-05-21 |
+----+---------+--------+---------+------------+
3 rows in set (0.00 sec)

mysql> ALTER TABLE employee_payroll modify gender CHAR(1) NOT NULL;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc employee_payroll;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int unsigned | NO   | PRI | NULL    | auto_increment |
| name   | varchar(150) | NO   |     | NULL    |                |
| gender | char(1)      | NO   |     | NULL    |                |
| salary | double       | NO   |     | NULL    |                |
| start  | date         | NO   |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

-------------  UC7 - Find sum, average, min, max and count no. of male and female employees ------------
mysql> SELECT AVG(salary) FROM employee_payroll;
+-------------+
| AVG(salary) |
+-------------+
|     2000000 |
+-------------+
1 row in set (0.00 sec)

-------------  Insert a row in the table ------------
mysql> INSERT INTO employee_payroll (name, gender, salary, start) VALUES ('Jenny', 'F', 2300000.00, '2022-10-13');
Query OK, 1 row affected (0.01 sec)

mysql> SELECT AVG(salary) FROM employee_payroll WHERE gender='M' GROUP BY gender;
+-------------+
| AVG(salary) |
+-------------+
|     2000000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(salary) FROM employee_payroll WHERE gender='F' GROUP BY gender;
+-------------+
| AVG(salary) |
+-------------+
|     2150000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT gender,AVG(salary) FROM employee_payroll GROUP BY gender;
+--------+-------------+
| gender | AVG(salary) |
+--------+-------------+
| M      |     2000000 |
| F      |     2150000 |
+--------+-------------+
2 rows in set (0.00 sec)

mysql> SELECT gender, SUM(salary) FROM employee_payroll GROUP BY gender;
+--------+-------------+
| gender | SUM(salary) |
+--------+-------------+
| M      |     4000000 |
| F      |     4300000 |
+--------+-------------+
2 rows in set (0.00 sec)

mysql> SELECT gender, MAX(salary), MIN(salary) FROM employee_payroll GROUP BY gender;
+--------+-------------+-------------+
| gender | MAX(salary) | MIN(salary) |
+--------+-------------+-------------+
| M      |     3000000 |     1000000 |
| F      |     2300000 |     2000000 |
+--------+-------------+-------------+
2 rows in set (0.01 sec)

mysql> SELECT COUNT(id) AS female_count FROM employee_payroll WHERE gender='F' GROUP BY gender;
+--------------+
| female_count |
+--------------+
|            2 |
+--------------+
1 row in set (0.00 sec)

-------------------------------- Normalise table to multiple tables -------------------
mysql> show databases;
+----------------------+
| Database             |
+----------------------+
| address_book_service |
| information_schema   |
| mysql                |
| payroll_services     |
| performance_schema   |
| sakila               |
| sys                  |
| world                |
+----------------------+
8 rows in set (0.03 sec)

mysql> use payroll_services;
Database changed
mysql> show tables;
+----------------------------+
| Tables_in_payroll_services |
+----------------------------+
| employee_payroll           |
+----------------------------+
1 row in set (0.02 sec)

------ add new columns ------------
mysql> ALTER TABLE employee_payroll ADD phone_number VARCHAR(250) AFTER name,
    ->  ADD address VARCHAR(250) AFTER phone_number;
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc employee_payroll;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int unsigned | NO   | PRI | NULL    | auto_increment |
| name         | varchar(150) | NO   |     | NULL    |                |
| phone_number | varchar(250) | YES  |     | NULL    |                |
| address      | varchar(250) | YES  |     | NULL    |                |
| gender       | char(1)      | NO   |     | NULL    |                |
| salary       | double       | NO   |     | NULL    |                |
| start        | date         | NO   |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
7 rows in set (0.04 sec)

mysql> ALTER TABLE employee_payroll ADD department VARCHAR(250) NOT NULL AFTER address;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc employee_payroll;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int unsigned | NO   | PRI | NULL    | auto_increment |
| name         | varchar(150) | NO   |     | NULL    |                |
| phone_number | varchar(250) | YES  |     | NULL    |                |
| address      | varchar(250) | YES  |     | NULL    |                |
| department   | varchar(250) | NO   |     | NULL    |                |
| gender       | char(1)      | NO   |     | NULL    |                |
| salary       | double       | NO   |     | NULL    |                |
| start        | date         | NO   |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
8 rows in set (0.00 sec)

mysql> ALTER TABLE employee_payroll ADD basic_pay double NOT NULL AFTER salary,
    ->  ADD deductions double NOT NULL AFTER basic_pay,
    ->  ADD taxable_pay double NOT NULL AFTER deductions,
    ->  ADD income_tax double NOT NULL AFTER taxable_pay,
    ->  ADD net_pay double NOT NULL AFTER income_tax;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc employee_payroll;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int unsigned | NO   | PRI | NULL    | auto_increment |
| name         | varchar(150) | NO   |     | NULL    |                |
| phone_number | varchar(250) | YES  |     | NULL    |                |
| address      | varchar(250) | YES  |     | TBD     |                |
| department   | varchar(250) | NO   |     | NULL    |                |
| gender       | char(1)      | NO   |     | NULL    |                |
| salary       | double       | NO   |     | NULL    |                |
| basic_pay    | double       | NO   |     | NULL    |                |
| deductions   | double       | NO   |     | NULL    |                |
| taxable_pay  | double       | NO   |     | NULL    |                |
| income_tax   | double       | NO   |     | NULL    |                |
| net_pay      | double       | NO   |     | NULL    |                |
| start        | date         | NO   |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
13 rows in set (0.00 sec)

mysql> SELECT * FROM employee_payroll;
+----+---------+--------------+---------+------------+--------+---------+-----------+------------+-------------+------------+---------+------------+
| id | name    | phone_number | address | department | gender | salary  | basic_pay | deductions | taxable_pay | income_tax | net_pay | start      |
+----+---------+--------------+---------+------------+--------+---------+-----------+------------+-------------+------------+---------+------------+
|  1 | Bill    | NULL         | NULL    |            | M      | 1000000 |         0 |          0 |           0 |          0 |       0 | 2010-10-30 |
|  2 | Tersia  | NULL         | NULL    |            | F      | 2000000 |         0 |          0 |           0 |          0 |       0 | 2019-11-13 |
|  3 | Charlie | NULL         | NULL    |            | M      | 3000000 |         0 |          0 |           0 |          0 |       0 | 2050-05-21 |
|  4 | Jenny   | NULL         | NULL    |            | F      | 2300000 |         0 |          0 |           0 |          0 |       0 | 2022-10-13 |
+----+---------+--------------+---------+------------+--------+---------+-----------+------------+-------------+------------+---------+------------+
4 rows in set (0.01 sec)

mysql> SELECT * FROM employee_payroll WHERE name = 'Tersia';
+----+--------+--------------+---------+------------+--------+---------+-----------+------------+-------------+------------+---------+------------+
| id | name   | phone_number | address | department | gender | salary  | basic_pay | deductions | taxable_pay | income_tax | net_pay | start      |
+----+--------+--------------+---------+------------+--------+---------+-----------+------------+-------------+------------+---------+------------+
|  2 | Tersia | NULL         | NULL    |            | F      | 2000000 |         0 |          0 |           0 |          0 |       0 | 2019-11-13 |
+----+--------+--------------+---------+------------+--------+---------+-----------+------------+-------------+------------+---------+------------+
1 row in set (0.00 sec)

mysql> INSERT INTO employee_payroll
    -> (name, phone_number, address, department, gender, salary, basic_pay, deductions, taxable_pay, income_tax, net_pay, start) VALUES
    -> ('Tersia', '9080809900', 'ahmedabad', 'Marketing', 'F', 5000000.00, 300000.00, 1000000.00, 200000.00, 5000.00, 15000000.00, '2019-11-13');
Query OK, 1 row affected (0.01 sec)

---------------- data redundancy case ----------------------
mysql> SELECT * FROM employee_payroll WHERE name = 'Tersia';
+----+--------+--------------+-----------+------------+--------+---------+-----------+------------+-------------+------------+----------+------------+
| id | name   | phone_number | address   | department | gender | salary  | basic_pay | deductions | taxable_pay | income_tax | net_pay  | start      |
+----+--------+--------------+-----------+------------+--------+---------+-----------+------------+-------------+------------+----------+------------+
|  2 | Tersia | NULL         | NULL      |            | F      | 2000000 |         0 |          0 |           0 |          0 |        0 | 2019-11-13 |
|  5 | Tersia | 9080809900   | ahmedabad | Marketing  | F      | 5000000 |    300000 |    1000000 |      200000 |       5000 | 15000000 | 2019-11-13 |
+----+--------+--------------+-----------+------------+--------+---------+-----------+------------+-------------+------------+----------+------------+
2 rows in set (0.00 sec)

mysql> show tables;
+----------------------------+
| Tables_in_payroll_services |
+----------------------------+
| employee_payroll           |
+----------------------------+
1 row in set (0.02 sec)

mysql> CREATE TABLE company (
    -> company_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    -> company_name VARCHAR(150) NOT NULL,
    -> PRIMARY KEY(company_id)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> show tables;
+----------------------------+
| Tables_in_payroll_services |
+----------------------------+
| company                    |
| employee_payroll           |
+----------------------------+
2 rows in set (0.00 sec)

mysql> CREATE TABLE department (
    -> dept_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    -> dept_name VARCHAR(150) NOT NULL,
    -> PRIMARY KEY(dept_id)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> show tables;
+----------------------------+
| Tables_in_payroll_services |
+----------------------------+
| company                    |
| department                 |
| employee_payroll           |
+----------------------------+
3 rows in set (0.00 sec)

mysql> CREATE TABLE employee (
    -> emp_id INT unsigned NOT NULL AUTO_INCREMENT,
    -> name VARCHAR(150) NOT NULL,
    -> phone_no VARCHAR(15) NOT NULL,
    -> address VARCHAR(150) NOT NULL,
    -> company_id INT UNSIGNED NOT NULL,
    -> department_id INT UNSIGNED NOT NULL,
    -> gender CHAR(1) NOT NULL,
    -> start_date DATE NOT NULL,
    -> PRIMARY KEY(emp_id),
    -> FOREIGN KEY(company_id) REFERENCES company(company_id) ON DELETE CASCADE,
    -> FOREIGN KEY(department_id) REFERENCES department(dept_id) ON DELETE CASCADE
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> show tables;
+----------------------------+
| Tables_in_payroll_services |
+----------------------------+
| company                    |
| department                 |
| employee                   |
| employee_payroll           |
+----------------------------+
4 rows in set (0.00 sec)

mysql> CREATE TABLE payroll (
    -> emp_id INT unsigned NOT NULL,
    -> basic_pay double,
    -> income_tax double,
    -> deduction double,
    -> taxable_pay double,
    -> net_pay double NOT NULL,
    -> FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> SHOW TABLES;
+----------------------------+
| Tables_in_payroll_services |
+----------------------------+
| company                    |
| department                 |
| employee                   |
| employee_payroll           |
| payroll                    |
+----------------------------+
5 rows in set (0.00 sec)

----------add column un department table------------
mysql> ALTER TABLE department
    -> ADD emp_id INT unsigned NOT NULL,
    -> ADD CONSTRAINT FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE;
Query OK, 0 rows affected (0.08 sec)
Records: 0  Duplicates: 0  Warnings: 0
