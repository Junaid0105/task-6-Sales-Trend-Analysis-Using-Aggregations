-- Query for delete table if any present by same name
Drop table if exists online_sales;

-- create new table 
create table online_sales(
	order_date date,
	product_id varchar(20) not null,
	sales numeric(10,2),
	order_id varchar(20) not null
);

select * from online_sales

-- Copy data into table from csv file
COPY
online_sales (order_date, product_id, sales, order_id)
from 'E:/Internship/Sales_Data_Analysis.csv'
delimiter','
csv header;

-- Sales Trend Analysis: Monthly Revenue and Order Volume
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(sales) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM
    online_sales
WHERE
    order_date BETWEEN '2011-01-01' AND '2014-12-31'
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    year,
    month;

-- save output table in csv format
copy(SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(sales) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM
    online_sales
WHERE
    order_date BETWEEN '2011-01-01' AND '2014-12-31'
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    year,
    month) to 'E:/Internship/online_sales_output.csv' delimiter',' csv header;

