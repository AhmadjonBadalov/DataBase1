-- 1. �������� ������ ����������� ����� (EmailAddress) � ���� 
-- PersonType, FirstName, LastName �� ������ Person.Person, 
-- Person.EmailAddress.
SELECT Email.EmailAddress, Person.PersonType, Person.FirstName, Person.LastName
FROM Person.EmailAddress AS Email
INNER JOIN Person.Person AS Person
ON Person.BusinessEntityID = Email.BusinessEntityID;
-- 2. �������� ������ ��������� (���� Name) � ������� �������, ���� �� 
-- � �������� �������������� ���� (ActualCost) ��� ���, �� ������ 
-- Production.Product, Production.WorkOrderRouting, ��������� LEFT 
-- OUTER JOIN.
SELECT Product.[Name], Work.ActualCost
FROM Production.Product AS Product
LEFT OUTER JOIN Production.WorkOrderRouting AS Work
ON Product.ProductID = Work.ProductID;
-- 3. �������� ������ ��������� (���� Name) � ������� �������, ���� �� 
-- � �������� ������������ ��� ���, �� ������ 
-- Production.ProductSubcategory, Production.Product, ��������� RIGHT 
-- OUTER JOIN.
SELECT Product.[Name], Subcategory. ProductSubcategoryID
FROM Production.ProductSubcategory AS Subcategory
RIGHT OUTER JOIN Production.Product AS Product
ON Subcategory.ProductSubcategoryID = Product.ProductSubcategoryID;
-- 4. �������� ������ ������������ ��������� (ProductSubcategoryID), 
-- ������� ����� ��������� ����������� ��� (StandardCost), �� ������� 
-- Production.Product, ��������� SELF JOIN.
SELECT DISTINCT Product1.ProductSubcategoryID, Product1.StandardCost
FROM Production.Product AS Product1
INNER JOIN Production.Product AS Product2
ON Product1.ProductSubcategoryID = Product2.ProductSubcategoryID
WHERE Product1.StandardCost <> Product2.StandardCost
ORDER BY ProductSubcategoryID;
-- 5. �������� ������ ����������� ��� (StanderdCost), ������� ����� 
-- ��������� ������������ ��������� (ProductSubcategoryID), �� ������� 
-- Production.Product, ��������� SELF JOIN.
SELECT DISTINCT Product1.StandardCost, Product1.ProductSubcategoryID
FROM Production.Product AS Product1
INNER JOIN Production.Product AS Product2
ON Product1.StandardCost = Product2.StandardCost
WHERE Product1.ProductSubcategoryID <> Product2.ProductSubcategoryID
ORDER BY StandardCost;
-- 6. �������� ������ ����� ��������������� (Type), ������� ����� 
-- ��������� �������� ������������ ���������� (MinQty) �� ������ 15, 
-- �� ������� Sales.SpecialOffer, ��������� SELF JOIN.
SELECT DISTINCT Sales1.Type, Sales1.MinQty
FROM Sales.SpecialOffer AS Sales1
INNER JOIN Sales.SpecialOffer AS Sales2
ON Sales1.Type = Sales2.Type
WHERE Sales1.MinQty <> Sales2.MinQty AND Sales1.MinQty > 15;
-- 7. �������� ��������������� ������ ������ 
-- Person.BusinessEntityAddress, Person.BusinessEntityContact, 
-- ��������� UNION.
SELECT *
FROM Person.BusinessEntityAddress
UNION
SELECT *
FROM Person.BusinessEntityContact;
-- 8. �������� ������ BusinessEntityID, ������� ���������� � ������� 
-- Sales.SalesPerson, �� �� ���������� � ������� Sales.Store.
SELECT BusinessEntityID
FROM Sales.SalesPerson
EXCEPT
SELECT BusinessEntityID
FROM Sales.Store;
