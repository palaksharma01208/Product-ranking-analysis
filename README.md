# Product-ranking-analysis
This analysis helps businesses focus on high-revenue products, improve inventory planning, and design better marketing strategies.  

## Project Overview
This project analyzes product performance by ranking products based on total revenue. Using SQL Window Functions like RANK(), DENSE_RANK(), and ROW_NUMBER(), it identifies top-selling products and category-wise best performers. This analysis helps businesses focus on high-revenue products, improve inventory planning, and design better marketing strategies.

## Tables Used
- **Products** (ProductID, ProductName, Category, Price)
- **Sales** (SaleID, ProductID, Quantity, SaleDate)

## Key Concepts Used
- JOIN
- GROUP BY + SUM()
- Window Functions: RANK(), DENSE_RANK(), ROW_NUMBER()
- PARTITION BY
- CTE (Common Table Expression)
- Subquery

## Key Queries Covered
1. Total Revenue per Product
2. Overall Product Ranking using RANK()
3. Dense Ranking without gaps using DENSE_RANK()
4. Top 3 Products in Each Category using ROW_NUMBER()
5. Top 5 Products using CTE
6. Category-wise Best Product

## Business Insights
- Identify which products generate the highest revenue.
- Understand category leaders to plan stock and promotions.
- Help management take data-driven decisions for marketing and inventory.
