use [Pizza DB]

--1.Total Revenue
select sum(total_price) as Total_Revenue from pizza_sales
--2.Average Order Value
select sum(total_price)/COUNT(distinct order_id) as Avg_order_value from pizza_sales
--3.Total pizza sold
select sum(quantity) as Total_Pizza_sold from pizza_sales
--4.Total orders placed
select COUNT(distinct order_id) as Total_orders from pizza_sales
--5.Avg Pizzas per orders
select cast(SUM(quantity) as int)/ cast(COUNT(distinct order_id)as int) as Avg_pizzaper_order from pizza_sales
--Daily trend
select DATENAME(DW,order_date) as order_day, COUNT(distinct order_id) as Total_orders from pizza_sales
group by  DATENAME(DW,order_date) order by Total_orders desc
--Hourly Trend
select DATEPART(hour, order_time) as order_hours, COUNT(distinct order_id)as Total_orders from pizza_sales
group by DATEPART(hour, order_time) order by DATEPART(hour, order_time)
--Percentage of sales by Pizza category
select pizza_category,sum(total_price) as Total_sales,
SUM(total_price) * 100 / (select sum(total_price)from pizza_sales ) as Percentage_Total_sales 
from pizza_sales 
group by pizza_category
/*Percentage of sales by Pizza category
#If where  clause is added to query make sure it is added to subquery aswell*/
select pizza_size,cast(SUM(total_price)as decimal(10,2)) as Total_sales,
cast(SUM(total_price) * 100 / (select sum(total_price)from pizza_sales where DATEPART(QUARTER,order_date)=1 )as decimal(10,2)) as Percentage_Total_sales 
from pizza_sales 
where DATEPART(QUARTER,order_date)=1
group by pizza_size order by Percentage_Total_sales desc
-- total pizzas sold by category
Select pizza_category,SUM(quantity) as total_sales  from pizza_sales
group by pizza_category
-- top 5 best seller of pizza sold
select top 5 pizza_name,SUM(quantity) as total_sales from pizza_sales group by pizza_name
order by total_sales Desc
-- bottom 5 best seller of pizza sold
select top 5 pizza_name,SUM(quantity) as total_sales from pizza_sales group by pizza_name
order by total_sales
--

