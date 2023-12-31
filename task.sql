--Task 1:
--List all employees who have the title 'Sales Representative' and were working in the 'UK'.

select *
from employees e
where e.title  = 'Sales Representative'


--Task 2:
--List all customers who have placed an order with a product in the 'Beverages' category and have a fax number that starts with '09'.

select distinct  c.customer_id, c2.category_name
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on od.order_id = o.order_id
join products p on p.product_id = od.product_id
join categories c2 on c2.category_id  = p.category_id
where c.fax like '09%' and c2.category_name = 'Beverages'


--Task 3:
--List all products that have been ordered at least once and have a reorder level of less than or equals 5.

select distinct p.product_id ,p.reorder_level
from products p
join order_details od on od.product_id = p.product_id
where p.reorder_level < 6


--Task 4:
--List all products that have been ordered more than 5 times and have a unit price greater than $10.

select p.product_id , p.product_name , p.unit_price, count(od.product_id) as order_counter
from  products p
join order_details od on od.product_id = p.product_id
where p.unit_price > 10
group by p.product_id
having count(od.product_id) > 5


--Task 5:
--List all suppliers who are located in Canada.

select *
from suppliers s
where s.city = 'Canada'


--Task 6:
--List all employees who have the title 'Sales Representative' and were born in Norway.

select *
from employees e
where e.title = 'Sales Representative' and e.city = 'Norway'


--Task 7:
--List all products that have a unit price greater than $20 and have been ordered at least 20 times.

select p.product_id,p.product_name ,count(od.product_id)  as order_counter
from products p
join order_details od on od.product_id = p.product_id
where p.unit_price > 20
group by p.product_id
having count(od.product_id) > 19


--Task 8:
--List all orders that were placed on a Monday and shipped on a Friday.

select distinct order_id , o.order_date , o.shipped_date
from orders o
where
EXTRACT(DOW FROM o.order_date) = 1
AND EXTRACT(DOW FROM o.shipped_date) = 5


--Task 9:
--List all orders that have been shipped to the 'Canada'.

select distinct *
from orders o
where o.ship_country = 'Canada'


--Task 10:
--List all suppliers who are located in the 'USA' and have a fax number that ends with '33'.

select distinct *
from suppliers s
where s.country = 'USA' and s.fax like '%33'


--Task 11:
--List all orders that have a shipped date later than the required date and have a freight charge greater than $10.

select distinct *
from orders o
where o.shipped_date > o.required_date and o.freight > 10


--Task 12:
--List all orders that have a total price less than $500 and a discount greater than 20%.

select distinct o.order_id, sum(od.unit_price * od.quantity *(1- od.discount)) as total_sum
from orders o
join order_details od on od.order_id = o.order_id
group by o.order_id
having sum(od.unit_price * od.quantity *(1- od.discount)) < 500


--Task 13:
--List all customers who have a postal code that starts with 'M'.

select *
from customers c
where c.postal_code like 'M%'


--Task 14:
--List all employees who have the title 'Vice President, Sales'.

select *
from employees e
where e.title = 'Vice President, Sales'


--Task 15:
--List all employees who have at least one order with a total price less than $5000 but greater than $1000.

select distinct e.employee_id , sum(od.unit_price * od.quantity * (1- od.discount)) as total_sum
from employees e
join orders o on o.employee_id = o.employee_id
join order_details od on od.order_id = o.order_id
group by e.employee_id
having sum(od.unit_price * od.quantity * (1- od.discount)) between 1000 and 5000


--Task 16:
--List all products that have been ordered more than 10 times and have a unit price between $50 and $100.

select p.product_id , count(od.order_id) as oder_counter, sum(od.unit_price * od.quantity * (1- od.discount)) as total_sum
from products p
join order_details od on od.product_id = p.product_id
group by p.product_id
having count(od.order_id) > 10 and
sum(od.unit_price * od.quantity * (1- od.discount)) between 50 and 100


--Task 17:
--List all products that have a unit price less than $5.

select *
from products p
where p.unit_price < 5


--Task 18:
--List all products in the 'Produce' category.

select  *
from products p
join categories c on p.category_id = c.category_id
where c.category_name = 'Produce'

--Task 19:
--List all orders that have a shipped date later than 5 days after the required date.

