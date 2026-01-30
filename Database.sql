CREATE DATABASE SalesManagmentDB;

USE SalesManagmentDB;

CREATE SCHEMA SalesMangamentSchema;

CREATE TABLE Regions(RegionID INT PRIMARY KEY,
					 RegionName VARCHAR(50) );
                     
CREATE TABLE Customers(CustomerID INT PRIMARY KEY,
					 CustomerName VARCHAR(50),
                     RegionID INT,
                     FOREIGN KEY(RegionID) REFERENCES Regions(RegionID));
					                                                      
CREATE TABLE Products(ProductID INT PRIMARY KEY,
					  ProductName VARCHAR(50),
                      PRICE DECIMAL(10,2));
                      
CREATE TABLE Sales(SaleID INT PRIMARY KEY,
				   CustomerID INT,
				   ProductID INT,
                   Quantity INT,
                   SaleDate DATE,
				   FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID),
                   FOREIGN KEY(ProductID) REFERENCES Products(ProductID));

SHOW DATABASES;

SHOW TABLES;

DESC Regions;

DESC Customers;

DESC Products;

DESC Sales;