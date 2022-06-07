# select statement

use subqueries;

show tables;

select emp_name, dept, salary from employees
where salary < (select avg(salary) from employees);

#update subquery
create table products (prod_id int, item varchar(30), sell_price float, product_type varchar(30));

insert into products
values( 101, 'Jewellery', 1800, 'Luxury'),
 (102, 'T-shirt', 100, 'Non-Luxury'),
 (103, 'Laptop', 3000, 'Luxury'),
 (104, 'Table', 400, 'Non-Luxury');
 
 select * from products;
 
 create table orders (order_id int, product_sold varchar(30), selling_price float);
 
 insert into orders
 select prod_id, item, sell_price
 from products where prod_id in
 (select prod_id from products where sell_price>1000);
 
 select * from orders;
 
 
 
 #update subquery
 
 select * from employees_b;
 
 update employees 
 set salary =  * 0.35
 where age in (select age from employees_b where age>=27);
 
 select * from employees;
 
 #Delete subquery
delete from employees
where age in (Select age from employees_b where age <=32);

create database triggers;
use triggers;
show tables;

#before insert trigger

create table customers
(cust_id int, age int, name varchar(30));
 
delimiter //
create trigger age_verify
before insert on customers
for each row
if new.age < 0 then set new.age = 0;
end if; //

insert into customers
values (101, 27, "James"),
(102, -40, "Ammy"),
(103, 32, "Ben"),
(104, -39, "Angela");
 
 select * from customers;
 
 create table customers1(
 id int auto_increment primary key,
 email varchar(30), birthdate date);
 
 create table message (
 id int auto_increment,
 message_id int,
 message varchar(300) not null,
 primary key (id, message_id));
 
 show tables;
 
 Delimiter //
 create trigger
 check_null_dob
 after insert
 on customers1
 for each row
 begin
 if new.birthdate is null then
 insert into message (message_id, message)
 values (new.id, concat('Hi', new.name, ', please update your date of birth.'));
 end if;
 end //
 delimiter ;
 
 insert into customers1 (name, email, birthdate)
 values ("Nancy", "nancy@bc.com", NULL),
 ("Ronald", "ronald@xyz.com", "1998-11-16"),
 ("Chris", "chris@fdz.com", "1997-08-20"),
 ("Alice", "alice@nc.com", NULL);
 
 select * from message;
 
 #before update
 create table employees
(emp_id int primary key,
emp_name varchar(25), age int, salary float);

insert into employees values
(101, "Jimmy", 35, 70000),
(102, "Shane", 30, 55000),
(103, "Marry", 28, 62000),
(104, "Dwayne", 37, 57000),
(105, "Sara", 32, 72000),
(106, "Ammy", 35, 80000),
(107, "Jack", 40, 100000);
 
 delimiter //
 create trigger upd_trigger
 before update
 on employees
 for each row
 begin
 if new.salary=10000 then
 set new.salary = 85000;
 elseif new.salary < 10000 then
 set new.salary = 72000;
 end if;
 end //
 delimiter ;
 
 select * from employees;
 
 update employees
 set salary = 8000;
 
 #before delete
 
 create table salary (
 eid int primary key,
 validfrom date not null,
 amount float not null);
 
 insert into salary (eid, validfrom, amount) 
 values (101, '2005-05-01', 55000),
 (102, '2007-08-01', 68000),
 (103, '2006-09-01', 72000);
 
 select * from salary;
 
 create table salarydel (id int primary key auto_increment,
 eid int, validfrom date not null,
 amount float not null,
 deletedat timestamp default now());
 
 delimeter $$
 create trigger salary_delete
 before delete
 on salary
 for each row
 begin
 insert into salarydel(eid, validfrom, amount)
 value(old.eid, old.validfrom, old.amount);
 end$$
 
 delimeter ;
 
 delete from salarydel
 where eid = 103;
 
 select * from salarydel; 
 
 
 
 
 
 
 
 delimiter $$  
 create trigger salary_delete  
 before delete  on salary  
 for each row  
 begin  
 insert into salarydel(eid, validfrom, amount)  
 value(old.eid, old.validfrom, old.amount)
end$$

delimiter ;

delete * from salarydel
where eid = 103;

select * from salarydel;