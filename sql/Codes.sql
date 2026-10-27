-- Database setup: Create and select the database for the supply chain project
CREATE DATABASE suppy_chain_analytics;
USE suppy_chain_analytics;

-- View all records from the supply chain table
SELECT * FROM supply_chain;

-- Check the total number of columns in the supply_chain table
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_schema = 'suppy_chain_analytics'
  AND table_name = 'supply_chain';

-- Challenge 1: Count orders by delivery status
-- Business question: How many orders fall into each delivery status?
  SELECT delivery_status, COUNT(order_id) AS Number_of_orders 
  FROM supply_chain
  GROUP BY delivery_status;

-- Challenge 2: Analyze the distribution of late and non-late deliveries
-- Business question: What percentage of all orders are late versus not late?
  SELECT late_delivery, COUNT(order_id) AS Number_of_orders,
  ROUND (COUNT(order_id) * 100 / (SELECT COUNT(*) FROM supply_chain),2) AS Percentage
  FROM supply_chain 
  GROUP BY late_delivery;

-- Challenge 3: Analyze late deliveries by shipping method
-- Business question: How many orders are late for each shipping method, and what is the late-delivery percentage?
  SELECT shipping_method, COUNT(order_id) AS total_orders, 
  SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) AS late_deliveries,
ROUND((SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END)* 100)/ COUNT(order_id),2) AS Percentage
  FROM supply_chain 
  GROUP BY shipping_method;

-- Challenge 4: Analyze late deliveries by distance band
-- Business question: Which distance bands have the highest late-delivery percentages?
  SELECT distance_band, COUNT(order_id) AS total_orders,
  SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) AS Late_deliveries,
  ROUND(SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END * 100) / COUNT(order_id),2) AS Percentage
  FROM supply_chain 
  GROUP BY distance_band
  ORDER BY Percentage DESC;

-- Challenge 5: Analyze late deliveries by warehouse processing band
-- Business question: Does late-delivery performance differ by warehouse processing time category?
  SELECT warehouse_processing_band, COUNT(order_id) AS total_orders,
  SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) AS number_of_late_orders,
  ROUND((SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) * 100) / COUNT(order_id),2) AS percentage
  FROM supply_chain 
  GROUP BY warehouse_processing_band
  ORDER BY percentage DESC;

-- Challenge 6: Analyze shipping costs by shipping method
-- Business question: What are the average, minimum, and maximum shipping costs for each method?
  SELECT shipping_method, COUNT(order_id) AS total_orders, ROUND(AVG(shipping_cost_usd),2) AS average_shipping_cost,
  MIN(shipping_cost_usd) AS minimum_shipping_cost, MAX(shipping_cost_usd) AS maximum_shipping_cost
  FROM supply_chain 
  GROUP BY shipping_method 
  ORDER BY average_shipping_cost DESC;

-- Challenge 7: Analyze shipping costs by distance band
-- Business question: How do average, minimum, and maximum shipping costs vary by distance category?
  SELECT distance_band, COUNT(order_id) AS total_orders, ROUND(AVG(shipping_cost_usd),2) AS average_shipping_cost,
  MIN(shipping_cost_usd) AS minimum_shipping_cost, MAX(shipping_cost_usd) AS maximum_shipping_cost 
  FROM supply_chain
  GROUP BY distance_band 
  ORDER BY average_shipping_cost DESC;

-- Challenge 8: Analyze monthly order volume and shipping costs
-- Business question: How do total orders, total shipping costs, and average shipping costs change month by month?
  SELECT MONTHNAME(order_date) as months, COUNT(order_id) AS total_orders, ROUND(SUM(shipping_cost_usd),2) AS total_shipping_cost,
  ROUND(AVG(shipping_cost_usd),2) AS average_shipping_cost 
  FROM supply_chain 
  GROUP BY MONTHNAME(order_date), MONTH(order_date)
  ORDER BY MONTH(order_date);

-- Challenge 9: Analyze order volume and shipping costs by day of the week
-- Business question: Which weekdays have the most orders and the highest shipping costs?
  SELECT DAYNAME(order_date) days, COUNT(order_id) AS total_orders, ROUND(SUM(shipping_cost_usd),2) AS total_shipping_cost,
  ROUND(AVG(shipping_cost_usd),2) AS average_shipping_cost
  FROM supply_chain 
  GROUP BY DAYOFWEEK(order_date), DAYNAME(order_date)
  ORDER BY DAYOFWEEK(order_date); 

