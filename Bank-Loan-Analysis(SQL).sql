create database bankloan;
use bankloan;
select * from finance_1;
select * from finance_2;
SELECT *
FROM finance_1 f1
INNER JOIN finance_2 f2
ON f1.id = f2.id;

-- 1.Year wise loan amount Stats
SELECT 
    YEAR(STR_TO_DATE(issue_d,'%d-%m-%Y')) AS Year,
    
    CONCAT(
        ROUND(
            (SUM(loan_amnt) * 100.0) /
            (SELECT SUM(loan_amnt) FROM finance_1),
        2),
    '%') AS Loan_Amount_Percentage,
    
    SUM(loan_amnt) AS Total_Loan_Amount
FROM finance_1
GROUP BY YEAR(STR_TO_DATE(issue_d,'%d-%m-%Y'))
ORDER BY Year;

-- 2.Grade and sub grade wise revol_bal
SELECT 
    f1.grade,
    f1.sub_grade,
    SUM(f2.revol_bal) AS Total_Revol_Balance
FROM finance_1 f1
INNER JOIN finance_2 f2
ON f1.id = f2.id
GROUP BY f1.grade, f1.sub_grade;

-- 3.Total Payment for Verified Status Vs Total Payment for Non Verified Status
SELECT 
    f1.verification_status,
    SUM(f2.total_pymnt) AS Total_Payment
FROM finance_1 f1
INNER JOIN finance_2 f2
ON f1.id = f2.id
GROUP BY f1.verification_status;

-- 4.State wise and month wise loan status
SELECT 
    addr_state,
    MONTH(STR_TO_DATE(issue_d,'%d-%m-%Y')) AS Month_No,
    loan_status,
    COUNT(*) AS Total_Loans
FROM finance_1
GROUP BY addr_state, Month_No, loan_status;

-- 5.Home ownership Vs last payment date stats
SELECT 
    f1.home_ownership,
    MAX(f2.last_pymnt_d) AS Last_Payment_Date,
    COUNT(*) AS Total_Customers
FROM finance_1 f1
INNER JOIN finance_2 f2
ON f1.id = f2.id
GROUP BY f1.home_ownership;

-- KPI cards
SELECT SUM(loan_amnt) AS Total_Loan_Amount,count(id) as Total_customers
FROM finance_1;

SELECT SUM(total_pymnt) AS Total_Payment
FROM finance_2;

SELECT ROUND(AVG(int_rate),2) AS Avg_Interest_Rate
FROM finance_1;

SELECT COUNT(*) AS Verified_Customers
FROM finance_1
WHERE verification_status = 'Verified';



 
