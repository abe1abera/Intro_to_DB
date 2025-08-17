-- ================================================
-- ALX Book Store Database
-- File: alx_book_store.sql
-- ================================================

-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS alx_book_store;

-- Step 2: Use the database
USE alx_book_store;

-- ================================================
-- Step 3: Create Tables
-- ================================================

-- Authors Table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(215) NOT NULL
);

-- Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(130) NOT NULL,
    author_id INT,
    price DOUBLE NOT NULL,
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) UNIQUE NOT NULL,
    address TEXT
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order_Details Table
CREATE TABLE Order_Details (
    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- ================================================
-- Step 4: Insert Sample Data
-- ================================================

-- Insert Authors
INSERT INTO Authors (author_name) 
VALUES ('J.K. Rowling'), 
       ('George R.R. Martin'), 
       ('Chinua Achebe');

-- Insert Books
INSERT INTO Books (title, author_id, price, publication_date) 
VALUES ('Harry Potter and the Philosopher''s Stone', 1, 20.50, '1997-06-26'),
       ('A Game of Thrones', 2, 25.00, '1996-08-06'),
       ('Things Fall Apart', 3, 15.75, '1958-01-01');

-- Insert Customers
INSERT INTO Customers (customer_name, email, address) 
VALUES ('Alice Johnson', 'alice@example.com', '123 Elm Street'),
       ('Bob Smith', 'bob@example.com', '456 Oak Avenue');

-- Insert Orders
INSERT INTO Orders (customer_id, order_date) 
VALUES (1, '2025-08-17'), 
       (2, '2025-08-16');

-- Insert Order_Details
INSERT INTO Order_Details (order_id, book_id, quantity) 
VALUES (1, 1, 2), 
       (1, 3, 1), 
       (2, 2, 1);

-- ================================================
-- Step 5: Test Queries
-- ================================================

-- Get all books with author names
SELECT Books.title, Authors.author_name, Books.price
FROM Books
JOIN Authors ON Books.author_id = Authors.author_id;

-- Find the most expensive book
SELECT title, price 
FROM Books 
WHERE price = (SELECT MAX(price) FROM Books);

-- Find total amount spent in each order
SELECT Orders.order_id, Customers.customer_name, SUM(Order_Details.quantity * Books.price) AS order_total
FROM Order_Details
JOIN Books ON Order_Details.book_id = Books.book_id
JOIN Orders ON Order_Details.order_id = Orders.order_id
JOIN Customers ON Orders.customer_id = Customers.customer_id
GROUP BY Orders.order_id, Customers.customer_name;
