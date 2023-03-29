-- 1. ����� ������������ ���� ������ (ListPrice) ��
-- ������� Production.Product.
SELECT MAX(ListPrice) AS MaxListPrice
FROM Production.Product;
-- 2. ����� ����������� ��� (Weight) �� ������� Production.Product,
-- �� ��������� ������ ��������.
SELECT MAX(Weight) AS MaxWeight 
FROM Production.Product 
WHERE Weight IS NOT NULL;
-- 3. ����� ������� ������� ������ � ������ �� ������� 
-- HumanResources.Employee, �� ��������� ������ ��������.
SELECT Gender, AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) AS AvgBirthDate
FROM HumanResources.Employee 
WHERE BirthDate IS NOT NULL
GROUP BY Gender;
-- 4. ������� ������, ��� ���������� ������� = 1, �� ������� 
-- Person.StateProvince (�� ������� ��������� ������ ����).
SELECT CountryRegionCode
FROM Person.StateProvince
GROUP BY CountryRegionCode
HAVING COUNT(*) = 1;
-- 5. ������� BusinessEntityID, LastReceiptDate � ������� �� 
-- StandardPrice ��� BusinessEntityID � ������� LastReceiptDate, 
-- ������������� ����� ������ �������� ��� ���� StandardPrice � 
-- ��������� BusinessEntityID �� ������� Purchasing.ProductVendor. 
-- (������������ ROOLUP)
SELECT BusinessEntityID, LastReceiptDate, AVG(StandardPrice) AS AvgStandardPrice
FROM Purchasing.ProductVendor
GROUP BY ROLLUP (BusinessEntityID, LastReceiptDate);
