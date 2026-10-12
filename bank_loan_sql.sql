CREATE DATABASE BankLoanAnalysis;
use BankLoanAnalysis; 

CREATE TABLE Bank_Loan_Default (
    ID INT,
    year INT,
    loan_limit VARCHAR(10),
    Gender VARCHAR(30),
    approv_in_adv VARCHAR(10),
    loan_type VARCHAR(20),
    loan_purpose VARCHAR(10),
    Credit_Worthiness VARCHAR(10),
    open_credit VARCHAR(10),
    business_or_commercial VARCHAR(20),
    loan_amount INT,
    rate_of_interest DECIMAL(10,4),
    Interest_rate_spread DECIMAL(10,4),
    Upfront_charges DECIMAL(12,2),
    term INT,
    Neg_ammortization VARCHAR(20),
    interest_only VARCHAR(20),
    lump_sum_payment VARCHAR(20),
    property_value DECIMAL(15,2),
    construction_type VARCHAR(10),
    occupancy_type VARCHAR(10),
    Secured_by VARCHAR(10),
    total_units VARCHAR(10),
    income DECIMAL(12,2),
    credit_type VARCHAR(10),
    Credit_Score INT,
    co_applicant_credit_type VARCHAR(10),
    age VARCHAR(20),
    submission_of_application VARCHAR(20),
    LTV DECIMAL(15,4),
    Region VARCHAR(30),
    Security_Type VARCHAR(20),
    Status INT,
    dtir1 DECIMAL(10,2),

    loan_to_property_ratio DECIMAL(15,4),
    loan_to_property_group VARCHAR(20),
    credit_score_group VARCHAR(20),
    dtir_group VARCHAR(20),
    loan_amount_group VARCHAR(20),
    income_group VARCHAR(20),

    interest_rate_missing INT,
    upfront_charges_missing INT,
    property_value_missing INT,
    dtir1_missing INT,
    financial_missing_count INT
);

ALTER TABLE dbo.Bank_Loan_Default
ALTER COLUMN rate_of_interest DECIMAL(10,4) NULL;

EXEC sp_help 'dbo.Bank_Loan_Default';

SELECT COUNT(*) AS Total_Rows
FROM dbo.[Bank_Loan_Default_Cleaned];


SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '%Bank_Loan_Default%';

SELECT
    Status,
    COUNT(*) AS Loan_Count
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY Status
ORDER BY Status;

SELECT
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned;

-- Overall Default Rate
SELECT
    Status,
    COUNT(*) AS Loan_Count
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY Status;

SELECT
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned;

-- Default Rate by Loan Type
SELECT
    loan_type,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY loan_type
ORDER BY Default_Rate DESC;


--Default Rate by Income Group
SELECT
    income_group,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY income_group
ORDER BY Default_Rate DESC;


SELECT
    COUNT(*) AS Missing_Income,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted,
    AVG(income) AS Average_Income
FROM dbo.Bank_Loan_Default_Cleaned
WHERE income_group IS NULL;

-- Default Rate by Credit Score Group
SELECT
    credit_score_group,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY credit_score_group
ORDER BY Default_Rate DESC;


-- Default Rate by Loan Purpose
SELECT
    loan_purpose,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY loan_purpose
ORDER BY Default_Rate DESC;


--Default Rate by Loan Limit
SELECT
    loan_limit,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY loan_limit
ORDER BY Default_Rate DESC;

-- Default Rate by DTIR Group
SELECT
    dtir_group,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY dtir_group
ORDER BY Default_Rate DESC;

-- Default Rate by Loan Amount Group
SELECT
    loan_amount_group,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY loan_amount_group
ORDER BY Default_Rate DESC;

-- Default Rate by Loan-to-Property Ratio Group
SELECT
    loan_to_property_group,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY loan_to_property_group
ORDER BY Default_Rate DESC;

-- Default Rate by Age Group
SELECT
    age,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY age
ORDER BY Default_Rate DESC;

-- Default Rate by Region
SELECT
    Region,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY Region
ORDER BY Default_Rate DESC;

-- Default Rate by Gender
SELECT
    Gender,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY Gender
ORDER BY Default_Rate DESC;

-- Default Rate by Approval Status
SELECT
    approv_in_adv,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY approv_in_adv
ORDER BY Default_Rate DESC;

-- Default Rate by Business/Commercial Loan
SELECT
    business_or_commercial,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY business_or_commercial
ORDER BY Default_Rate DESC;

-- Default Rate by Interest-Only Status
SELECT
    interest_only,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY interest_only
ORDER BY Default_Rate DESC;

-- Default Rate by Negative Amortization
SELECT
    Neg_ammortization,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY Neg_ammortization
ORDER BY Default_Rate DESC;


-- Default Rate by Lump-Sum Payment.
SELECT
    lump_sum_payment,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY lump_sum_payment
ORDER BY Default_Rate DESC;

-- Default Rate by Occupancy Type
SELECT
    occupancy_type,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY occupancy_type
ORDER BY Default_Rate DESC;


-- Default Rate by Interest-Only Status
SELECT
    interest_only,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY interest_only
ORDER BY Default_Rate DESC;

-- Default Rate by Credit Type
SELECT
    credit_type,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY credit_type
ORDER BY Default_Rate DESC;

-- Default Rate by Submission Method
SELECT
    submission_of_application,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) AS Defaulted_Loans,
    CAST(
        SUM(CASE WHEN Status = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Default_Rate
FROM dbo.Bank_Loan_Default_Cleaned
GROUP BY submission_of_application
ORDER BY Default_Rate DESC;