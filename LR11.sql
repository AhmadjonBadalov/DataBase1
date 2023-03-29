-- 1. �������� ��� ���� �� ������� Production.Document.
SELECT * FROM Production.Document;
-- 2. �������� ���� ProductID, DocumentNode �� 
-- ������� Production.ProductDocument.
SELECT ProductID, DocumentNode
FROM Production.ProductDocument;
-- 3. �������� ���� ProductID, BusinessEntityID, AverageLeadTime, 
-- StandardPrice �� ������� Purchasing.ProductVendor, ��� ������� 
-- ���������� ������� (� ����) ����� ����������� ������ � �������� � 
-- ���������� �������������� �������� (AverageLeadTime) ������ 16, � 
-- ������� ��������� ���� �������� (StandardPrice) ��������� � 
-- ��������� �� $50 �� $60. ������������ �������� BETWEEN.
SELECT ProductID, BusinessEntityID, AverageLeadTime, StandardPrice
FROM Purchasing.ProductVendor
WHERE AverageLeadTime > 16 AND StandardPrice BETWEEN 50 AND 60;
-- 4. �������� ���� PurchaseOrderID, RevisionNumber, Status, ShipDate 
-- �� ������� Purchasing.PurchaseOrderHeader, ��� ������� �������� 
-- ��������������� ���� �������� �� ���������� (ShipDate) � ������� 
-- ��������� ������ "��������" (= 1).
SELECT PurchaseOrderID, RevisionNumber, [Status], ShipDate
FROM Purchasing.PurchaseOrderHeader
WHERE ShipDate IS NOT NULL AND [Status] = 1;
-- 5. �������� c���������� ��� ISO ��� ����� � �������� 
-- (CountryRegionCode) � �������� ������ ��� ������� (Name), ������� 
-- ��������� � ����� (Congo) �� ������� Person.CountryRegion.
SELECT CountryRegionCode, [Name]
FROM Person.CountryRegion
WHERE [Name] LIKE '%Congo%';
-- 6. �������� ���� AddressID, AddressLine1, City �� ������� 
-- Person.Address �������� ������ ������ �� ������ ������� (Bothell, 
-- Dallas, Ottawa, Calgary). ������������ �������� IN.
SELECT AddressID, AddressLine1, City
FROM Person.Address
WHERE [City] IN ('Bothell', 'Dallas', 'Ottawa', 'Calgary');
-- 7. �������� ���� BusinessEntityID, EmailAddressID � EmailAddress �� 
-- ������� Person.EmailAddress. ����������� �������� ���� EmailAddress 
-- �������� �� 'no email'.
SELECT BusinessEntityID, EmailAddressID, ISNULL(EmailAddress, 'no email') AS EmailAddress
FROM Person.EmailAddress;
-- 8. �������� ���� ProductID, Name �� ������� Production.Product � 
-- ����������� ������� COALESCE(). �������� ���� Meauserement, ���, 
-- �����, ���� �������� � ���� �������� Class, �� �������� ���, � 
-- �����, �������� �������� � ���� Style. ���� � � ���� Style �������� 
-- ����������, �� ������� �������� 'UNKNOWN'.
SELECT ProductID, [Name],
COALESCE(Class, Style, 'UNKNOWN') AS Meauserement
FROM Production.Product;
-- 9. ������������� ������ ������� Person.AddressType � ���������� 
-- ������� ������������ �������� ���� ������ (Name). �������� ���� 
-- AddressTypeID � Name.
SELECT AddressTypeID, [Name]
FROM Person.AddressType
ORDER BY [Name] ASC;
-- 10. �������� �� NULL �������� � ���� ���� (Color), ���� ���� ������ 
-- ������� (red). �������� ���� ProductID, Name, Color �� ������� 
-- Production.Product, ���� ���� ������ ��������� (���� �� ������). 
SELECT ProductID, [Name], NULLIF(Color, 'Red')
FROM Production.Product
WHERE Color IS NOT NULL;