-- Challenge 10: Analyze performance by customer segment
-- Business question: How do order volume, shipping costs, and late deliveries differ across customer segments?
  SELECT customer_segment, COUNT(order_id) AS total_orders, ROUND(SUM(shipping_cost_usd),2) AS total_shipping_cost,
  ROUND(AVG(shipping_cost_usd),2) AS average_shipping_cost,
  SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) AS total_late_orders,
  ROUND((SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END * 100) / COUNT(order_id)),2) AS late_delivery_percentage
  FROM supply_chain 
  GROUP BY customer_segment;

-- Challenge 11: Analyze return reasons
-- Business question: Which return reasons occur most often, and what percentage of recorded return reasons does each represent?
  SELECT return_reason, COUNT(order_id) AS total_returns, 
  ROUND((COUNT(return_reason) * 100) / (SELECT COUNT(order_id) FROM supply_chain WHERE return_reason <> ''),2) AS percentage
  FROM supply_chain
  WHERE return_reason <> ''
  GROUP BY return_reason
  ORDER BY percentage DESC;

-- Challenge 12: Analyze performance by product category
-- Business question: How do order volume, order value, shipping costs, and late deliveries vary by product category?
  SELECT product_category, COUNT(order_id) AS total_orders, ROUND(SUM(order_value_usd),2) AS total_order_value, ROUND(AVG(order_value_usd),2) AS average_order_value,
  ROUND(SUM(shipping_cost_usd),2) total_shipping_cost,
  SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) AS number_of_late_orders,
  ROUND((SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) * 100) / COUNT(order_id),2) AS percentage
  FROM supply_chain 
  GROUP BY product_category;

-- Challenge 13: Analyze carrier performance
-- Business question: Which carriers have the highest late-delivery rates, and how do delivery time and customer ratings compare?
  SELECT carrier, COUNT(order_id) AS total_orders,
  SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) AS number_of_late_orders,
  ROUND((SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) * 100) / COUNT(order_id),2) AS late_delivery_percentage,
  ROUND(AVG(actual_delivery_days),2) avg_actual_delivery_days, ROUND(AVG(customer_rating),2) AS avg_customer_rating 
  FROM supply_chain 
  GROUP BY carrier
  ORDER BY late_delivery_percentage DESC;

-- Challenge 14: Analyze delivery performance by order priority
-- Business question: How do late-delivery rates, average delivery times, and shipping costs vary by order priority?
  SELECT order_priority, COUNT(order_id) AS total_orders,
  SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) AS late_orders, ROUND(SUM(CASE WHEN late_delivery = "Yes" THEN 1
  ELSE 0 
  END * 100) / COUNT(order_id),2) AS late_delivery_percentage,
  ROUND(AVG(actual_delivery_days),2) AS avg_delivery_days, 
  ROUND(AVG(shipping_cost_usd),2) AS avg_shipping_cost
  FROM supply_chain 
  GROUP BY order_priority
  ORDER BY late_delivery_percentage DESC;

-- Challenge 15: Analyze delivery performance by customer rating
-- Business question: How do average delays, late-delivery percentages, and shipping costs vary by customer rating?
  SELECT customer_rating, COUNT(order_id) AS total_orders, ROUND(AVG(delivery_delay_days),2) AS avg_delay_days, 
  ROUND(SUM(CASE WHEN late_delivery = "Yes" THEN 1
  ELSE 0 
  END * 100) / COUNT(order_id),2) AS late_delivery_percentage,
  ROUND(AVG(shipping_cost_usd),2) AS avg_shipping_cost
  FROM supply_chain 
  GROUP BY customer_rating
  ORDER BY customer_rating DESC;

-- Challenge 16: Analyze warehouse performance
-- Business question: How do order volume, processing hours, late deliveries, delays, and customer ratings vary by warehouse?
  SELECT warehouse_id, warehouse_city, COUNT(order_id) AS total_orders, ROUND(AVG(warehouse_processing_hours),2) AS avg_processing_hours,
  ROUND(SUM(CASE WHEN late_delivery = "Yes" THEN 1
  ELSE 0 
  END * 100) / COUNT(order_id),2) AS late_delivery_percentage,
  ROUND(AVG(delivery_delay_days),2) AS avg_delay_days,
  ROUND(AVG(customer_rating),2) AS avg_rating 
  FROM supply_chain
  GROUP BY warehouse_id, warehouse_city
  ORDER BY late_delivery_percentage DESC;

-- Challenge 17: Analyze delivery performance by weather condition
-- Business question: Which weather conditions are associated with the highest late-delivery rates and longest delivery times?
  SELECT weather_condition, COUNT(order_id) AS total_orders,
  SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) AS late_order_deliveries, ROUND(SUM(CASE WHEN late_delivery = "Yes" THEN 1
  ELSE 0 
  END * 100) / COUNT(order_id),2) AS late_delivery_percentage, ROUND(AVG(actual_delivery_days),2) AS avg_delivery_days,
  ROUND(AVG(delivery_delay_days),2) AS avg_delay_days
  FROM supply_chain 
  GROUP BY weather_condition
  ORDER BY late_delivery_percentage DESC;

