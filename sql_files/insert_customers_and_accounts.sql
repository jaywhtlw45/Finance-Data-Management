-- Insert test customers
INSERT INTO Customer (first_name, last_name, email, date_of_birth, ssn) 
VALUES 
    ('Hudson', 'Darden', 'hudson@example.com', '1991-05-14', '111-11-1111'),
    ('Asterios', 'Sante', 'asterios@example.com', '1987-09-30', '222-22-2222'),
    ('Jaak', 'Pantelis', 'jaak@example.com', '1996-02-10', '333-33-3333');

--Insert extra info for customers
INSERT INTO CustomerExtended (address, city, state, phone_number)
VALUES
    ('1234 E Willow Ave', 'Fresno', 'California', '559-245-5522'),
    ('5721 N Palm Ave', 'Ontario', 'Ohio', '764-442-1621'),
    ('5210 W Dakota Ave', 'Houston', 'Texas', '411-286-8344');

-- Insert accounts for each customer
INSERT INTO Accounts (date_opened, date_closed, customer_id, type, name, balance)
VALUES
    (2008-11-01, 2019-02-06, 1, 'Checking', 'Hudson Checking', 1000.00),
    (20010-11-01, 2019-02-06, 1, 'Savings', 'Hudson Savings', 5000.00),
    (2009-12-01, NULL, 1, 'Investment', 'Hudson Investment', 10000.00),
    
    (2021-08-22, NULL, 2, 'Checking', 'Asterios Checking', 1500.00),
    (2021-08-22, NULL, 2, 'Savings', 'Asterios Savings', 7000.00),
    (2021-08-22, NULL, 2, 'Investment', 'Asterios Investment', 12000.00),
    
    (2019-02-06, NULL, 3, 'Checking', 'Jaak Checking', 2000.00),
    (2019-02-06, NULL, 3, 'Savings', 'Jaak Savings', 6000.00),
    (2019-02-06, NULL, 3, 'Investment', 'Jaak Investment', 8000.00);

