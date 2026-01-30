Project Title:

	Sales Management and Revenue Analysis SQL Project

2. Project Objective:

	This project is created to practice and demonstrate SQL concepts using Sales Management database with four related tables
		Customers
		Products
		Sales
		Regions

	CRUD Operations

	        CREATE: INSERT INTO[New Data]
		READ:   SELECT[Retrieve or view data]
	   	UPDATE: UPDATE[Modify existing Data]
		DELETE: DELETE[Remove Data]

	COALESCE Function
	Subquery

	This project is designed to prepare for SQL Interview and for hands-on learning


3. Tools and Technologies Used:

	Tool: MySQL 8.0 CE
	Technology: SQL

4. Database Description:

	The SalesManagementDB Contains four Tables:
		
		Regions: Stores geographical area
		Customers: Stores customer information
		Products: Stores information about products sold
		Sales: Stores sales transactions

	Relationship: Customers -> Region
		      Sales ->  Customers -> Region
		      Sales ->  Products


5.Table Structure:

	5.1 Regions Table: This table stores regions information

			Column Name	  Data TYpe	       Description
			RegionID	  INT		       Primary Key
			RegionName	  VARCHAR(50)	       Region Name
			
			SQL Query: CREATE TABLE Regions(RegionID INT PRIMARY KEY,
						       RegionName VARCHAR(50) );

	5.2 Customers Table: This table stores customers information

			Column Name	  Data TYpe	       Description
			CustomerID	  INT		       Primary Key
			CustomerName	  VARCHAR(50)	       Column Name
			RegionID	  INT		       Region ID
			SQl Query: CREATE TABLE Customers(CustomerID INT PRIMARY KEY,
						         CustomerName VARCHAR(50),
                     					 RegionID INT,
                    				         FOREIGN KEY(RegionID) REFERENCES Regions(RegionID));
	
	5.3 Products Table: This table stores Products information
	
			Column Name	  Data TYpe	       Description
			ProductID	  INT 		       Primary Key
			ProductName	  VARCHAR(50)	       Product Name
			Price		  DECIMAL(10,2)	       Price Details

			SQl Query: CREATE TABLE Products(ProductID INT PRIMARY KEY,
					  		ProductName VARCHAR(50),
                      					PRICE DECIMAL(10,2));
	5.4 Sales Table: This table stores Sales information

			Column Name	  Data TYpe	       Description
			SaleID		  INT		       Primary Key
			CustomerID	  INT	               Customer ID
			ProductID	  INT		       Product  ID
			Quantity	  INT		       Quantity
			SaleDate	  DATE		       Sales on date
 
			SQl Query: CREATE TABLE Sales(SaleID INT PRIMARY KEY,
				   		     CustomerID INT,
				   		     ProductID INT,
                   				     Quantity INT,
                   				     SaleDate DATE,
				   		     FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
                  		                     FOREIGN KEY(ProductID) REFERENCES Products(ProductID));
6.Insert sample data:

		6.1 Insert Regions sample data

			SQL Query: INSERT INTO Regions VALUES(1,'South'),
						  	    (2,'North'),
                          				    (3,'East'),
                          				    (4,'West');


		6.2 Insert Customers sample data

			SQL Query: INSERT INTO Customers VALUES(101,'Charan',1),
							      (102,'Reyansh',2),
                                   			      (103,'Anu',3);

		6.3 Insert Produts sample data

			SQL Query: INSERT INTO Products VALUES(1001,'Laptop',55000),
						   	     (1002,'Mobile',20000),
                          				     (1003,'Tablet',30000);
                           

		6.4 Insert Sales sample data

			SQL Query: INSERT INTO Sales VALUES(1,101,1001,2,'2024-01-10'),
					    		  (2,102,1002,3,'2024-01-15'),
                        				  (3,101,1003,1,'2024-02-05'),
                        				  (4,103,1001,1,'2024-02-10');

7. Sample Queries:

	7.1 Display data in Regions table

		SQL Query: SELECT * FROM Regions;

	7.2 Display data in Customers table

		SQL Query: SELECT * FROM Customers;

	7.3 Display data in Products table

		SQL Query: SELECT * FROM Products;

	7.4 Display data in Sales table

		SQL Query: SELECT * FROM Sales;

	7.5 Total sales amount per customer

		SQL Query: SELECT c.CustomerName,SUM(p.Price*s.Quantity) As TotAmt 
			   FROM Customers c LEFT JOIN Sales s ON c.CustomerID=s.CustomerID
			   LEFT JOIN Products p ON s.ProductID=p.ProductID
			   GROUP BY c.CustomerName;

	7.6 Region wise Revenue: Used COALESCE to return 0 instead of null 
					a. Calculation are accurate
					b. Avoids issues caused in Power BI Reports

		SQL Query: SELECT r.RegionName,COALESCE(SUM(p.Price*s.Quantity),0) AS Revenue
			   FROM  Regions r LEFT JOIN Customers c ON r.RegionID=c.RegionID
			   LEFT JOIN Sales s ON c.CustomerID=s.CustomerID
			   LEFT JOIN Products p ON s.ProductID=p.ProductID
			   GROUP BY r.RegionName; 

	7.7 Total Selling Products: Subquery(If morethan 1 product is top selling)

		SQL Query: SELECT p.ProductName,SUM(s.Quantity) As TotQuan
			   FROM Products p JOIN Sales s ON p.ProductID=s.ProductID
			   GROUP BY p.ProductName
			   HAVING SUM(s.Quantity)=(SELECT MAX(t.TotQuan) 
			   FROM (SELECT SUM(Quantity) AS TotQuan
                                 FROM Sales 
                        	 GROUP BY ProductID)t);

		2ND Method using RANK():

		SQL Query:SELECT ProductName,TotQuan
			  FROM(SELECT p.ProductName,
		    		SUM(s.Quantity) AS TotQuan,
				RANK() OVER (ORDER BY SUM(s.Quantity) DESC) AS rnk
				FROM Products p JOIN Sales s ON p.ProductID=s.ProductID
				GROUP BY p.ProductName
			     )Rankedproducts
			   WHERE rnk=1;

	7.8 Customer who never made a purchase(If sale id is created but product is not purchased)

		SQL Query: SELECT c.CustomerName,s.SaleID
			   FROM Customers c LEFT JOIN Sales s ON c.CustomerID=s.CustomerID
			   WHERE s.SaleID IS NULL;
	
	7.9 Monthly Sales Report

		SQL Query: SELECT MONTH(s.Saledate) AS MonthlySales,SUM(s.Quantity*p.Price) AS MonthlyRevenue
			   FROM Sales s JOIN Products p ON s.ProductID=p.ProductID
			   GROUP BY MONTH(s.Saledate);


8.Output Documentation: 1.Query results are saved in Output.md file			
			 2.Tabular Formats are saved in ResultImages Excel file






