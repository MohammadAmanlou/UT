# <p align="center" style="margin-top: 0px;">💰 Case Study #4 - Data Bank 💰
## <p align="center"> D. Extra Challenge

Data Bank wants to try another option which is a bit more difficult to implement - they want to calculate data growth
using an interest calculation, just like in a traditional savings account you might have with a bank.

If the annual interest rate is set at 6% and the Data Bank team wants to reward its customers by increasing their data allocation based off the interest calculated on a daily basis at the end of each day, how much data would be required for this option on a monthly basis?

**Special notes:**

Data Bank wants an initial calculation which does not allow for compounding interest, however they may also be interested in a daily compounding interest calculation so you can try to perform this calculation if you have the stamina!

Steps:

* Use a CTE to calculate the daily interest data for each trasaction of each customer. In the CTE;

  * The total_data column is calculated by using the SUM function to add up all the transaction amounts for the customer up to the transaction date.

  * The month_start column is calculated using the DATEFROMPARTS function to create a new date that represents the first day of the month in which the transaction occurred. This is done by taking the year and month from the txn_date column and setting the day to 1.

  * The days_in_month column is calculated using the DATEDIFF function to find the number of days between the transaction date and the first day of the month in which the transaction occurred.

  * The daily_interest column is calculated using the formula for daily compounding interest: P*(1+r/n)^n*t, where P is the total data used by the customer up to the transaction date, r is the annual interest rate (^%), n is the number of days in a year (365), and t is the number of days between January 1, 1900, and the transaction date. The POWER function is used to calculate (1+r/n)^n, and the DATEDIFF function is used to calculate t.

* In the main query, use the CTE to group the daily interest data by customer id and month, and calculate the monthly data requirement by multiplying
the daily interest data by the number of days in the month (days_in_month) and summing the results. The resulting data_required column represents the 
estimated amount of data that each customer will need for each month, based on daily compounding interest.

```sql
WITH cte AS
(
	SELECT customer_id,
	       txn_date,
	       SUM(txn_amount) AS total_data,
	       DATEFROMPARTS(YEAR(txn_date), MONTH(txn_date), 1) AS month_start_date,
	       DATEDIFF(DAY, DATEFROMPARTS(YEAR(txn_date), MONTH(txn_date), 1), txn_date) AS days_in_month,
	       CAST(SUM(txn_amount) AS DECIMAL(18, 2)) * POWER((1 + 0.06/365), DATEDIFF(DAY, '1900-01-01', txn_date)) AS daily_interest_data
	FROM customer_transactions
	GROUP BY customer_id, txn_date
	--ORDER BY customer_id
)

SELECT customer_id,
       DATEFROMPARTS(YEAR(month_start_date), MONTH(month_start_date), 1) AS txn_month,
       ROUND(SUM(daily_interest_data * days_in_month), 2) AS data_required
FROM cte
GROUP BY customer_id, DATEFROMPARTS(YEAR(month_start_date), MONTH(month_start_date), 1)
ORDER BY data_required DESC 
```

### Ouput:
*Kindly note that this is not the entire output. The entire output is long and will take up space.*
	
customer_id | txn_month | data_required_by_month |
-- | -- | --
61 | 2020-03-01	| 192742529.490000
82 | 2020-01-01 | 182300489.170000
424 |	2020-02-01 | 148770273.040000
5 |	2020-03-01 | 147175039.370000
155 | 2020-03-01 | 133708153.980000
131	| 2020-01-01 | 131746424.050000
192	| 2020-02-01 | 131322690.730000
45 | 2020-01-01	| 130152124.870000
177	| 2020-03-01 | 129305100.330000
269	| 2020-01-01 | 128073677.610000

Insights:

* The output shows the estimated data required for each customer on a monthly basis, based on an interest rate of 6% per year,
calculated on a daily basis. This means that the data allocation of each customer will grow over time, similar to how a savings
account would earn interest.

* This presents an opportunity for the data bank team to incentivize customers to perform more transactions and increase their data allocation over time. This feature can be marketed to customers as a way to earn more data by simply performing transactions and keeping their accounts active. Additionally, this feature can help increase customer retention and loyalty by rewarding active customers with increased data allocation.
