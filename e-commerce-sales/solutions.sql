1. Monthly Order Trends:-
select 
year(InvoiceDate) as yr, month(InvoiceDate) as mnt, count(distinct InvoiceNo) as tot_ord from sales_data
where InvoiceNo NOT like 'c%' group by yr,mnt 
order by yr,mnt;

2. Montly revenue:-
select 
year(InvoiceDate) as yr, month(InvoiceDate) as mnt, round(sum(UnitPrice*Quantity)) as net_rev from sales_data
group by yr,mnt 
order by yr,mnt;


3. Top 5 Best-Selling Products by Quantity:-
select
StockCode, Description , sum(quantity) as tot from sales_data
where InvoiceNo NOT like 'c%'
AND Description IS NOT NULL
AND TRIM(Description) <> '' 
group by Description, StockCode
order by tot desc, StockCode asc
limit 5; 

4.Top 5 Products by Revenue:-
select
StockCode, Description, round(sum(UnitPrice*Quantity)) as net_rev from sales_data
where Description is not null
and trim(Description) <> ''
group by StockCode, Description
order by net_rev desc, StockCode asc
limit 5;

5. Top 5 Revenue-Generating Countries:-
select country, round(sum(UnitPrice*Quantity)) as tot_rev from sales_data
where Country is not null and trim(country) <> ''
group by country order by tot_rev desc
limit 5;

6. Top 5 Highest-Spending Customers:-
select customerID, round(sum(UnitPrice*Quantity)) as net_spend from sales_data
where CustomerID is not null and trim(CustomerID) <> ''
group by customerID order by net_spend desc
limit 5;

