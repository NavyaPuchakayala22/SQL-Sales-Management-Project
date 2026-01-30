/\*Create Database\*/



3	1	10:24:24	CREATE DATABASE SalesManagmentDB	1 row(s) affected	0.047 sec



/\*Create Schema\*/



3	2	11:57:20	CREATE SCHEMA SalesMangamentSchema	1 row(s) affected	0.031 sec



/\*Create Regions Table\*/



3	3	12:07:00	CREATE TABLE Regions(RegionID INT PRIMARY KEY,

       						     RegionName VARCHAR(50) )	0 row(s) affected	0.125 sec

/\*Create Customers Table\*/



3	4	12:11:33	CREATE TABLE Customers(CustomerID INT PRIMARY KEY,

      						       CustomerName VARCHAR(50),

                      				       RegionID INT,

                     				       FOREIGN KEY(RegionID) REFERENCES Regions(RegionID))	0 row(s) affected	0.110 sec



/\*Create Products Table\*/



3	6	12:16:22	CREATE TABLE Products(ProductID INT PRIMARY KEY,

       						      ProductName VARCHAR(50),

                      				      PRICE DECIMAL(10,2))	0 row(s) affected	0.094 sec



/\*Create Sales Table\*/



3	7	12:21:35	CREATE TABLE Sales(SaleID INT PRIMARY KEY,

        					   CustomerID INT,

        					   ProductID INT,

                  				   Quantity INT,

                      				   SaleDate DATE,

        					   FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),

                    				   FOREIGN KEY(ProductID) REFERENCES Products(ProductID))	0 row(s) affected	0.156 sec



/\*Insert Data in Regions Table\*/



3	2	11:29:15	INSERT INTO Regions VALUES(1,'South'),

        						  (2,'North'),

                                   		          (3,'East'),

                           			          (4,'West')	4 row(s) affected

 Records: 4  Duplicates: 0  Warnings: 0	0.031 sec



/\*Insert Data in Customers Table\*/



3	3	11:31:15	INSERT INTO Customers VALUES(101,'Charan',1),

 							    (102,'Reyansh',2),

                            				    (103,'Anu',3)	3 row(s) affected

 Records: 4  Duplicates: 0  Warnings: 0	0.035 sec





/\*Insert Data in Products Table\*/



3	4	11:33:45	INSERT INTO Products VALUES(1001,'Laptop',55000),

 						  	   (1002,'Mobile',20000),

                           				   (1003,'Tablet',30000)	3 row(s) affected

 Records: 3  Duplicates: 0  Warnings: 0	0.030 sec



/\*Insert Data in Table\*/



3	5	11:37:46	INSERT INTO Sales VALUES(1,101,1001,2,'2024-01-10'),

 					    		(2,102,1002,3,'2024-01-15'),

                        				(3,101,1003,1,'2024-02-05'),

                       					(4,103,1001,1,'2024-02-10')	4 row(s) affected

 Records: 4  Duplicates: 0  Warnings: 0	0.037 sec



/\*Display all regions information\*/



3	2	14:27:13	SELECT \* FROM Regions

 LIMIT 0, 1000	4 row(s) returned	0.000 sec / 0.000 sec



/\*Display all Customers information\*/



3	3	14:32:05	SELECT \* FROM Customers

 LIMIT 0, 1000	3 row(s) returned	0.000 sec / 0.000 sec



/\*Display all products information\*/



3	4	14:37:34	SELECT \* FROM Products

 LIMIT 0, 1000	3 row(s) returned	0.000 sec / 0.000 sec



/\*Display all sales information\*/



3	5	14:39:11	SELECT \* FROM Sales

 LIMIT 0, 1000	4 row(s) returned	0.000 sec / 0.000 sec



/\*Total Sales amount per customer\*/



3	8	18:49:24	SELECT c.CustomerName,SUM(p.Price\*s.Quantity) As TotAmt

 				FROM Customers c LEFT JOIN Sales s ON c.CustomerID=s.CustomerID

 				LEFT JOIN Products p ON s.ProductID=p.ProductID

 				GROUP BY c.CustomerName

 	       LIMIT 0, 1000	4 row(s) returned	0.000 sec / 0.000 sec



/\*Region wise revenue\*/



3	9	18:34:29	SELECT r.RegionName,COALESCE(SUM(p.Price\*s.Quantity),0) AS Revenue

 				FROM  Regions r LEFT JOIN Customers c ON r.RegionID=c.RegionID

 				LEFT JOIN Sales s ON c.CustomerID=s.CustomerID

 				LEFT JOIN Products p ON s.ProductID=p.ProductID

 				GROUP BY r.RegionName

 		LIMIT 0, 1000	4 row(s) returned	0.000 sec / 0.000 sec



/\*Top Selling Products\*/



3	11	19:26:22	SELECT p.ProductName,SUM(s.Quantity) As TotQuan

 				FROM Products p JOIN Sales s ON p.ProductID=s.ProductID

 				GROUP BY p.ProductName

 				HAVING SUM(s.Quantity)=(SELECT MAX(t.TotQuan)

          						FROM (

          						SELECT SUM(Quantity) AS TotQuan

                         				FROM Sales

                         				GROUP BY ProductID)t)

 		LIMIT 0, 1000	2 row(s) returned	0.000 sec / 0.000 sec



**2nd Method using RANK():**



3	4	21:01:03	SELECT ProductName,TotQuan

&nbsp;				FROM(SELECT p.ProductName,

&nbsp;      				SUM(s.Quantity) AS TotQuan,

&nbsp;			        RANK() OVER (ORDER BY SUM(s.Quantity) DESC) AS rnk

&nbsp;   				FROM Products p JOIN Sales s ON p.ProductID=s.ProductID

&nbsp;   				GROUP BY p.ProductName

&nbsp;    				)Rankedproducts

&nbsp;				WHERE rnk=1	2 row(s) returned	0.015 sec / 0.000 sec



/\*Customer who never made purchase\*/



3	13	19:40:45	SELECT c.CustomerName,s.SaleID

 				FROM Customers c LEFT JOIN Sales s ON c.CustomerID=s.CustomerID

 				WHERE s.SaleId IS NULL

 		LIMIT 0, 1000	1 row(s) returned	0.000 sec / 0.000 sec



/\*Monthly sales report\*/



3	60	20:42:12	SELECT MONTH(s.Saledate) AS MonthlySales,SUM(s.Quantity\*p.Price) AS MonthlyRevenue

 				FROM Sales s JOIN Products p ON s.ProductID=p.ProductID

 				GROUP BY MONTH(s.Saledate)

 		LIMIT 0, 1000	2 row(s) returned	0.000 sec / 0.000 sec

