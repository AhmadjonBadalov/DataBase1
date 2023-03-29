-- 1. �������� ������� ��� � �������� ������ �������� ����������
-- (������� HumanResources.Employee � Person.Person).
-- �������� ���� FirstName, MiddleName, LastName.
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE BusinessEntityID =
    (
        SELECT BusinessEntityID
        FROM HumanResources.Employee
		WHERE BirthDate =
			(
				SELECT MIN(BirthDate)
				FROM HumanResources.Employee
			)
    );
-- 2. ���������� ���������� ����������� � �����, �
-- ������� ��������� ������������ ����� �����������
-- (������� Person.[Address]).
SELECT City, COUNT(*) AS LivingPersonCount
FROM Person.[Address]
WHERE City IS NOT NULL
GROUP BY City
HAVING COUNT(*) =
	(
		SELECT MAX(LivingPersonCount) AS MaxLivingPersonCount
		FROM
			(
				SELECT COUNT(*) AS LivingPersonCount
				FROM Person.[Address]
				WHERE City IS NOT NULL
				GROUP BY City
			)
		AS MaxLivingPersonCount
	);
-- 3. �������� ��������� (ProductSubcategoryID) �������, ��� 
-- ������� ���������� ����� 7 �������� (������� Production.Product). 
-- �������� ���� [Name], Size � ProductSubcategoryID.
SELECT Product1.ProductSubcategoryID
FROM Production.Product AS Product1
WHERE Product1.ProductSubcategoryID IS NOT NULL
AND Product1.Size IS NOT NULL
AND (
		SELECT COUNT(DISTINCT Product2.Size) AS SizeCount
		FROM Production.Product AS Product2
		WHERE Product2.Size IS NOT NULL
		AND Product1.ProductSubcategoryID =
		Product2.ProductSubcategoryID
	) > 7
GROUP BY ProductSubcategoryID;
-- 4. �������� ������, ���� ������� ����� ������������ ����
-- ������ �� ��� �� ������������ (������� Production.Product). 
-- �������� ���� [Name], ListPrice � ProductSubcategoryID.
SELECT Product1.[Name]
	, Product1.ListPrice
	, Product1.ProductSubcategoryID
FROM Production.Product AS Product1
JOIN
	(
		SELECT ProductSubcategoryID
			, MAX(ListPrice) AS MaxListPrice
		FROM Production.Product
		WHERE ProductSubcategoryID IS NOT NULL
		AND ListPrice > 0
		GROUP BY ProductSubcategoryID
	)
AS Product2
ON Product1.ProductSubcategoryID = Product2.ProductSubcategoryID
AND Product1.ListPrice = Product2.MaxListPrice;
-- 5. �������� ������, ���� ������� ������ ������� ���� 
-- � ����� ������� (������� Production.Product). �������� 
-- ���� [Name], Size � ListPrice.
SELECT [Name]
	, Size
	, ListPrice
FROM Production.Product
WHERE ListPrice > ANY
	(
		SELECT AVG(ListPrice) AS AvgListPrice
		FROM Production.Product
		WHERE Size IS NOT NULL
		GROUP BY Size
	);
