# <p align="center" style="margin-top: 0px;">💰 Case Study #4 - Data Bank 💰
## <p align="center">  A. Customer Nodes Exploration


### 1. How many nodes are there on the Data Bank System?

Steps:

* Use COUNT DISTINCT to find the number of unique nodes

```sql
SELECT COUNT(DISTINCT node_id) AS unique_nodes
FROM customer_nodes;
```
### Output:
|unique_nodes |
| -- |
|5|

There are 5 unique nodes (branches) on the Data Bank System.
  
 ---

### 2. What is the number of nodes per region?

Steps:

* Use COUNT to get the number of nodes per region

```sql
SELECT c.region_id,
	   region_name,
	   COUNT(node_id) AS num_of_nodes
FROM customer_nodes c
INNER JOIN regions r
ON c.region_id = r.region_id
GROUP BY c.region_id, region_name
ORDER BY num_of_nodes DESC;
```

### Output:
region_id | region_name | num_of_nodes
-- | -- | -- 
1 | Australia | 770
2 | America | 735
3 | Africa | 714
4 | Asia | 665
5 | Europe | 616

Australia had the highest number of nodes (770), followed by America (735) with Europe having the least number of nodes (616).

---

### 3. How many customers are allocated to each region?

steps:

* Use COUNT DISTINCT to find the number of customers per region

```sql
SELECT cn.region_id,
	   region_name,
	   COUNT(DISTINCT customer_id) AS num_of_customers
FROM customer_nodes cn
INNER JOIN regions r
ON cn.region_id = r.region_id
GROUP BY cn.region_id, region_name
ORDER BY num_of_customers DESC;
```
### Output:

region_id | region_name | num_of_customers
-- | -- | -- 
1 | Australia | 110
2 | America | 105
3 | Africa | 102
4 | Asia | 95
5 | Europe | 88

Australia had the highest number of customers allocated to that region, followed by America while Europe had the least number of customers.

---

### 4. How many days on average are customers reallocated to a different region?

Steps:

* First of all, let''s look at the unique start dates and end dates

-- checking the unique start_date in the customer nodes table

```sql
SELECT DISTINCT start_date
FROM customer_nodes
ORDER BY start_date DESC;
```

-- checking the unique end_date in the customer nodes table

```sql
SELECT DISTINCT end_date
FROM customer_nodes
ORDER BY end_date DESC;
```
* the result shows there is an abnormal date which is '9999-12-31'
* the date is incorrect and might be a typo error  and therefore needs to be excluded from the query

```sql
SELECT AVG(DATEDIFF(DAY, start_date, end_date)) AS avg_number_of_day
FROM customer_nodes
WHERE end_date != '9999-12-31';
```
### Output:

|avg_number_of_day |
| -- |
|14|

It takes 14 days on average for customers to be reallocated to a different region.

---

### 5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

Steps:

* Use a CTE to find the difference between start_date and end_date
* Use PERCENTILE_CONT and WITHIN GROUP to find the median, 80th,and 95th percentile

```sql
WITH date_diff AS
(
	SELECT cn.customer_id,
		   cn.region_id,
		   r.region_name,
		   DATEDIFF(DAY, start_date, end_date) AS reallocation_days
	FROM customer_nodes cn
	INNER JOIN regions r
	ON cn.region_id = r.region_id
	WHERE end_date != '9999-12-31'
)

SELECT DISTINCT region_id,
	   region_name,
	   PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY reallocation_days) OVER(PARTITION BY region_name) AS median,
	   PERCENTILE_CONT(0.8) WITHIN GROUP(ORDER BY reallocation_days) OVER(PARTITION BY region_name) AS percentile_80,
	   PERCENTILE_CONT(0.95) WITHIN GROUP(ORDER BY reallocation_days) OVER(PARTITION BY region_name) AS percentile_95
FROM date_diff
ORDER BY region_name;
```
### Output:

region_id | region_name | median | percentile_80 | percentile_95
--| -- | -- | -- | --
1 | Africa | 15 | 24 | 28
2 | America | 15 | 23 | 28
3 | Africa | 15 | 23 | 28
4 | Australia | 15 | 23 | 28
5 | Europe | 15 | 24 | 28

The output shows that all the regions have same median and 95th percentile for the same reallocation days metric with Africa and Europe having 24 days as the 80th percentile and America, Asia and Australia having 23 days as the 80th percentile reallocation metric.
