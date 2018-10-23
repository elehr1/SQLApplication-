USE AdventureWorks2012; /*Set current database*/


/*1, Display the total amount collected from the orders for each order date. */
Select OrderDate,
     SUM(TotalDue) AS Total_Amount_Collected
From AdventureWorks2012.Sales.SalesOrderHeader
GROUP BY OrderDate;

/*2, Display the total amount collected from selling the products, FROM 700 to 800. Only list those products that have been sold more than 3000 units.*/
SELECT ProductID,
   SUM(LineTotal) AS Total_Amount_Collected 
FROM [Sales].[SalesOrderDetail]
WHERE ProductID BETWEEN 700 AND 800 
GROUP BY ProductID
HAVING SUM(OrderQty) > 3000

/*3, Write a query to display the sales person BusinessEntityID, last name and first name of ALL the sales persons and the name of the territory to which they belong, even though they don't belong to any territory.*/
SELECT sp.BusinessEntityID
       ,p.LastName
	   ,p.FirstName
	   ,t.Name AS Territory_Name
FROM AdventureWorks2012.Sales.SalesPerson AS sp INNER JOIN AdventureWorks2012.Person.Person AS p ON sp.BusinessEntityID = p.BusinessEntityID
     INNER JOIN AdventureWorks2012.Sales.SalesTerritory AS t
	    ON t.TerritoryID = sp.TerritoryID


/*4,  Write a query to display the names of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/
SELECT p.LastName
	,p.FirstName
	,cc.CardType
FROM AdventureWorks2012.Sales.CreditCard AS cc
	LEFT OUTER JOIN AdventureWorks2012.Sales.PersonCreditCard AS pcc
		ON cc.CreditCardID = pcc.CreditCardID
	INNER JOIN AdventureWorks2012.Person.Person AS p 
		ON p.BusinessEntityID = pcc.BusinessEntityID
WHERE CardType = 'Vista';


/*5, Then how the number of customers for each type of credit cards.*/
SELECT cc.CardType
	,SUM(pcc.BusinessEntityID) AS Number_of_Customers
FROM AdventureWorks2012.Sales.CreditCard AS cc
	INNER JOIN AdventureWorks2012.Sales.PersonCreditCard AS pcc
		ON cc.CreditCardID = pcc.CreditCardID
GROUP BY CardType;


/*6, Write a query to display ALL the product names along with their corresponding subcategory names.*/
/* Tables: Production.Product, Production.ProductSubcategory*/
SELECT p.Name AS Product_Name
       ,s.Name AS Subcategory_Name
FROM AdventureWorks2012.Production.Product AS p INNER JOIN
     AdventureWorks2012.Production.ProductSubcategory AS s
	    ON p.ProductSubcategoryID = s.ProductSubcategoryID; 


/*7. List ALL the product names that do not belong to any subcategory.*/
SELECT p.Name AS Product_Name
      ,s.Name AS Subcategory_Name
FROM AdventureWorks2012.Production.Product AS p LEFT JOIN 
     AdventureWorks2012.Production.ProductSubCategory AS s
	   ON p.Name = s.Name;


/*8, Write a query to report the sales order ID of those orders where the total due is greater than the average of the total dues of all the orders. You need to use subquery. */
SELECT SalesOrderID
FROM [AdventureWorks2012].[Sales].[SalesOrderHeader]
GROUP BY SalesOrderID 
HAVING SUM(TotalDue) > 
	(Select SUM(TotalDue)  /  (Count(SalesOrderID))
	FROM [AdventureWorks2012].[Sales].[SalesOrderHeader]); 
