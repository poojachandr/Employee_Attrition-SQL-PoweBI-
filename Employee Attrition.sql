use assignment

select *from attrition

EXEC sp_rename 'attrition', 'hr'

select *from hr


--Overall attrition happened in the company
select count(case when attrition='1' then 1 end) as attritioncount,
       count(*) as total_employees
from HR;

---Presence of overtime and correlation in attrition
select overtime,count(*) as total_employees
from hr
where attrition = 1
group by overtime

-- 237 left the company (127 people have done overtime and 110 has not so it is not the contributing factor)

--Gender distribution in the company

select gender,count(*) from hr
group by gender;

select gender,count(*) from hr
where attrition = 1
group by gender;

-- out of 558 female 87 left company & 882 male 150 people left the company

select performancerating,count(*) as total_employee 
from hr
group by performancerating


--There is a positive corelation amongst performance rating & attrition
select performancerating,count(case when Attrition = 1 then 1 end) as attrition_count 
from hr
group by performancerating

---Attrition count based on the job roles
select jobrole,count(*) as attrition_count
from hr
where attrition = 1
group by jobrole
order by attrition_count desc

--Attrition count based on distance from home variable 
select distancefromhome , count(*) as attrition_count
from hr
where attrition = 1
group by distancefromhome 
order by attrition_count desc

--till now performance rating and job role is the most important parameter

select department,jobrole,count(*) as attrition_count
from hr
where attrition = 1
group by jobrole,Department
order by attrition_count desc

--Relation between salary and attrition 
select percentsalaryhike, count(*) as attrition_count
from hr
where attrition = 1
group by percentsalaryhike

--there is a negative correlation,lower salaryhike more attritioncount 

---Education field is related to attrition count or not 
select educationfield , count(*) as attrition_count
from hr
where attrition = 1
group by educationfield
order by attrition_count desc

--those who have more option means higher education more chance of attrition 

--Relation between years ub current role and attrition count

select yearsincurrentrole, count(case when attrition =1 then 1 end)as attrition_count from hr
where yearsincurrentrole > (select avg(yearsincurrentrole) from hr)
group by yearsincurrentrole
order by attrition_count desc
--employees who are working in the company from last 5-10 years have the highest attrition count

--Job satisfaction and monthly income

select jobsatisfaction, count(*) as attrition_count
from hr 
where attrition = 1 and monthlyIncome < (Select avg(monthlyincome) from HR)
group by JobSatisfaction
--monthly income plays a vital role in attrition count irrespective the satisfaction from the job is on the
--higher side 

--employee attrition based on the age range 
select case when age <= 29 then '18-29'
                                when age >= 30 and age <= 39 then '30-39'
								when age >= 40 and age <=49 then '40-49'
								when age >=50 and age <= 59 then '50-59'
								else '60 or older'
								end as 'age_range',count(*) as 'No. of attrition based on age range'
from hr
where attrition = 1 and yearsatcompany >=1
group by case when age <= 29 then '18-29'
                                when age >= 30 and age <= 39 then '30-39'
								when age >= 40 and age <=49 then '40-49'
								when age >=50 and age <= 59 then '50-59'
								else '60 or older'
								end
order by 'No. of attrition based on age range' desc;

select max(dailyrate) from hr
where attrition = 1;

select min(dailyrate) from hr
where attrition = 1;

select min(monthlyrate) from hr
where attrition = 1;

select max(monthlyrate) from hr
where attrition = 1;

select count(*) as 'attrition_count'
from hr
where attrition = 1 and dailyrate < (select avg(dailyrate) from hr) --and monthlyrate < (select avg(monthlyrate) from hr)

select count(*) as 'attrition_count'
from hr
where attrition = 1 and monthlyrate < (select avg(monthlyrate) from hr)


select count(*) as 'attrition_count'
from hr
where attrition = 1 and monthlyincome < (select avg(monthlyincome) from hr)

select *from hr

Select environmentsatisfaction , relationshipsatisfaction ,count(*) as 'Attrition_count'
from hr
where Attrition = 1
group by environmentsatisfaction , relationshipsatisfaction
order by 'Attrition_count' desc

--  environmentsatisfaction & relationshipsatisfaction doesn't play important role

select maritalstatus,count(*) as 'attrition_count'
from hr
where attrition = 1
group by MaritalStatus