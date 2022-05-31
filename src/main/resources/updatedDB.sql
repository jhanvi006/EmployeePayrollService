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
8 rows in set (0.00 sec)

mysql> CREATE DATABASE payroll_service;
Query OK, 1 row affected (0.02 sec)

mysql> show databases;
+----------------------+
| Database             |
+----------------------+
| address_book_service |
| information_schema   |
| mysql                |
| payroll_service      |
| payroll_services     |
| performance_schema   |
| sakila               |
| sys                  |
| world                |
+----------------------+
9 rows in set (0.00 sec)

mysql> USE payroll_service;
Database changed
mysql> SHOW TABLES;
Empty set (0.00 sec)

------------------UC11 - Create tables for ER diagram ----------------------------

mysql> CREATE TABLE company (
    -> company_id INT UNSIGNED NOT NULL,
    -> company_name VARCHAR(150) NOT NULL,
    -> PRIMARY KEY(company_id)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> SHOW TABLES;
+---------------------------+
| Tables_in_payroll_service |
+---------------------------+
| company                   |
+---------------------------+
1 row in set (0.00 sec)

mysql> desc company;
+--------------+--------------+------+-----+---------+-------+
| Field        | Type         | Null | Key | Default | Extra |
+--------------+--------------+------+-----+---------+-------+
| company_id   | int unsigned | NO   | PRI | NULL    |       |
| company_name | varchar(150) | NO   |     | NULL    |       |
+--------------+--------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> CREATE TABLE department (
    -> dept_id INT UNSIGNED NOT NULL,
    -> dept_name VARCHAR(150) NOT NULL,
    -> PRIMARY KEY(dept_id)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> SHOW TABLES;
+---------------------------+
| Tables_in_payroll_service |
+---------------------------+
| company                   |
| department                |
+---------------------------+
2 rows in set (0.00 sec)

mysql> desc department;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| dept_id   | int unsigned | NO   | PRI | NULL    |       |
| dept_name | varchar(150) | NO   |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> CREATE TABLE employee (
    -> emp_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    -> name VARCHAR(150) NOT NULL,
    -> phone_no VARCHAR(15),
    -> address VARCHAR(150),
    -> gender CHAR(1),
    -> company_id INT UNSIGNED NOT NULL,
    -> start_date DATE NOT NULL,
    -> PRIMARY KEY(emp_id),
    -> INDEX company_id (company_id ASC) VISIBLE,
    -> FOREIGN KEY(company_id) REFERENCES company(company_id) ON DELETE CASCADE ON UPDATE CASCADE
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> show tables;
+---------------------------+
| Tables_in_payroll_service |
+---------------------------+
| company                   |
| department                |
| employee                  |
+---------------------------+
3 rows in set (0.00 sec)

mysql> desc employee;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| emp_id     | int unsigned | NO   | PRI | NULL    | auto_increment |
| name       | varchar(150) | NO   |     | NULL    |                |
| phone_no   | varchar(15)  | YES  |     | NULL    |                |
| address    | varchar(150) | YES  |     | NULL    |                |
| gender     | char(1)      | YES  |     | NULL    |                |
| company_id | int unsigned | NO   | MUL | NULL    |                |
| start_date | date         | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
7 rows in set (0.00 sec)

mysql> CREATE TABLE employee_has_department (
    -> employee_emp_id INT UNSIGNED NOT NULL,
    -> department_dept_id INT UNSIGNED NOT NULL,
    -> PRIMARY KEY(employee_emp_id, department_dept_id),
    -> FOREIGN KEY(employee_emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE ON UPDATE CASCADE,
    -> FOREIGN KEY(department_dept_id) REFERENCES department(dept_id) ON DELETE CASCADE ON UPDATE CASCADE
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> show tables;
+---------------------------+
| Tables_in_payroll_service |
+---------------------------+
| company                   |
| department                |
| employee                  |
| employee_has_department   |
+---------------------------+
4 rows in set (0.00 sec)

mysql> desc employee_has_department;
+--------------------+--------------+------+-----+---------+-------+
| Field              | Type         | Null | Key | Default | Extra |
+--------------------+--------------+------+-----+---------+-------+
| employee_emp_id    | int unsigned | NO   | PRI | NULL    |       |
| department_dept_id | int unsigned | NO   | PRI | NULL    |       |
+--------------------+--------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> CREATE TABLE payroll (
    -> emp_id INT UNSIGNED NOT NULL,
    -> basic_pay double,
    -> income_tax double,
    -> deduction double,
    -> taxable_pay double,
    -> net_pay double NOT NULL,
    -> FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE ON UPDATE CASCADE
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> SHOW TABLES;
+---------------------------+
| Tables_in_payroll_service |
+---------------------------+
| company                   |
| department                |
| employee                  |
| employee_has_department   |
| payroll                   |
+---------------------------+
5 rows in set (0.00 sec)

mysql> INSERT INTO company (company_id, company_name) VALUES (1, 'Bridgelabz'), (2, 'TCS'), (3, 'KPIT');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM company;
+------------+--------------+
| company_id | company_name |
+------------+--------------+
|          1 | Bridgelabz   |
|          2 | TCS          |
|          3 | KPIT         |
+------------+--------------+
3 rows in set (0.00 sec)

mysql> INSERT INTO department (dept_id, dept_name) VALUES (1, 'Sales'), (2, 'Marketing'), (3, 'Finance'), (4, 'Operations');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM department;
+---------+------------+
| dept_id | dept_name  |
+---------+------------+
|       1 | Sales      |
|       2 | Marketing  |
|       3 | Finance    |
|       4 | Operations |
+---------+------------+
4 rows in set (0.00 sec)

mysql> INSERT INTO employee (name, phone_no, address, gender, company_id, start_date)
    -> VALUES
    -> ('Jhanvi K', '7878787878', 'Jamnagar', 'F', 1, '2018-11-11'),
    -> ('Kabir M', '9090909090', 'Mumbai', 'M', 3, '2019-06-03'),
    -> ('Madhuri N', '9123122200', 'Ahmedabad', 'F', 1, '2017-10-01'),
    -> ('Karan S', '6564332200', 'Chandigarh', 'M', 2, '2021-01-19');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee;
+--------+-----------+------------+------------+--------+------------+------------+
| emp_id | name      | phone_no   | address    | gender | company_id | start_date |
+--------+-----------+------------+------------+--------+------------+------------+
|      1 | Jhanvi K  | 7878787878 | Jamnagar   | F      |          1 | 2018-11-11 |
|      2 | Kabir M   | 9090909090 | Mumbai     | M      |          3 | 2019-06-03 |
|      3 | Madhuri N | 9123122200 | Ahmedabad  | F      |          1 | 2017-10-01 |
|      4 | Karan S   | 6564332200 | Chandigarh | M      |          2 | 2021-01-19 |
+--------+-----------+------------+------------+--------+------------+------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM employee_has_department;
Empty set (0.00 sec)

mysql> INSERT INTO employee_has_department (employee_emp_id, department_dept_id)
    -> VALUES
    -> (1, 1),
    -> (1, 2),
    -> (2, 4),
    -> (3, 2),
    -> (4, 3),
    -> (4, 4);
Query OK, 6 rows affected (0.01 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee_has_department;
+-----------------+--------------------+
| employee_emp_id | department_dept_id |
+-----------------+--------------------+
|               1 |                  1 |
|               1 |                  2 |
|               3 |                  2 |
|               4 |                  3 |
|               2 |                  4 |
|               4 |                  4 |
+-----------------+--------------------+
6 rows in set (0.00 sec)

mysql> INSERT INTO payroll(emp_id, basic_pay, income_tax, deduction, taxable_pay, net_pay)
    -> VALUES
    -> (1, 300000.00, 1000000.00, 200000.00, 5000.00, 15000000.00),
    -> (2, 500000.00, 1500000.00, 350000.00, 6000.00, 2800000.00),
    -> (3, 200000.00, 80000.00, 180000.00, 4500.00, 1500000.00);
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM payroll;
+--------+-----------+------------+-----------+-------------+----------+
| emp_id | basic_pay | income_tax | deduction | taxable_pay | net_pay  |
+--------+-----------+------------+-----------+-------------+----------+
|      1 |    300000 |    1000000 |    200000 |        5000 | 15000000 |
|      2 |    500000 |    1500000 |    350000 |        6000 |  2800000 |
|      3 |    200000 |      80000 |    180000 |        4500 |  1500000 |
+--------+-----------+------------+-----------+-------------+----------+
3 rows in set (0.00 sec)