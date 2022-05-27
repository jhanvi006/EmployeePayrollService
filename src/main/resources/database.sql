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