-- HOSPITAL MANAGEMENT SYSTEM PROJECT (SQLite)

-- 1. EMPLOYEE TABLE
CREATE TABLE Employee (
    emp_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    role TEXT NOT NULL,
    department TEXT NOT NULL,
    contact_number TEXT NOT NULL,
    hire_date DATE,
    salary INTEGER
);

INSERT INTO Employee VALUES
(1, 'Dr. Ayesha Khan', 'Doctor', 'Cardiology', '9998887770', '2021-06-15', 120000),
(2, 'Mr. Rohan Das', 'Nurse', 'Emergency', '9898989898', '2022-01-10', 45000);

-- 2. PATIENT TABLE
CREATE TABLE Patient (
    patient_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER,
    gender TEXT,
    admit_date DATE,
    doctor_id INTEGER,
    FOREIGN KEY (doctor_id) REFERENCES Employee(emp_id)
);

INSERT INTO Patient VALUES
(101, 'Rahul Mehta', 45, 'Male', '2023-07-01', 1),
(102, 'Sneha Roy', 32, 'Female', '2023-07-03', 1);

-- 3. BILLING DETAILS
CREATE TABLE Billing_details (
    bill_id INTEGER PRIMARY KEY,
    patient_id INTEGER,
    amount REAL,
    payment_status TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

INSERT INTO Billing_details VALUES
(1001, 101, 45000.00, 'Pending'),
(1002, 102, 23000.00, 'Paid');

-- 4. EXPENSE DETAILS
CREATE TABLE Expense_details (
    expense_id INTEGER PRIMARY KEY,
    expense_type TEXT,
    amount REAL,
    expense_date DATE
);

INSERT INTO Expense_details VALUES
(1, 'Electricity', 10000, '2023-06-01'),
(2, 'Medicine Purchase', 20000, '2023-06-15');

-- 5. LEAVE INFO
CREATE TABLE Leave_info (
    leave_id INTEGER PRIMARY KEY,
    emp_id INTEGER,
    leave_start DATE,
    leave_end DATE,
    reason TEXT,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);

INSERT INTO Leave_info VALUES
(1, 2, '2023-06-10', '2023-06-12', 'Medical');

-- 6. PAYROLL INFO
CREATE TABLE Payroll_info (
    payroll_id INTEGER PRIMARY KEY,
    emp_id INTEGER,
    month TEXT,
    net_salary INTEGER,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);

INSERT INTO Payroll_info VALUES
(1, 1, 'June', 120000),
(2, 2, 'June', 45000);

-- 7. STOCK DETAILS
CREATE TABLE Stock_details (
    stock_id INTEGER PRIMARY KEY,
    item_name TEXT,
    quantity INTEGER,
    expiry_date DATE
);

INSERT INTO Stock_details VALUES
(1, 'Paracetamol', 100, '2025-06-01'),
(2, 'Syringes', 300, '2024-10-01');

-- 🔍 POWERFUL QUERIES --

-- 1. Display All Employees
SELECT * FROM Employee;

-- 2. Join Patient with Their Assigned Doctor
SELECT P.*, E.name AS doctor_name 
FROM Patient P
JOIN Employee E ON P.doctor_id = E.emp_id;

-- 3. Show Pending and Unpaid Bills
SELECT * 
FROM Billing_details 
WHERE LOWER(payment_status) IN ('pending', 'unpaid');

-- 4. Show Total Salary Paid
SELECT SUM(net_salary) AS Total_Salary_Paid 
FROM Payroll_info;

-- 5. Show Stocks Expiring Within Next 1 Year from Today
SELECT * 
FROM Stock_details
WHERE expiry_date <= DATE('now', '+1 year');
