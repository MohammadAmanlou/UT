# <p align="center" style="margin-top: 0px;"> 💰 Case Study #4 - Data Bank 💰

<p align="center" style="margin-bottom: 0px !important;">
<img src="https://github.com/Chisomnwa/SQL-Challenge-Case-Study-4---Data-Bank/blob/main/Images/Data%20Bank%20Logo.png" width="540" height="540">

---
*This repository hosts the solutions to the 4th challenge (Week 4) of the 8 Weeks SQL Challenge by DannyMa. [Click here to view the full challenge](https://8weeksqlchallenge.com/case-study-4/)*

---
## 🧾 Table of Contents
- [Business Case](#business-case)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Available Data](#available-data)
- [Case Study Solutions](#case-study-solutions)
- [Extra Resources](#extra-resources)

   
## Business Case
There is a new innovation in the financial industry called Neo-Banks: new aged digital only banks without physical branches.

Danny thought that there should be some sort of intersection between these new age banks, cryptocurrency and the data world…so he decides to launch a new initiative - Data Bank!

Data Bank runs just like any other digital bank - but it isn’t only for banking activities, they also have the world’s most secure distributed data storage platform!

Customers are allocated cloud data storage limits which are directly linked to how much money they have in their accounts. There are a few interesting caveats that go with this business model, and this is where the Data Bank team need your help!

The management team at Data Bank want to increase their total customer base - but also need some help tracking just how much data storage their customers will need.

This case study is all about calculating metrics, growth and helping the business analyse their data in a smart way to better forecast and plan for their future developments!
   
   
---
## Entity Relationship Diagram
<p align="center" style="margin-bottom: 0px !important;">
<img src="https://github.com/Chisomnwa/SQL-Challenge-Case-Study-4---Data-Bank/blob/main/Images/ERD%20-%20%20Data%20Bank.png">
   
   
---
## Available Data
  
<details><summary>
    All datasets exist in database schema.
  </summary> 
  
 #### ``Table 1: Regions``
region_id | region_name
-- | --
1 | Africa
2 | America
3 | Asia
4 | Europe
5 | Oceania

#### ``Table 2: subscriptions``
*Note: this is only customer sample*
customer_id | region_id | node_id | start_date | end_date
-- | -- | -- | -- | --
1 | 3 | 4 | 2020-01-02 | 2020-01-03
2 | 3 | 5 | 2020-01-03 | 2020-01-17
3 | 5 | 4 | 2020-01-27 | 2020-02-18
4 | 5 | 4 | 2020-01-07 | 2020-01-19
5 | 3 | 3 | 2020-01-15 | 2020-01-23
6 | 1 | 1 | 2020-01-11 | 2020-02-06
7 | 2 | 5 | 2020-01-20 | 2020-02-04
8 | 1 | 2 | 2020-01-15 | 2020-01-28
9 | 4 | 5 | 2020-01-21 | 2020-01-25
10 | 3 | 4 | 2020-01-13 | 2020-01-14

#### ``Table 3: Customer Transactions``
*Note: this is only customer sample*
customer_id | txn_date | txn_type | txn_amount
-- | -- | -- | --
429 | 2020-01-21 | deposit | 82
155 | 2020-01-10 | deposit | 712
398 | 2020-01-01 | deposit | 196
255 | 2020-01-14 | deposit | 563
185 | 2020-01-29 | deposit | 626
309 | 2020-01-13 | deposit | 995
312 | 2020-01-20 | deposit | 485
376 | 2020-01-03 | deposit | 706
188 | 2020-01-13 | deposit | 601
138 | 2020-01-11 | deposit | 520

  </details>

   
---
## Case Study Solutions
- [Part A - Customer Nodes Exploration](https://github.com/Chisomnwa/SQL-Challenge-Case-Study-4---Data-Bank/blob/main/A.%20Customer%20Nodes%20Exploration.md)
- [Part B - Customer Transactions](https://github.com/Chisomnwa/SQL-Challenge-Case-Study-4---Data-Bank/blob/main/B.%20Customer_Transactions.md)
- [Part C -Data Allocation Challenge](https://github.com/Chisomnwa/SQL-Challenge-Case-Study-4---Data-Bank/blob/main/C.%20Data%20Allocation%20Challenge.md)
- [Part D - Extra Challenge](https://github.com/Chisomnwa/SQL-Challenge-Case-Study-4---Data-Bank/blob/main/D.%20Extra%20Challenge.md)
- [Part E - Extension Request (PowerPoint Presentation)](https://github.com/Chisomnwa/SQL-Challenge-Case-Study-4---Data-Bank/blob/main/E.%20Extension%20Request.md)
   
   
 ---
 ## Extra Resources
 - [Medium Article](https://medium.com/@chisompromise/8-week-sql-challenge-data-bank-abcfe0ea7722)
 - [Data Bank Dashboard - Visualizing Key Business Metrics and Insights](https://www.novypro.com/project/transaction-data-analysis-and-data-allocation)
   
   
 # <p align="center" style="margin-top: 0px;">For the Love of FinTech 🙌🥰😎💰
 
