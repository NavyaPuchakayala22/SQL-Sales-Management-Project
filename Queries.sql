USE SalesManagmentDB;

SELECT * FROM Regions;

SELECT * FROM Customers;

SELECT * FROM Products;

SELECT * FROM Sales;

INSERT INTO Customers VALUES(104,'John',1);

SELECT c.CustomerName,SUM(p.Price*s.Quantity) As TotAmt 
FROM Customers c LEFT JOIN Sales s ON c.CustomerID=s.CustomerID
LEFT JOIN Products p ON s.ProductID=p.ProductID
GROUP BY c.CustomerName;

SELECT r.RegionName,COALESCE(SUM(p.Price*s.Quantity),0) AS Revenue
FROM  Regions r LEFT JOIN Customers c ON r.RegionID=c.RegionID
LEFT JOIN Sales s ON c.CustomerID=s.CustomerID
LEFT JOIN Products p ON s.ProductID=p.ProductID
GROUP BY r.RegionName; 

SELECT p.ProductName,SUM(s.Quantity) As TotQuan
FROM Products p JOIN Sales s ON p.ProductID=s.ProductID
GROUP BY p.ProductName
HAVING SUM(s.Quantity)=(SELECT MAX(t.TotQuan) 
					    FROM (
					    SELECT SUM(Quantity) AS TotQuan
                        FROM Sales 
                        GROUP BY ProductID)t);
  
/*Using RANK()*/

SELECT ProductName,TotQuan
FROM(SELECT p.ProductName,
		    SUM(s.Quantity) AS TotQuan,
			RANK() OVER (ORDER BY SUM(s.Quantity) DESC) AS rnk
			FROM Products p JOIN Sales s ON p.ProductID=s.ProductID
			GROUP BY p.ProductName
    )Rankedproducts
WHERE rnk=1;

SELECT c.CustomerName,s.SaleID
FROM Customers c LEFT JOIN Sales s ON c.CustomerID=s.CustomerID
WHERE s.SaleID IS NULL;

SELECT * FROM Sales;

SELECT * FROM Products;

SELECT MONTH(s.Saledate) AS MonthlySales,SUM(s.Quantity*p.Price) AS MonthlyRevenue
FROM Sales s JOIN Products p ON s.ProductID=p.ProductID
GROUP BY MONTH(s.Saledate);
