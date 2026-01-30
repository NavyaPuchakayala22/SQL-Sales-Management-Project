USE SalesManagmentDB;

INSERT INTO Regions VALUES(1,'South'),
						  (2,'North'),
                          (3,'East'),
                          (4,'West');
                          
INSERT INTO Customers VALUES(101,'Charan',1),
							(102,'Reyansh',2),
                            (103,'Anu',3);                                           
                            
INSERT INTO Products VALUES(1001,'Laptop',55000),
						   (1002,'Mobile',20000),
                           (1003,'Tablet',30000);
                           
INSERT INTO Sales VALUES(1,101,1001,2,'2024-01-10'),
					    (2,102,1002,3,'2024-01-15'),
                        (3,101,1003,1,'2024-02-05'),
                        (4,103,1001,1,'2024-02-10');
                        
                            
			