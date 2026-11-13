-- ==========================================
-- PROJECT: Product Ranking Analysis
-- Database: MySQL
-- ==========================================

CREATE DATABASE ProductRankingDB;
USE ProductRankingDB;

-- 1. Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

-- 2. Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Sample Data Insert
INSERT INTO Products VALUES
(1, 'iPhone 15', 'Electronics', 80000),
(2, 'Samsung S24', 'Electronics', 70000),
(3, 'Nike Shoes', 'Fashion', 5000),
(4, 'Adidas Shoes', 'Fashion', 4500),
(5, 'Dell Laptop', 'Electronics', 60000),
(6, 'HP Laptop', 'Electronics', 55000),
(7, 'Levis Jeans', 'Fashion', 3000),
(8, 'Puma T-Shirt', 'Fashion', 1500);

INSERT INTO Sales VALUES
(1, 1, 10, '2024-01-05'),
(2, 2, 15, '2024-01-06'),
(3, 3, 30, '2024-01-07'),
(4, 4, 25, '2024-01-08'),
(5, 5, 8, '2024-01-09'),
(6, 6, 12, '2024-01-10'),
(7, 7, 40, '2024-01-11'),
(8, 8, 50, '2024-01-12'),
(9, 1, 5, '2024-01-13'),
(10, 3, 20, '2024-01-14');

-- ==========================================
-- QUERIES
-- ==========================================

-- Q1. Har Product ki Total Revenue nikalo
SELECT p.ProductName, p.Category,
SUM(p.Price * s.Quantity) AS TotalRevenue
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName, p.Category;

-- Q2. RANK() se saare Products ko Revenue ke hisaab se Rank karo
SELECT p.ProductName, p.Category,
SUM(p.Price * s.Quantity) AS TotalRevenue,
RANK() OVER (ORDER BY SUM(p.Price * s.Quantity) DESC) AS ProductRank
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName, p.Category;

-- Q3. DENSE_RANK() ka use - bina gap ke ranking
SELECT p.ProductName,
SUM(p.Price * s.Quantity) AS TotalRevenue,
DENSE_RANK() OVER (ORDER BY SUM(p.Price * s.Quantity) DESC) AS DenseRank
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;

-- Q4. ROW_NUMBER() - Har Category me Top 3 Products
SELECT * FROM (
SELECT p.ProductName, p.Category,
SUM(p.Price * s.Quantity) AS TotalRevenue,
ROW_NUMBER() OVER (PARTITION BY p.Category ORDER BY SUM(p.Price * s.Quantity) DESC) AS RowNum
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName, p.Category
) AS Ranked
WHERE RowNum <= 3;

-- Q5. CTE ka use karke Top 5 Products nikalo
WITH ProductRevenue AS (
SELECT p.ProductName, SUM(p.Price * s.Quantity) AS TotalRevenue
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName
)
SELECT *, RANK() OVER (ORDER BY TotalRevenue DESC) AS RankPosition
FROM ProductRevenue
LIMIT 5;

-- Q6. Category wise Best Product
SELECT Category, ProductName, TotalRevenue FROM (
SELECT p.Category, p.ProductName,
SUM(p.Price * s.Quantity) AS TotalRevenue,
RANK() OVER (PARTITION BY p.Category ORDER BY SUM(p.Price * s.Quantity) DESC) AS CategoryRank
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.Category, p.ProductName
) AS T
WHERE CategoryRank = 1;