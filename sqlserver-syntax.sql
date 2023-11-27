
---- QUERY 1 - FINAL ---- 

SELECT
	Categories.CategoryName,
    Categories.CategoryID,
    COUNT(Products.ProductID) AS NrProducts
FROM Categories
    JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryID, Categories.CategoryName
HAVING COUNT(Products.ProductID) < 10;

---- QUERY 2 - FINAL (questions - the sum(unitprice *quantity) vs the unitprice * quantity. ---- 

SELECT TOP 10
    Customers.CustomerID,
    Customers.CompanyName,
    SUM(od.UnitPrice * od.Quantity) AS MoneySpent
FROM Customers
JOIN 
	Orders ON Customers.CustomerID = Orders.CustomerID
JOIN 
	[Order Details] od ON Orders.OrderID = od.OrderID
GROUP BY Customers.CustomerID, Customers.CompanyName
ORDER BY MoneySpent DESC;

---- QUERY 3  (questions - the sum(unitprice *quantity) vs the unitprice * quantity ---- 

SELECT TOP 15 
    Orders.OrderID,
    Customers.CompanyName,
    SUM(od.UnitPrice * od.Quantity) AS OrderCost
FROM Orders
    JOIN Customers ON Orders.CustomerID = Customers.CustomerID
    JOIN[Order Details] od ON Orders.OrderID = od.OrderID
GROUP BY
    Orders.OrderID,
    Customers.CompanyName
ORDER BY OrderCost DESC;

---- QUERY 4 ---- 

SELECT
    c.CustomerID AS CustomerID,
    c.CompanyName AS CustomerName,
    c.Address AS CustomerAddress,
    e.EmployeeID AS EmployeeID,
    e.LastName AS EmployeeLastName,
    e.Address AS EmployeeAddress
FROM
    Customers c
    JOIN Employees e ON c.City = e.City AND LEFT(c.Address, 1) = LEFT(e.Address, 1);

---- QUERY 5 ---- 

SELECT
    c.City,
    MONTH(o.OrderDate) AS MHNAS,
    SUM(od.UnitPrice * od.Quantity) AS CityCost,
    COUNT(o.OrderID) AS Paraggelies
FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City, MONTH(o.OrderDate)
ORDER BY c.City ASC, MHNAS ASC;

---- QUERY 6 ---- 

WITH MonthlyTotalCosts AS (
    SELECT
        MONTH(o.OrderDate) AS MHNAS,
        SUM(od.UnitPrice * od.Quantity) AS TotalCost,
        MAX(od.UnitPrice * od.Quantity) AS HighestOrderCost
    FROM
        Orders o
        JOIN [Order Details] od ON o.OrderID = od.OrderID
    WHERE
        YEAR(o.OrderDate) = 1997
    GROUP BY
        MONTH(o.OrderDate)
)
, Top3Months AS (
    SELECT TOP 3
        MHNAS
    FROM
        MonthlyTotalCosts
    ORDER BY
        TotalCost DESC
)
SELECT
    m.MHNAS AS Month,
    m.HighestOrderCost AS HighestOrderCost
FROM
    MonthlyTotalCosts m
    JOIN Top3Months t ON m.MHNAS = t.MHNAS
ORDER BY
    m.HighestOrderCost DESC;


----

SELECT CategoryName, ProductName, ProductID, UnitsInStock
FROM Categories, Products