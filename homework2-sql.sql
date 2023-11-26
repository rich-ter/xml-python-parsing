---- 1 -----

SELECT
    c.CategoryID,
    c.CategoryName,
    COUNT(p.ProductID) AS NrProducts
FROM Categories c
    JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID;

---- 2 -----

SELECT
    c.CustomerID,
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity) AS MoneySpent
FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN `Order Details` od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
ORDER BY MoneySpent DESC
LIMIT 10;

---- 3 -----

SELECT
    o.OrderID,
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity) AS OrderCost
FROM Orders o
    JOIN Customers c ON o.CustomerID = c.CustomerID
    JOIN `Order Details` od ON o.OrderID = od.OrderID
GROUP BY
    o.OrderID,
    c.CompanyName
ORDER BY OrderCost DESC
LIMIT 15;

---- 4 -----

---- SOLUTION 1: JUST THE CITY ---

SELECT
    c.CustomerID,
    c.CompanyName,
    c.Address AS CustomerAddress,
    c.City AS CustomerCity,
    e.City AS EmployeeCity,
    e.EmployeeID,
    e.LastName AS EmployeeLastName,
    e.Address AS EmployeeAddress
FROM Customers c
    JOIN Employees e ON c.City = e.City

---- SOLUTION 2: CITY AND FIRST CHARACTER ---

SELECT
    cu.CustomerID,
    cu.CompanyName,
    cu.Address AS CustomerAddress,
    e.EmployeeID,
    e.LastName,
    e.Address AS EmployeeAddress
FROM Customers cu
    JOIN Employees e ON cu.City = e.City AND LEFT(cu.Address, 1) = LEFT(e.Address, 1);

---- 5 -----

---- SOLUTION MINE ---

SELECT c.City, MONTH(o.Date)

Orders.OrderDate FROM Orders;

---- SOLUTION SOLVED ---

SELECT
    c.City,
    MONTH(o.OrderDate) AS MHNAS,
    SUM(od.UnitPrice * od.Quantity) AS CityCost,
    COUNT(o.OrderID) AS Paraggelies
FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN `Order Details` od ON o.OrderID = od.OrderID
GROUP BY c.City, MHNAS
ORDER BY c.City ASC, MHNAS ASC;

---- 6 -----