-- Challenge 18: Analyze delivery attempts
-- Business question: How do the number of delivery attempts relate to late deliveries, delivery time, and customer ratings?
  SELECT delivery_attempts, COUNT(order_id) AS total_orders,
  SUM(CASE WHEN late_delivery = "Yes" THEN 1 
  ELSE 0 
  END) AS late_order_deliveries, ROUND(SUM(CASE WHEN late_delivery = "Yes" THEN 1
  ELSE 0 
  END * 100) / COUNT(order_id),2) AS late_delivery_percentage, ROUND(AVG(actual_delivery_days),2) AS avg_delivery_days,
  ROUND(AVG(customer_rating),2) AS avg_rating
  FROM supply_chain
  GROUP BY delivery_attempts
  ORDER BY delivery_attempts;

-- Challenge 19: Find the most common return reason within each product category
-- Business question: Which return reason has the highest number of occurrences in each category?
-- The CTE counts each category-reason combination, and RANK() identifies the most frequent reason(s).
 WITH return_counts AS (

    SELECT
        product_category,
        return_reason,
        COUNT(order_id) AS total_returns
    FROM supply_chain
    WHERE return_requested = 'Yes'
    GROUP BY
        product_category,
        return_reason
),
ranked_returns AS (
    SELECT
        product_category,
        return_reason,
        total_returns,
        RANK() OVER (
            PARTITION BY product_category
            ORDER BY total_returns DESC
        ) AS reason_rank
    FROM return_counts
)
SELECT
    product_category,
    return_reason,
    total_returns
FROM ranked_returns
WHERE reason_rank = 1
ORDER BY total_returns DESC;

-- Challenge 20: Analyze late deliveries by warehouse
-- Business question: Which warehouses have the highest late-delivery percentages?
SELECT warehouse_id, warehouse_city, COUNT(order_id) AS total_orders,
SUM(CASE WHEN late_delivery = "Yes" THEN 1
	ELSE 0
    END) AS late_deliveries, ROUND((SUM(CASE WHEN late_delivery = "Yes" THEN 1
	ELSE 0
    END) * 100) / COUNT(order_id),2) AS percentage
    FROM supply_chain 
    GROUP BY warehouse_id, warehouse_city
    ORDER BY percentage DESC;

-- Challenge 21: Analyze the distribution of orders by delay severity
-- Business question: How many orders fall into each severity category, and what percentage of all orders does each category represent?
SELECT delay_severity, COUNT(order_id) total_orders, ROUND(AVG(delivery_delay_days),2) AS avg_delay_days,
ROUND((COUNT(order_id) * 100) / SUM(COUNT(order_id)) OVER() ,2) AS percentage
FROM supply_chain 
GROUP BY delay_severity;   

-- Challenge 22: Compare average shipping cost with average order value by product category
-- Business question: Which categories have the highest shipping-cost-to-order-value ratio?
SELECT product_category, COUNT(order_id) AS total_orders, ROUND(AVG(shipping_cost_usd),2) AS avg_shipping_cost, ROUND(AVG(order_value_usd),2) AS avg_order_value,
ROUND((AVG(shipping_cost_usd) * 100) / AVG(order_value_usd),2) AS percentage 
FROM supply_chain 
GROUP BY product_category
ORDER BY percentage DESC;

-- Challenge 23: Analyze delivery performance by order priority
-- Business question: How do actual delivery time, delay days, and late-delivery rates compare across priorities?
SELECT order_priority, COUNT(order_id) AS total_orders, ROUND(AVG(actual_delivery_days),2) AS avg_actual_delivery_days, ROUND(AVG(delivery_delay_days),2) AS avg_delay_days,
SUM(CASE WHEN late_delivery = "Yes" THEN 1
	ELSE 0
    END) AS late_deliveries, ROUND((SUM(CASE WHEN late_delivery = "Yes" THEN 1
	ELSE 0
    END) * 100) / COUNT(order_id),2) AS percentage
    FROM supply_chain 
    GROUP BY order_priority
    ORDER BY avg_actual_delivery_days DESC;

-- Challenge 24: Analyze average shipping cost per kilometre by shipping method
-- Business question: Which shipping methods have the highest average cost per kilometre?
SELECT shipping_method, COUNT(order_id) AS total_orders, ROUND(AVG(distance_km),2) AS avg_distance, ROUND(AVG(shipping_cost_usd),2) AS avg_shipping_cost,
ROUND(AVG(shipping_cost_usd / distance_km),2) AS avg_cost_per_km
FROM supply_chain 
GROUP BY shipping_method
ORDER BY avg_cost_per_km DESC;