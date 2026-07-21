 1.Overall Attrition Rate:-
select * from ibm_hr_attrition_raw;

select round(100*sum(case when attrition='Yes' then 1 else 0 end)/count(*)) as rate from ibm_hr_attrition_raw;

2. Department-wise Attrition:-
select department, count(*) as att_cnt from ibm_hr_attrition_raw
where attrition='Yes' group by department order by att_cnt desc;

3. Average Monthly Income: Exited vs Retained:-
select attrition, round(avg(MonthlyIncome)) from ibm_hr_attrition_raw
group by attrition;

4. Attrition by Age Group:-
-- Group employees into age bands (`<30`, `30–40`, `40–50`, `50+`) and show attrition counts
select 
case 
when Age < 30 then '<30'
when Age between 30 and 40 then '30-40'
when Age between 40 and 50 then '40-50'
else '50+' end as age_limit,
count(*) as tot_att from ibm_hr_attrition_raw
group by age_limit order by age_limit;

5. Education Field and Attrition:-
-- Which education field has the highest attrition?
select EducationField, count(*) as tot_att from ibm_hr_attrition_raw
where attrition='yes'
group by EducationField order by tot_att desc;

 6. Average Tenure of Exited Employees:-
-- On average, how many years did employees stay before leaving?
SELECT 
ROUND(AVG(YearsAtCompany), 1) AS avg_years_before_exit
FROM ibm_hr_attrition_raw
WHERE Attrition = 'Yes';
