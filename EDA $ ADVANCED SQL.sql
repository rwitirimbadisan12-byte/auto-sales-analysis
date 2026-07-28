use sales; 

select round(sum(SALES),2) as total_sales    #### toal sales
from auto_sales;

### total number of orders
select count(distinct ORDERNUMBER)
as total_orders
from auto_sales;

#### TOTAL REVENUE BY PRODUCT LINE
SELECT PRODUCTLINE, ROUND(SUM(SALES), 2) AS
total_sales from auto_sales GROUP BY PRODUCTLINE
ORDER BY total_sales DESC;

###  TOP 10 CUSTOMERS BY SALES
 SELECT CUSTOMERNAME, ROUND(SUM(SALES), 2) AS 
 total_sales
 from auto_sales group by CUSTOMERNAME
 ORDER BY total_sales desc limit 10;
 
 select 
 monthname(ORDERDATE)
 AS month, round(sum(SALES), 2) AS
 total_sales
 from auto_sales
 group by MONTH(ORDERDATE), MONTHNAME(ORDERDATE)
 ORDER BY MONTH(ORDERDATE);
 
DESCRIBE auto_sales;

SELECT
    MONTHNAME(STR_TO_DATE(ORDERDATE, '%d/%m/%Y')) AS month,
    ROUND(SUM(SALES), 2) AS total_sales
FROM auto_sales
GROUP BY MONTH(STR_TO_DATE(ORDERDATE, '%d/%m/%Y')),
         MONTHNAME(STR_TO_DATE(ORDERDATE, '%d/%m/%Y'))
ORDER BY MONTH(STR_TO_DATE(ORDERDATE, '%d/%m/%Y'));

SELECT ORDERDATE
FROM auto_sales
WHERE STR_TO_DATE(ORDERDATE, '%d/%m/%Y') IS NULL;

#### monthly sales trend
SELECT
    MONTHNAME(STR_TO_DATE(ORDERDATE, '%m/%d/%Y')) AS month,
    ROUND(SUM(SALES), 2) AS total_sales
FROM auto_sales
GROUP BY
    MONTH(STR_TO_DATE(ORDERDATE, '%m/%d/%Y')),
    MONTHNAME(STR_TO_DATE(ORDERDATE, '%m/%d/%Y'))
ORDER BY
    MONTH(STR_TO_DATE(ORDERDATE, '%m/%d/%Y'));
   
   ###  yearly sales trend
SELECT
    YEAR(STR_TO_DATE(ORDERDATE, '%m/%d/%Y')) AS year,
    ROUND(SUM(SALES), 2) AS total_sales
FROM auto_sales
GROUP BY YEAR(STR_TO_DATE(ORDERDATE, '%m/%d/%Y'))
ORDER BY year;

#### best selling product
select PRODUCTCODE,
ROUND(SUM(SALES), 2) AS total_sales
from auto_sales group by PRODUCTCODE
ORDER BY total_sales desc
limit 10;

##  best selling category
select PRODUCTLINE,
ROUND(SUM(SALES), 2) AS total_sales
from auto_sales group by PRODUCTLINE
ORDER BY total_sales desc;

### top 10 products by quantity sold
select PRODUCTCODE,
SUM(QUANTITYORDERED) AS total_quantity
from auto_sales group by PRODUCTCODE ORDER BY 
total_quantity desc limit 10;

### sale by deal size
select DEALSIZE,
ROUND(SUM(SALES), 2) AS total_sales
from auto_sales group by DEALSIZE
ORDER BY total_sales desc;

### order status distribution 
select STATUS,
COUNT(*) AS total_sales
Group by STATUS ORDER BY
total_sales desc;
select * from auto_sales;
##### ORDER STATUS DISTRIBUTION
SELECT
    STATUS,
    COUNT(*) AS total_orders
FROM auto_sales
GROUP BY STATUS
ORDER BY total_orders DESC;

### AVERAGE ORDER value
SELECT 
ROUND(AVG(SALES), 2) AS average_order_value
from auto_sales;

### top 10 cities by sale
select CITY, ROUND(SUM(SALES), 2) AS total_sales
from auto_sales GROUP BY CITY
ORDER BY total_sales desc
limit 10;
 
 ### COUNTRY SALES
 SELECT COUNTRY, 
 ROUND(SUM(SALES), 2) AS 
 total_sales
 from auto_sales group by COUNTRY
 ORDER BY total_sales desc
 limit 10;
 
 #### customers from highest to lowest by sales
 SELECT
    CUSTOMERNAME,
    ROUND(SUM(SALES), 2) AS total_sales,
    RANK() OVER (ORDER BY SUM(SALES) DESC) AS sales_rank
FROM auto_sales
GROUP BY CUSTOMERNAME;

#### TOP CUSTMER IN EACH COUNTRY
WITH customer_sales AS (
    SELECT
        COUNTRY,
        CUSTOMERNAME,
        ROUND(SUM(SALES), 2) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY COUNTRY
            ORDER BY SUM(SALES) DESC
        ) AS rn
    FROM auto_sales
    GROUP BY COUNTRY, CUSTOMERNAME
)

SELECT *
FROM customer_sales
WHERE rn = 1;
 
#### RUNNING TOTAL OF SALES BY MONTH OF EACH YEAR
SELECT
    YEAR(STR_TO_DATE(ORDERDATE, '%m/%d/%Y')) AS year,
    MONTHNAME(STR_TO_DATE(ORDERDATE, '%m/%d/%Y')) AS month,
    ROUND(SUM(SALES), 2) AS monthly_sales,
    ROUND(
        SUM(SUM(SALES)) OVER (
            PARTITION BY YEAR(STR_TO_DATE(ORDERDATE, '%m/%d/%Y'))
            ORDER BY MONTH(STR_TO_DATE(ORDERDATE, '%m/%d/%Y'))
        ),
        2
    ) AS running_total
FROM auto_sales
GROUP BY
    YEAR(STR_TO_DATE(ORDERDATE, '%m/%d/%Y')),
    MONTH(STR_TO_DATE(ORDERDATE, '%m/%d/%Y')),
    MONTHNAME(STR_TO_DATE(ORDERDATE, '%m/%d/%Y'))
ORDER BY
    year,
    MONTH(STR_TO_DATE(ORDERDATE, '%m/%d/%Y'));
    
##### HIGHEST SALE IN EACH PRODUCT LINE
WITH ranked_products AS (
    SELECT
        PRODUCTLINE,
        PRODUCTCODE,
        SALES,
        RANK() OVER (
            PARTITION BY PRODUCTLINE
            ORDER BY SALES DESC
        ) AS sales_rank
    FROM auto_sales
)

SELECT *
FROM ranked_products
WHERE sales_rank = 1;














































