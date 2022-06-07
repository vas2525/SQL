create database sql_joins;
show databases;
use sql_joins;

create table cricket (cricket_id int auto_increment,
name varchar(30), primary key(cricket_id));

create table football (football_id int auto_increment,
name varchar(30), primary key(football_id));

insert into cricket ( name)
values ('Stuart'), ('Michael'), ('Johnson'), ('Hayden'), ('Fleming');

select * from cricket;

insert into football ( name)
values ('Stuart'), ('Langer'), ('Johnson'), ('Hayden'), ('Astle');

select * from football;

select * from cricket as c inner join
football as f on c.name = f.name;

select c.cricket_id, c.name, f.football_id, f.name
from cricket as c inner join football as f on c.name=f.name;

show tables;

select * from football;
use classicmodels;
select productcode, productname, textdescription
from products
inner join productlines
using (productline);

select * from orders;
select * from orderdetails;

select o.ordernumber, o.statuss, p.productname,
sum(quantityordered * priceeach) as revenue
from orders as o
inner join orderdetails as od on
o.ordernumber=od.ordernumber inner join
products as p on p.productcode = od.productcode
group by ordernumber;

select * from customers;

select c.sustomernumber, c.customername, ordernumber, status
from customer as c left join orders as o
on c.customernumber = o.customernumber;

select c.sustomernumber, c.customername, ordernumber, status
from customer as c left join orders as o
on c.customernumber = o.customernumber
where ordernumber is null;

select * from employees;

select c.customername, c.phone, e.employeenumber, e.email
from customers as c right join employees as e
on e.employeenumber = c.salesrepemloyeenumber
order by employeenumber;

select concat(m.lastname, ', ', m.firstname) as manager,
concat(e.lastname, ', ', e.firstname) as employee
from employees as e
inner join employees as m on 
m.employeenumber = e.reportsto
order by manager;

select c.customername,
ordernumber from customers as c left join
orders as o 
on c.customernumber = o.customernumber;







