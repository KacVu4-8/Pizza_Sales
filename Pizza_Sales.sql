
-- 1.Total Revenue: The sum of the total price of all pizza orders
Select SUM(total_price) As Total_Revenue From pizza_sales

-- 2. Average Order Value: The average amount spent per order, 
-- calculated by dividing the total revenue by the total number of orders
Select SUM(total_price) / COUNT(DISTINCT order_id) As Avg_Order_Value From pizza_sales

-- 3. Total Pizza Sold: The sum of the quantities of all pizza sold
Select SUM(quantity) As Total_Pizza_Sold From pizza_sales

-- 4. Total orders: The total number of orders placed
Select COUNT(DISTINCT order_id) As Total_Orders From pizza_sales

-- 5. Average Pizzas Per Order: The average number of pizzas sold per order, 
-- calculated by dividing the total number of pizzas sold by the total number of orders
Select CAST(CAST(SUM(quantity) As DECIMAL(10,2)) /
		CAST(COUNT(DISTINCT order_id) As DECIMAL(10,2)) As DECIMAL(10,2)) As Avg_Pizza_Per_Order 
From pizza_sales


-- 6. Create a bar chart that displays the daily trend of total orders over a specific time period. 
-- This chart will help us identify any patterns or fluctuations in order volumes on a daily basis
SELECT DATENAME(DW, CONVERT(DATE, order_date, 103)) AS Order_Day, 
       COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(DW, CONVERT(DATE, order_date, 103));

-- 7. Hourly Trend for Total Orders: Create a line chart that illustrates the hourly trend of total orders 
-- throughout the day. This chart will allow us to identify peak hours or periods of high order activity.
SELECT DATENAME(MONTH, CONVERT(DATE, order_date, 103)) AS Month_Name, 
       COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(MONTH, CONVERT(DATE, order_date, 103));


-- 8. Total Pizzas Sold by Pizza Category: Create a funnel chart that presents the total 
-- number of pizzas sold for each pizza category. This chart will allow us to compare 
-- the sales performance of different pizza categories.
Select pizza_category, CAST(SUM(total_price) As DECIMAL(10,2)) As Total_Revenue, 
	CAST(SUM(total_price)  * 100 / (Select SUM(total_price) From pizza_sales) as DECIMAL(10,2)) As PCT 
From pizza_sales
Group By pizza_category


-- 9. Percentage of Sales by Pizza Size: Generate a pie chart that 
-- represents the percentage of sales attributed to different pizza sizes. 
-- This chart will help us understand customer preferences for pizza sizes and their impact on sales.
Select pizza_size, CAST(SUM(total_price) As DECIMAL(10,2)) As Total_Revenue, 
	CAST(SUM(total_price)  * 100 / (Select SUM(total_price) From pizza_sales) as DECIMAL(10,2)) As PCT 
From pizza_sales
Group By pizza_size
Order By pizza_size 

-- 11. Top 5 Pizzas by Revenue
Select Top 5 pizza_name, SUM(total_price) As Total_Revenue From pizza_sales
Group By pizza_name 
Order By Total_Revenue Desc

-- 12. Bottom 5 Pizzas by Revenue
Select Top 5 pizza_name, SUM(total_price) As Total_Revenue From pizza_sales
Group By pizza_name 
Order By Total_Revenue Asc

-- 13. Top 5 Pizzas by Quantity
Select Top 5 pizza_name, SUM(quantity) As Total_Quantity From pizza_sales
Group By pizza_name 
Order By Total_Quantity Desc

-- 14. Bottom 5 Pizzas by Quantity
Select Top 5 pizza_name, SUM(quantity) As Total_Quantity From pizza_sales
Group By pizza_name 
Order By Total_Quantity Asc

-- 15. Top 5 Pizzas by Total Orders
Select Top 5 pizza_name, COUNT(Distinct order_id) As Total_Orders From pizza_sales
Group By pizza_name 
Order By Total_Orders Desc

-- 15. Bottom 5 Pizzas by Total Orders
Select Top 5 pizza_name, COUNT(Distinct order_id) As Total_Orders From pizza_sales
Group By pizza_name 
Order By Total_Orders Asc