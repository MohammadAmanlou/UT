# <p align="center" style="margin-top: 0px;">💰 Case Study #4 - Data Bank 💰
## <p align="center">  B. Customer Transactions

### 1. What is the unique count and total amount for each transaction type?

Steps:

* Use COUNT to find the unique count of the transaction types

* Use SUM to find the total amount for each transaction type

```sql
SELECT txn_type,
       COUNT(*) AS unique_count,
       SUM(txn_amount) AS total_amount
FROM customer_transactions
GROUP BY txn_type
ORDER BY txn_type;
```
### Output:

txn_type | unique_count | total_amount
-- | -- |--
deposit | 2671 | 1359168
purchase | 1617 | 806537
withdrawal | 1580 | 793003

There were more deposits (2671) followed by purchases(1617)and then withdrawals (1580).

---

### 2. What is the average total historical deposit counts and amounts for all customers?

Steps:

* Create a CTE named deposit_summary that calculates the total deposit counts and amounts for each customer

* Use the deposit_summary CTE in the outer query to calculate the average total deposit counts and amounts 
for all customers using the AVG function. 

```sql
WITH deposit_summary AS
(
	SELECT customer_id,
	       txn_type,
	       COUNT(*) AS deposit_count,
	       MIN(txn_amount) AS deposit_amount
	FROM customer_transactions
	GROUP BY customer_id, txn_type
	
)

SELECT txn_type,
       AVG(deposit_count) AS avg_deposit_count,
       AVG(deposit_amount) AS avg_deposit_amount
FROM deposit_summary
WHERE txn_type = 'deposit'
GROUP BY txn_type;
```
-- OR

```sql
WITH deposit_summary AS
(
	SELECT customer_id,
	       COUNT(CASE WHEN txn_type = 'deposit' THEN 1 END) AS deposit_count,
	       SUM(CASE WHEN txn_type = 'deposit' THEN txn_amount END) AS deposit_amount
        FROM customer_transactions
        GROUP BY customer_id
)

SELECT txn_type,
       AVG(deposit_count) AS avg_depoist_count,
       AVG(deposit_amount) AS avg_deposit_amount
FROM deposit_summary;
```

### Output:

txn_type | avg_depost_count | avg_deposit_amount
-- | -- | --
deposit | 37 | 508

The average deposit count for a customer is 5 and the average deposit amount for a customer is 2,718.

---

### 3. For each month - how many Data Bank customers make more than 1 deposit and either one purchase or withdrawal in a single month?

Steps:

* Create a CTE named customer_activity that calculates the number of deposits, purchases and withdrawals for each customer for each month using the DATEPART and DATENAME functions to extract the month number 
and month name from the txn_date column.

* Use the main query to filter the customer activity CTE to include only customers who made more than 1 deposit
and either 1 purchase or 1 withdrawal in a single month.

* We then group the results by month number and month name and count the number of unique customers who meet this criterion.

```sql
WITH customer_activity AS
(
	SELECT customer_id,
	       DATEPART(MONTH, txn_date) AS month_id,
	       DATENAME(MONTH, txn_date) AS month_name,
	       COUNT(CASE WHEN txn_type = 'deposit' THEN 1 END) AS deposit_count,
	       COUNT(CASE WHEN txn_type = 'purchase' THEN 1 END) AS purchase_count,
	       COUNT(CASE WHEN txn_type = 'withdrawal' THEN 1 END) AS withdrawal_count
FROM customer_transactions
GROUP BY customer_id, DATEPART(MONTH, txn_date), DATENAME(MONTH, txn_date)
)

SELECT month_id,	
       month_name,
       COUNT(DISTINCT customer_id) AS active_customer_count
FROM customer_activity
WHERE deposit_count > 1
	AND (purchase_count > 0 OR withdrawal_count > 0)
GROUP BY month_id, month_name
ORDER BY active_customer_count DESC;
```

### Output:

month_id | month_name | active_customer_count
-- | -- | --
1 | March | 192
2 | February | 181
3 | January | 168
4 | April | 70

March had the highest number of customers (192) who had made more than 1 deposit and either 1 withdrawal or 1 deposit while April had the least number of such customers (70).

---

### 4. What is the closing balance for each customer at the end of the month?

Steps:

* Use a CTE to aggregate the customer transactions data by customer and by month.