select distinct *
from orders o
where o.shipped_date > (o.required_date + interval'5 days')


--Task 20:
--List all products that have been ordered more than 5 times and have a unit price less than $50.

select p.product_id ,p.product_name , count(od.order_id) as counter, od.unit_price
from products p
join order_details od on od.product_id = p.product_id
where od.unit_price < 50
group by p.product_id , p.product_name, od.unit_price
having count(od.order_id) > 5


--Task 21:
--List all suppliers who are located in the USA and have a contact title of 'Marketing Assistant'.

select *
from suppliers s
where country = 'USA' and contact_title = 'Marketing Assistant'


--Task 22:
--List all orders that have a shipped date earlier than the required date and have a freight charge less than $1.

select *
from orders o
where o.shipped_date < o.required_date and o.freight < 1


--Task 23:
--List all customers who have placed at least one order for a product in the 'Confections' category and have a fax number.

select c.company_name, c.fax , count (o.order_id) as count_orders
from customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
join products p on p.product_id = od.product_id
join categories c2 on c2.category_id = p.category_id
where c2.category_name = 'Confections' and c.fax is not null
group by c.customer_id
having count(o.order_id) > 0


--Task 24:
--List all suppliers who are located in the USA and have a fax number that ends with '49'.

select *
from suppliers s
where country = 'USA' and fax like '%49'

--Task 25:
--List all products in the 'Seafood' category that have a unit price greater than $15 and have been ordered at least once.

select p.product_name, p.unit_price , count(od.order_id) as counter
from products p
join categories c on c.category_id = p.category_id
join order_details od on od.product_id = p.product_id
where p.unit_price > 15 and c.category_name = 'Seafood'
group by p.product_id
having count(od.order_id) > 0


--Task 26:
--List all employees who have at least one order with a total price between $100000 and $500000.

select e.employee_id, count(o.order_id) as counter,
sum(od.quantity * od.unit_price *(1-od.discount)) as total_sum
from employees e
join orders o on o.employee_id = e.employee_id
join order_details od on od.order_id = o.order_id
group by e.employee_id
having sum(od.quantity * od.unit_price *(1-od.discount)) between 100000 and 500000
and count(o.order_id) > 0


--Task 27:
--List all suppliers who are located in Singapore and have a contact title of 'Owner'.

select *
from suppliers s
where s.country = 'Singapore' and s.contact_title = 'Owner'


--Task 28:
--List all suppliers who are located in the USA and have a fax number starting with '4'.

select *
from suppliers s
where s.country = 'USA' and s.fax like '4%'

--Task 29 :
--List all customers who have placed an order with a product in the 'Produce' category.

select *
from customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
join products p on od.product_id = p.product_id
join categories c2 on c2.category_id = p.category_id
where c2.category_name = 'Produce'


--Task 30:
--List all orders that have a shipped date later than the required date and have a freight charge greater than $10

select *
from orders o
where o.shipped_date > o.required_date  and o.freight > 10


--Task 31:
--List all products that have been ordered more than 5 times and have a unit price less than $50.

select p.product_id , od.unit_price , count(od.order_id) as order_count
from products p
join order_details od on od.product_id = p.product_id
where od.unit_price < 50
group by od.order_id , p.product_id, od.unit_price
having count(od.order_id) > 5


--Task 32:
--List all orders that have a freight charge less than $10 and were shipped to the 'France'.

select *
from orders o
where o.freight < 10 and o.ship_city = 'France'


--Task 33:
--List all employees who have the title 'Sales Representative' and are working in UK.

select *
from employees e
where e.title = 'Sales Representative' and e.country = 'UK'


--Task 34:
--List all employees who have at least one order with a total price greater than $100000.

select e.employee_id , sum(od.unit_price * od.quantity *(1- od.discount)) as total_sum
from employees e
join orders o on o.employee_id = e.employee_id
join order_details od on od.order_id = o.order_id
group by e.employee_id
having sum(od.unit_price * od.quantity *(1- od.discount)) > 100000


--Task 35:
--List all customers who have placed at least one order for a product in the 'Condiments' category and have a phone number with an area code starting with '503'.

select *
from  customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
join products p on od.product_id = p.product_id
join categories c2 on c2.category_id = p.category_id
where c2.category_name = 'Condiments' and c.phone  like '(503%'


