
---- QUERY 1 - FINAL ---- 

SELECT
	C.CategoryName,
    C.CategoryID,
    COUNT(P.ProductID) AS NrProducts
FROM Categories C
    JOIN Products P ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryID, C.CategoryName
HAVING COUNT(P.ProductID) < 10;

---- QUERY 2 - FINAL ---- 

SELECT TOP 10
    C.CustomerID,
    C.CompanyName,
    SUM(OD.UnitPrice * OD.Quantity) AS MoneySpent
FROM Customers C
JOIN 
	Orders O ON C.CustomerID = O.CustomerID
JOIN 
	[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY MoneySpent DESC;

---- QUERY 3 - FINAL ---- 

SELECT TOP 15 
    O.OrderID,
    C.CompanyName,
    SUM(OD.UnitPrice * OD.Quantity) AS OrderCost
FROM Orders O
    JOIN Customers C ON O.CustomerID = C.CustomerID
    JOIN[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY
    O.OrderID,
    C.CompanyName
ORDER BY OrderCost DESC;

---- QUERY 4 - FINAL ---- 

SELECT
    C.CustomerID,
    C.CompanyName,
    C.Address AS Address,
    E.EmployeeID,
    E.LastName,
    E.Address AS Address
FROM
    Customers c
JOIN Employees E ON C.City = E.City AND LEFT(C.Address, 1) = LEFT(e.Address, 1);



---------------------------------------------------------------------


---- QUERY 5 -  ---- 

---- QUERY 5 (Showing only months where orders are made in the month) ---- 

SELECT
    Customers.City,
    MONTH(o.OrderDate) AS MHNAS,
    SUM(od.UnitPrice * od.Quantity) AS CityCost,
    COUNT(o.OrderID) AS Paraggelies
FROM Customers
    JOIN Orders o ON Customers.CustomerID = o.CustomerID
    JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY Customers.City, MONTH(o.OrderDate)
ORDER BY Customers.City ASC, MHNAS ASC;



---- QUERY 5 - (Showing every month even if order is zero) ---- 
SELECT
    Cities.City,
    Months.MonthNumber AS MHNAS,
    COALESCE(SUM(od.UnitPrice * od.Quantity), 0) AS CityCost,
    COUNT(o.OrderID) AS Paraggelies
FROM
    (SELECT DISTINCT City FROM Customers) Cities
CROSS JOIN
    (SELECT DISTINCT MONTH(OrderDate) AS MonthNumber FROM Orders) Months
LEFT JOIN
    Customers C ON Cities.City = C.City
LEFT JOIN
    Orders o ON C.CustomerID = o.CustomerID AND Months.MonthNumber = MONTH(o.OrderDate)
LEFT JOIN
    [Order Details] od ON o.OrderID = od.OrderID
GROUP BY
    Cities.City, Months.MonthNumber
ORDER BY
    Cities.City ASC, Months.MonthNumber ASC;



---- QUERY 6 ---- 

----------- best performing 

WITH MonthlyOrderCosts AS (
    SELECT
        MONTH(o.OrderDate) AS Month,
        o.OrderID,
        SUM(od.UnitPrice * od.Quantity) AS OrderCost
    FROM
        Orders o
    JOIN
        [Order Details] od ON o.OrderID = od.OrderID
    WHERE
        YEAR(o.OrderDate) = 1997
    GROUP BY
        MONTH(o.OrderDate), o.OrderID
),
Top3Months AS (
    SELECT TOP 3
        Month
    FROM
        MonthlyOrderCosts
    GROUP BY
        Month
    ORDER BY
        SUM(OrderCost) DESC
)
SELECT
    m.Month,
    MAX(m.OrderCost) AS OrderCost
FROM
    MonthlyOrderCosts m
JOIN
    Top3Months t ON m.Month = t.Month
GROUP BY
    m.Month
ORDER BY
    m.Month;


--- simpler option but would yield 4 results if 2 months had there was a tie in the months.  


WITH MonthlyOrderCosts AS (
    SELECT
        MONTH(o.OrderDate) AS Month,
        o.OrderID,
        SUM(od.UnitPrice * od.Quantity) AS OrderCost
    FROM
        Orders o
    JOIN
        [Order Details] od ON o.OrderID = od.OrderID
    WHERE
        YEAR(o.OrderDate) = 1997
    GROUP BY
        MONTH(o.OrderDate), o.OrderID
)
SELECT TOP 3 
    Month,
    MAX(OrderCost) AS HighestOrderCost
FROM
    MonthlyOrderCosts
GROUP BY
    Month
ORDER BY
    SUM(OrderCost) DESC;