* In the SELECT clause of the CTE,
  * Use the DATEADD function to truncate the txn_date column to the beginning of the month. This is done to group the transactions by month, regardlesss of the actual day of the month when the transaction was made.
  
  * Use the SUM function to calculate the total amount of transactions for each customer within each month.
   The CASE statement is used to distinguish deposits and withdrawals, so that withdrawals are substracted from
   the total amount.

* Use a final query to calculate the closing balance of a customer for a specific month, with the closing balance being the sum of all transaction amounts up to and including that month. In the final query:

  * Use the MONTH and DATENAME functions to extract the month id and name from the month_start column of the CTE.

  * Use the SUM function with the OVER clause to calculate the running total of the total_amount column for each customer, partitioned by the customer id and ordered by the month start. This running total gives the closing balance of each customer at the end of the month.

```sql
WITH cte AS
(
	SELECT customer_id,
	       DATEADD(MONTH, DATEDIFF(MONTH, 0, txn_date), 0) AS month_start,
	       SUM(CASE WHEN txn_type = 'deposit' THEN txn_amount ELSE -1 * txn_amount END) AS total_amount
	FROM customer_transactions
	GROUP BY customer_id, DATEADD(MONTH, DATEDIFF(MONTH, 0, txn_date), 0)
)

SELECT cte.customer_id,
       DATEPART(MONTH, cte.month_start) AS month,
       DATENAME(MONTH, cte.month_start) AS month_name,
       SUM(cte.total_amount) OVER(PARTITION BY cte.customer_id ORDER BY cte.month_start) AS closing_balance
FROM cte;
```

### Output:

**NOTE*** : *Not all output is displayed, considering the number of results that will take up space*

customer_id | month | month_name | closing_balance
-- | -- | -- | --
1 | 1 | January | 312
1 | 3 | March | -640
2 | 1 | January | 549
2 | 3 | March | 610
3 | 1 | January | 144
3 | 2 | February | -821
3 | 3 | March | -1222
3 | 4 | April | -729
4 | 1 | January | 848
4 | 3 | March | 655
5 | 1 | January | 954
5 | 3 | March | -1923
5 | 4 | April | -2413

---

### 5. What is the percentage of customers who increase their closing balance by more than 5%?

Steps:

* Use monthly_transaction CTE to calculate the total transactions for each customer for each month

* Use closing_balances CTE to calculate the closing balance for each customer for each month by summing up
the transactions from the previous months.

* Use pct_increase CTE to calculate the percentage increase in closing balance for each customer from the previous month.

* Use the pct_increase in the final query to calculate the perscentage of customers whose closing balance increased by
more than 5% compared to the previous month. It does this by counting the number of distinct customers whose pct_increase
is greater than 5 and by dividing that by the total number of distinct customers.

-- CTE 1: Monthly transactions of each customer

```sql
WITH monthly_transactions AS
(
	SELECT customer_id,
	       EOMONTH(txn_date) AS end_date,
	       SUM(CASE WHEN txn_type IN ('withdrawal', 'purchase') THEN -txn_amount
			ELSE txn_amount END) AS transactions
	FROM customer_transactions
	GROUP BY customer_id, EOMONTH(txn_date)
),
```
-- CTE 2: Claculate the closing balance for each customer for each month

```sql
closing_balances AS 
(
	SELECT customer_id,
	       end_date,
	       COALESCE(SUM(transactions) OVER(PARTITION BY customer_id ORDER BY end_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 0) AS closing_balance
	FROM monthly_transactions
),
```

-- CTE3: Calculate the percentage increase in closing balance for each customer for each month

```sql
pct_increase AS 
(
  SELECT customer_id,
         end_date,
         closing_balance,
         LAG(closing_balance) OVER (PARTITION BY customer_id ORDER BY end_date) AS prev_closing_balance,
         100 * (closing_balance - LAG(closing_balance) OVER (PARTITION BY customer_id ORDER BY end_date)) / NULLIF(LAG(closing_balance) OVER (PARTITION BY customer_id ORDER BY end_date), 0) AS pct_increase
 FROM closing_balances
)
```

-- Calculate the percentage of customers whose closing balance increased 5% compared to the previous month

```sql
SELECT CAST(100.0 * COUNT(DISTINCT customer_id) / (SELECT COUNT(DISTINCT customer_id) FROM customer_transactions) AS FLOAT) AS pct_customers
FROM pct_increase
WHERE pct_increase > 5;
```

### Output:

|pct_customers|
| -- |
|75.6|

75.6 percent of the customers had their closing balance increase by 5% compared to the previous month.



