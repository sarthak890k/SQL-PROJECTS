-- 1.Total number of customers.

select count(customer_id) as total_customers
from customers;


-- 2.Number of customers by gender.

select gender , count(customer_id) as total_customers
from customers
group by gender;


-- 3.Average age of customers.

select avg(age) as avg_age
from customers;


-- 4.Number of customers in each city.

select city, count(customer_id)
from customers
group by city;


-- 5.Number of loyalty members and non-members.

select loyalty_member,count(customer_id) as 'number of members'
from customers
group by loyalty_member;


-- 6.Total number of products.

select count(distinct(product_name)) as total_products
from products;


-- 7.Number of products in each category.

select category , count(product_id) as ' number of products '
from products
group by category;


-- 8.Most expensive product.

select product_name , price
from products
order by price desc
limit 1;


-- 9.Cheapest product.

select product_name , price
from products
order by price 
limit 1;


-- 10.count total number of each payment method

select payment_method,count(payment_method)
from orders
group by payment_method;


-- Intermediate 

-- 11.Total quantity sold.

select sum(quantity) as total_quantity
from orders;


-- 12.quantity Order by each payment method.

select payment_method,sum(quantity) as total_quantity
from orders
group by payment_method;

-- 13.Monthly order count.

select month(order_date),count(quantity)
from orders
group by month(order_date)
order by month(order_date) ;

-- 14.Total revenue generated.

select sum(o.quantity * p.price) as total_revenue
from orders o
join products p
on o.product_id=p.product_id;


-- 15.Revenue by product category.

select  category,sum(o.quantity * p.price) as total_revenue 
from orders o
join products p
on o.product_id=p.product_id
group by category;


-- 16.Revenue by city.

select  city,sum(o.quantity * p.price) as total_revenue 
from orders o
join products p
on o.product_id=p.product_id
join customers c
on c.customer_id=o.customer_id
group by city;


-- 17.Revenue by gender.

select  gender,sum(o.quantity * p.price) as total_revenue 
from orders o
join products p
on o.product_id=p.product_id
join customers c
on c.customer_id=o.customer_id
group by gender;


-- 18.Top 5 customers by number of orders.

select customer_id ,count(quantity) as total_quantity
from orders
group by customer_id
order by total_quantity desc
limit 5;


-- 19.Customers who never placed an order.

select c.customer_id,age,gender,city
from customers c
left join orders o
on c.customer_id=o.customer_id
where o.order_id is null


-- 20.Average orders per customer.
s;

select count(order_id)/count(distinct(customer_id))
from orders;


-- 21.Top 10 best-selling products.

select p.product_name,sum(o.quantity),o.product_id
from products p
join orders o
on p.product_id=o.product_id
group by p.product_id
order by sum(o.quantity)
limit 10;


-- 22.Top-selling product category.

select p.product_id,p.category,sum(o.quantity) as heighest_selling
from products p
join orders o
on p.product_id=o.product_id
group by p.category , p.product_id
order by heighest_selling desc
limit 1;


-- Advanced 


-- 23.Top 5 customers by spending.

select o.customer_id,sum(o.quantity*p.price)as total_spending
from orders o
join products p
on o.product_id=p.product_id
group by o.customer_id
order by total_spending desc
limit 5;


-- 24.Customer lifetime value (CLV).

select o.customer_id,sum(o.quantity*p.price)as CLV
from orders o
join products p
on o.product_id=p.product_id
group by o.customer_id
order by CLV ;

-- 25.Repeat customers vs one-time customers.

SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS number_of_customers
FROM (SELECT customer_id,COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id)t
GROUP BY customer_type; 


-- 26.Revenue from loyalty members vs non-members.

select c.loyalty_member,sum(p.price*o.quantity)
from customers c
join orders o
on c.customer_id=o.customer_id
join products p
on o.customer_id=p.product_id
group by c.loyalty_member;


-- 27.Average spending of loyalty members vs non-members.

select loyalty_member, avg(customer_spending)
from
(select c.customer_id,c.loyalty_member,sum(p.price*o.quantity)as customer_spending
from customers c
join orders o
on c.customer_id=o.customer_id
join products p
on o.customer_id=p.product_id
group by c.loyalty_member,c. customer_id )as customer_totals
group by loyalty_member;




-- 28.Rank products by revenue.

select p.product_id,sum(p.price*o.quantity) as revenue
from products p
join orders o
on p.product_id=o.product_id
group by p.product_id
order by revenue desc ;

-- 29.Find the top-selling product in each category.

select p.category,sum(o.quantity) as number_of_times_sold
from products p
join orders o
on p.product_id=o.product_id
group by p.category
order by number_of_times_sold desc
limit 1;


-- 30.Identify the city generating the highest revenue.

select c.city,sum(p.price*o.quantity) as revenue
from customers c
join orders o
on c.customer_id=o.product_id
join products p
on o.product_id=p.product_id
group by c.city
order by revenue desc
limit 1;