--Task 36:
--List all employees who have the title 'Sales Manager' and are working in the USA.

select *
from employees e
where e.title = 'Sales Manager' and e.country ='USA'

--Task 37:
--List all suppliers who are located in the 'UK' and have no fax number.

select *
from suppliers s
where s.country ='UK' and fax isnull


--Task 38:
--List all employees who have the title 'Sales Representative' and have at least one customer from Spain

select distinct  e.employee_id, e.title  , c.country
from employees e
join orders o on o.employee_id = e.employee_id
join customers c on c.customer_id = o.customer_id
where e.title = 'Sales Representative' and c.country = 'Spain'


--Task 39:
--List all customers who have placed at least one order for a product in the 'Seafood' category and have a fax number

select c.customer_id ,c.fax , c2.category_name
from customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
join products p on p.product_id = od.product_id
join categories c2 on c2.category_id = p.category_id
where c.fax is not null and c2.category_name = 'Seafood'


--Task 40:
-- --List all employees who have the title 'Sales Representative' and are working in UK.

select *
from employees e
where e.title ='Sales Representative' and e.country = 'UK'

--Task 41:
--List all customers who have placed an order in the year 1998 with a product in the 'Grains/Cereals' category

select distinct  c.customer_id ,c2.category_name , o.order_date
from customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
join products p on p.product_id = od.product_id
join categories c2 on c2.category_id = p.category_id
where c2.category_name = 'Grains/Cereals'
and extract (year from o.order_date)=  1998


--Task 42:
--List all products that have a unit price greater than $30 and have been ordered more than 5 times.

select distinct p.product_id, p.unit_price  , count(od.order_id) as order_count
from products p
join order_details od on od.product_id = p.product_id
where p.unit_price > 30
group by p.product_id
having count(od.order_id) > 5


--Task 43:
--List all orders that have a freight charge less than $20 and were shipped to Sweden'.

select o.order_id, o.freight , o.ship_country
from orders o
where o.freight < 20 and o.ship_country = 'Sweden'


--Task 44:
--List all customers who have a postal code that ends with '1' and have placed an order in the year 1997.

select c.customer_id , c.postal_code , o.order_date
from customers c
join orders o on o.customer_id = c.customer_id
where c.postal_code like '%1'
and extract (year from o.order_date) = 1997


--Task 45:
--List all products in the 'Condiments' category that have a unit price greater than $5 and have been ordered at least once.

select distinct p.product_id , c.category_name, od.unit_price
from products p
join categories c on p.category_id = c.category_id
join order_details od on od.product_id = p.product_id
where c.category_name = 'Condiments' and od.unit_price > 5


--Task 46:
--List all customers who have placed at least one order for a product in the 'Beverages' category and have a fax number.

select distinct c.customer_id, c2.category_name , c.fax
from customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
join products p on p.product_id = od.product_id
join categories c2 on c2.category_id = p.category_id
where c2.category_name = 'Beverages' and c.fax is not null


--Task 47:
--List all products that have been ordered more than 10 times and have a unit price less than $10.

select p.product_id, p.unit_price  , count(od.order_id) as order_count
from products p
join order_details od on od.product_id = p.product_id
where p.unit_price < 10
group by p.product_id
having count(od.order_id) > 10


--Task 48:
--List all employees who have at least one order with a total price greater than $10000.

select e.employee_id , sum(od.quantity * od.unit_price *(1- od.discount)) as total_sum
from employees e
join orders o on o.employee_id = e.employee_id
join order_details od on od.order_id = o.order_id
group  by e.employee_id
having sum(od.quantity * od.unit_price *(1- od.discount)) > 10000


--Task 49:
--List all customers who have placed an order with a product in the 'Meat/Poultry' category and have a fax number that ends with '01'.

select c.customer_id ,c2.category_name , c.fax
from customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
join products p on p.product_id = od.product_id
join categories c2 on c2.category_id = p.category_id
where c2.category_name = 'Meat/Poultry' and c.fax like '%01'


--Task 50:
--List all orders that have a shipped date in the year 1998 and were shipped to the 'UK'.

select o.order_id, o.ship_country , o.order_date
from orders o
where extract (year from o.order_date) = 1998
and o.ship_country = 'UK'