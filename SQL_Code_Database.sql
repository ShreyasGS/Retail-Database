--This is a database for an online store. It tracks customers, their orders, various product prices, and more. 

CREATE DATABASE	Group1_Final_IM543
USE Group1_Final_IMT543

CREATE TABLE [dbo].[tblCUSTOMER]
	(
	[CustID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[CustMemberDate] [date] NOT NULL,
	[CustFName] [nvarchar](35) NOT NULL,
	[CustLName] [nvarchar](35) NOT NULL,
	[CustAddress] [nvarchar](100) NOT NULL,
	[CustCity] [nvarchar](75) NOT NULL,
	[CustCounty] [nvarchar](75) NOT NULL,
	[CustState] [nvarchar](30) NOT NULL,
	[CustZIP] [nvarchar](12) NOT NULL,
	[CustEmail] [nvarchar](100) NOT NULL,
	[CustPhone] [nvarchar](12) NOT NULL,
	[DateOfBirth] [date] NOT NULL
	)

CREATE TABLE [dbo].[tblVENDOR]
	(
	[VendorID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[VendorBusinessName] [nvarchar](35) NOT NULL,
	[VendorAddress] [nvarchar](100) NOT NULL,
	[VendorCity] [nvarchar](75) NOT NULL,
	[VendorCounty] [nvarchar](75) NOT NULL,
	[VendorState] [nvarchar](30) NOT NULL,
	[VendorZIP] [nvarchar](12) NOT NULL,
	[VendorEmail] [nvarchar](100) NOT NULL,
	[VendorPhone] [nvarchar](12) NOT NULL
	)

CREATE TABLE [dbo].[tblSHIPPER]
	(
	[ShipperID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ShipperCompanyName] [nvarchar](35) NOT NULL,
	[ShipperAddress] [nvarchar](100) NOT NULL,
	[ShipperCity] [nvarchar](75) NOT NULL,
	[ShipperCounty] [nvarchar](75) NOT NULL,
	[ShipperState] [nvarchar](30) NOT NULL,
	[ShipperZIP] [nvarchar](12) NOT NULL,
	[ShipperEmail] [nvarchar](100) NOT NULL, 
	[ShipperPhone] [nvarchar](12) NOT NULL
	)

CREATE TABLE [dbo].[tblSHIPPER_CONTACT]
	(
	[ShipperContactID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ShipperID] [int] FOREIGN KEY REFERENCES tblSHIPPER (ShipperID) NOT NULL,
	[ShipperContactFName] [nvarchar](35) NOT NULL,
	[ShipperContactLName] [nvarchar](35) NOT NULL,
	[ShipperContactPhone] [nvarchar](12) NOT NULL,
	[ShipperContactEmail] [nvarchar](100) NOT NULL
	)

CREATE TABLE [dbo].[tblPRODUCT_TYPE]
	(
	[ProductTypeID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ProductTypeName] [varchar](50) NOT NULL,
	[ProductTypeDescr] [varchar](100) NULL
	)

CREATE TABLE [dbo].[tblPRODUCT]
	(
	[ProductID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[ProductTypeID] INT FOREIGN KEY REFERENCES tblPRODUCT_TYPE (ProductTypeID) NOT NULL,
	[ProductSKU] [nvarchar](100) NOT NULL
	)

CREATE TABLE [dbo].[tblPRODUCT_PRICE]
	(
	[ProductPriceID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ProductID] INT FOREIGN KEY REFERENCES tblPRODUCT (ProductID) NOT NULL,
	[Price] [numeric] (20, 2) NOT NULL, 
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NULL
	)

CREATE TABLE [dbo].[tblORDER]
	(
	[OrderID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[CustID] [int] FOREIGN KEY REFERENCES tblCUSTOMER (CustID) NOT NULL,
	[OrderDate] [datetime] DEFAULT GetDate() NULL
	)
	
CREATE TABLE [dbo].[tblVENDOR_PURCHASE_ORDER]
	(
	[VendorPurchaseOrderID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[VendorID] [int] FOREIGN KEY REFERENCES tblVENDOR (VendorID) NOT NULL,
	[ProductID] [int] FOREIGN KEY REFERENCES tblPRODUCT (ProductID) NOT NULL,
	[PurchaseDate] [datetime] DEFAULT GetDate() NULL,
	[OrderQty] [int] NOT NULL
	)


CREATE TABLE [dbo].[tblLINE_ITEM]
	(
	[LineItemID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[OrderID] [int] FOREIGN KEY REFERENCES tblORDER (OrderID) NULL,
	[ProductID] [int] FOREIGN KEY REFERENCES tblPRODUCT (ProductID) NOT NULL,
	[Qty] [int] NOT NULL
	)

CREATE TABLE [dbo].[tblCART]
	(
	[CartID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[CustID] [int] FOREIGN KEY REFERENCES tblCUSTOMER (CustID) Not NULL,
	[ProductID] [int] FOREIGN KEY REFERENCES tblPRODUCT (ProductID) NOT NULL,
	[CartDate] [datetime] DEFAULT GetDate() NOT NULL,
	[Qty] [int] NOT NULL
	)

CREATE TABLE [dbo].[tblTRACK]
	(
	[TrackID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ShipperID] [int] FOREIGN KEY REFERENCES tblSHIPPER (ShipperID) NOT NULL,
	[TrackNum] [nvarchar](40) NOT NULL,
	[BeginDate] [datetime] NULL,
	[EndDate] [datetime] NULL
	)

CREATE TABLE [dbo].[tblSTATUS]
	(
	[StatusID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[StatusName] [nvarchar] (35) NOT NULL,
	[StatusDesc] [nvarchar] (100) NOT NULL
	)

CREATE TABLE [dbo].[tblSHIPMENT]
	(
	[ShipmentID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	--[ShipperID] [int] FOREIGN KEY REFERENCES tblSHIPPER (ShipperID) NOT NULL,
	[OrderID] [int] FOREIGN KEY REFERENCES tblORDER (OrderID) NOT NULL,
	[TrackID] [int] FOREIGN KEY REFERENCES tblTRACK (TrackID) NOT NULL,
	[ShipmentDate] [datetime] DEFAULT GetDate() NULL
	)

CREATE TABLE [dbo].[tblSHIPMENT_STATUS]
	(
	[ShipmentStatusID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[ShipmentID] [int] FOREIGN KEY REFERENCES tblSHIPMENT (ShipmentID) NOT NULL,
	[StatusID] [int] FOREIGN KEY REFERENCES tblSTATUS (StatusID) NOT NULL,
	[StatusDate] [datetime] DEFAULT GetDate() NULL
	)

GO 

---------------Populating Tables---------------
--Insert for tblPRODUCT_TYPE
INSERT INTO tblPRODUCT_TYPE(ProductTypeName, ProductTypeDescr) 
VALUES('Alcohol', 'Beverages with alcoholic content'),
('Clothes', 'Things you wear'),
('Food', 'Things you eat'),
('Furniture', 'Objects that support human activity, such as eating, sleeping, sitting, etc.'),
('Kitchenware', 'Things used for preparing, cooking, and/or serving food')

--Insert for tblSHIPMENT_STATUS
INSERT INTO tblSTATUS(StatusName, StatusDesc)
VALUES('Pending', 'Order has been accepted and is pending to be processed'),
('Processing', 'Order is being processed; order items are being selected and packed'),
('Shipped', 'Order has been shipped out'),
('OutForDelivery', 'Shipped order is currently out for delivery to the customer'),
('Delivered', 'Order has been delivered to the customer')
GO

--Stored procedure for adding customers 
CREATE PROCEDURE uspADDCUSTOMER
@CustMembDate Date,
@FName nvarchar(35),
@LName nvarchar(35),
@Address nvarchar(100),
@City nvarchar(75),
@County nvarchar(75),
@State nvarchar(30),
@ZIP nvarchar(12),
@Email nvarchar(100),
@Phone nvarchar(12),
@DOB Date
AS

BEGIN TRAN T1
INSERT INTO tblCUSTOMER(CustMemberDate,CustFName, CustLName, CustAddress, CustCity, CustCounty, CustState, CustZIP, CustEmail, CustPhone, DateOfBirth) 
VALUES(@CustMembDate, @FName, @LName, @Address, @City, @County, @State, @ZIP, @Email, @Phone, @DOB)

IF @@ERROR <> 0
	ROLLBACK TRAN T1
ELSE 
	COMMIT TRAN T1

GO

--Adding 5 customers
EXEC uspADDCUSTOMER
@CustMembDate = '1/2/2019',
@FName = 'Amy',
@LName = 'Schumacher',
@Address = '456 1st Ave',
@City = 'Seattle',
@County = 'King',
@State = 'WA',
@ZIP = '22222',
@Email = 'amys@gmail.com',
@Phone = '111-111-2222',
@DOB = '1/1/1999'

EXEC uspADDCUSTOMER
@CustMembDate = '2/1/2019',
@FName = 'Fred',
@LName = 'Weasley',
@Address = '10 Privet Drive',
@City = 'Seattle',
@County = 'King',
@State = 'WA',
@ZIP = '14345',
@Email = 'fredw@aol.com',
@Phone = '222-333-4444',
@DOB = '3/1/1991'

EXEC uspADDCUSTOMER
@CustMembDate = '3/1/2019',
@FName = 'Harry',
@LName = 'Potter',
@Address = '100 2nd Ave',
@City = 'Seattle',
@County = 'King',
@State = 'WA',
@ZIP = '88888',
@Email = 'harryp@harry.com',
@Phone = '444-564-9874',
@DOB = '5/5/1985'

EXEC uspADDCUSTOMER
@CustMembDate = '11/1/2018',
@FName = 'Hermione',
@LName = 'Granger',
@Address = '123 10th Ave',
@City = 'New York',
@County = 'Manhattan',
@State = 'NY',
@ZIP = '12368',
@Email = 'hermg@hotmail.com',
@Phone = '456-444-9999',
@DOB = '11/1/1989'

EXEC uspADDCUSTOMER
@CustMembDate = '3/11/2018',
@FName = 'Kanye',
@LName = 'East',
@Address = '869 1st Ave',
@City = 'New York',
@County = 'Brooklyn',
@State = 'NY',
@ZIP = '84655',
@Email = 'kanyebeast@aol.com',
@Phone = '346-123-1677',
@DOB = '11/1/1989'

GO

--Stored procedure for adding products
CREATE PROCEDURE uspADDPRODUCT
@ProdTypeName varchar(50),
@ProdName varchar(50),
@ProdSKU nvarchar(100),
@BeginDate date
AS

DECLARE @PType_ID INT
SET @PType_ID = 
	(
	SELECT ProductTypeID 
	FROM tblPRODUCT_TYPE
	WHERE ProductTypeName = @ProdTypeName
	)

BEGIN TRAN T2
INSERT INTO tblPRODUCT(ProductName, ProductTypeID, ProductSKU)
VALUES(@ProdName, @PType_ID, @ProdSKU)

IF @@ERROR <> 0
	ROLLBACK TRAN T2
ELSE 
	COMMIT TRAN T2

GO

--Adding 5 products
EXEC uspADDPRODUCT
@ProdTypeName = 'Clothes',
@ProdName = 'Wool Jacket',
@ProdSKU = '222222',
@BeginDate = '1/1/2017'

EXEC uspADDPRODUCT
@ProdTypeName = 'Food',
@ProdName = 'Pad Thai',
@ProdSKU = '122456',
@BeginDate = '1/5/2019'

EXEC uspADDPRODUCT
@ProdTypeName = 'Furniture',
@ProdName = 'Sofa Bed',
@ProdSKU = '233654',
@BeginDate = '3/1/2018'

EXEC uspADDPRODUCT
@ProdTypeName = 'Kitchenware',
@ProdName = 'Kitchen Knife',
@ProdSKU = '366458',
@BeginDate = '5/1/2018'

EXEC uspADDPRODUCT
@ProdTypeName = 'Alcohol',
@ProdName = 'Vodka',
@ProdSKU = '988777',
@BeginDate = '2/1/2019'

EXEC uspADDPRODUCT
@ProdTypeName = 'Alcohol',
@ProdName = 'Beer',
@ProdSKU = '111111',
@BeginDate = '2/19/2019'

GO

--Stored procedure for changing product price
CREATE PROCEDURE uspADDPRODUCTPRICE
@ProdName varchar(50),
@Price numeric(20,2),
@ProdSKU nvarchar(100),
@BeginDate date
AS
DECLARE @Prod_ID INT
SET @Prod_ID = 
	(
	SELECT ProductID
	FROM tblPRODUCT
	WHERE ProductName = @ProdName
	AND ProductSKU = @ProdSKU
	)

INSERT INTO tblPRODUCT_PRICE(ProductID, BeginDate, Price)
VALUES(@Prod_ID, @BeginDate, @Price)
GO

--Adding 5 product's prices
EXEC uspADDPRODUCTPRICE
@ProdName = 'Wool Jacket',
@Price = '80',
@ProdSKU = '222222',
@BeginDate = '2/1/2017'

EXEC uspADDPRODUCTPRICE
@ProdName = 'Pad Thai',
@Price = '5.50',
@ProdSKU = '122456',
@BeginDate = '1/1/2019'

EXEC uspADDPRODUCTPRICE
@ProdName = 'Sofa Bed',
@Price = '150.00',
@ProdSKU = '233654',
@BeginDate = '1/5/2019'

EXEC uspADDPRODUCTPRICE
@ProdName = 'Kitchen Knife',
@Price = '15.00',
@ProdSKU = '366458',
@BeginDate = '2/5/2019'

EXEC uspADDPRODUCTPRICE
@ProdName = 'Vodka',
@Price = '16.00',
@ProdSKU = '988777',
@BeginDate = '2/21/2019'

EXEC uspADDPRODUCTPRICE
@ProdName = 'Beer',
@Price = '3.00',
@ProdSKU = '111111',
@BeginDate = '2/20/2019'

--Inserting 5 vendors
INSERT INTO tblVENDOR(VendorBusinessName, VendorAddress, VendorCity, VendorCounty, VendorState, VendorZIP, VendorEmail, VendorPhone)
VALUES('Food Distribution Center', '23 100th Ave', 'Boulder', 'Boulder', 'CO', '54687', 'fooddistctr@gmail.com', '435-123-1111'),
('Clothes Distribution Center', '10 10th Ave', 'Bellevue', 'King', 'WA', '45611', 'clothesdist@center.com', '346-123-7894'),
('Beer Making Center', '23 Beer Street', 'New York', 'Manhattan', 'NY', '11101', 'beer@beermaster.com', '346-111-4567'),
('Vodka Peoples', '33 Vodka Ave', 'Seattle', 'King', 'WA', '45688', 'vodka@gmail.com', '123-111-7744'),
('Sofa Store', '10 Furniture Dr', 'Lynnwood', 'Snohomish', 'WA', '98036', 'sofa@furniture.com', '345-123-8844')
GO

--Inserting 5 shippers
INSERT INTO tblSHIPPER(ShipperCompanyName, ShipperAddress, ShipperCity, ShipperCounty, ShipperState, ShipperZIP, ShipperEmail, ShipperPhone)
VALUES('UPS', '1 1st Ave', 'Atlanta', 'Atlanta', 'GA', '28607', 'ups@ups.com', '821-164-7611'),
('FedEx', '1384 Ersel Street', 'Allen', 'Washington', 'TX', '75002', 'fedex@fedex.com', '214-363-3394'),
('USPS', '70 Bassell Avenue', 'Little Rock', 'Clay', 'AR', '72210', 'usps@usps.com', '501-733-0152'),
('DHL', '551 Rollins Road', 'Merriman', 'Greene', 'NE', '69218', 'DHL@dhl.com', '121-684-8879'),
('FastShipper', '340 Brannon Avenue', 'Jacksonville', 'Grant', 'FL', '32217', 'fast@shipper.com', '904-828-3867')
GO

--Inserting 5 shipper contacts 
CREATE PROCEDURE uspADDSHIPPERCONTACT
@ShipCoName nvarchar(35),
@FName nvarchar(35),
@LName nvarchar(35),
@Phone nvarchar(12),
@Email nvarchar(100)
AS
DECLARE @Ship_ID INT
SET @Ship_ID = 
	(
	SELECT ShipperID
	FROM tblSHIPPER
	WHERE ShipperCompanyName = @ShipCoName
	)

INSERT INTO tblSHIPPER_CONTACT(ShipperID, ShipperContactFName, ShipperContactLName, ShipperContactPhone, ShipperContactEmail)
VALUES(@Ship_ID, @FName, @LName, @Phone, @Email)
GO

EXEC uspADDSHIPPERCONTACT
@ShipCoName = 'UPS',
@FName = 'Shannon',
@LName = 'Barclay',
@Phone = '456-111-1234',
@Email = 's.barclay@gmail.com'

EXEC uspADDSHIPPERCONTACT
@ShipCoName = 'FedEx',
@FName = 'Elis',
@LName = 'Duncan',
@Phone = '456-874-9843',
@Email = 'e.dunc@fedex.com'

EXEC uspADDSHIPPERCONTACT
@ShipCoName = 'USPS',
@FName = 'Antoni',
@LName = 'Bradshaw',
@Phone = '546-987-4561',
@Email = 'a.braddy@usps.com'

EXEC uspADDSHIPPERCONTACT
@ShipCoName = 'DHL',
@FName = 'Mikaela',
@LName = 'Lutz',
@Phone = '654-987-9814',
@Email = 'lutz@dhl.com'

EXEC uspADDSHIPPERCONTACT
@ShipCoName = 'FastShipper',
@FName = 'Abdullah',
@LName = 'Blackmore',
@Phone = '198-687-1968',
@Email = 'a.blackmore@fastship.com'
GO

--Inserting 5 Orders
INSERT INTO tblORDER(CustID, OrderDate)
VALUES(3, '2/1/19'), 
(4, '3/1/19'), 
(5, '3/2/2019'), 
(2, '1/2/2019'), 
(5, '3/5/2019')
GO

--Inserting 5 tracking numbers for order shipments
INSERT INTO tblTRACK(ShipperID, TrackNum, BeginDate)
VALUES(1, 1234567, '3/10/19'),
(2, 2345678, '3/8/2019'),
(1, 3456789, '3/9/19'),
(3, 4567890, '3/8/19'),
(4, 5678901, '3/7/19')
GO 

-----------------------------------------------------------------------------
---------------Computed Columns---------------

--Computed column (TotalAmt) for the total cost of an order (within tblORDER)
CREATE FUNCTION fn_calcTotalOrder (@OrderID INT)
RETURNS NUMERIC (20,2) 
AS
BEGIN 
	DECLARE @Ret NUMERIC(30,2) =
		(SELECT SUM(PP.Price * LI.Qty) AS TotalPrice
			FROM tblLINE_ITEM LI 
			JOIN tblPRODUCT P ON LI.ProductID = P.ProductID 
			JOIN tblPRODUCT_PRICE PP ON P.ProductID = PP.ProductID
			WHERE PP.EndDate IS NULL 
			GROUP BY LI.OrderID
			HAVING LI.OrderID = @OrderID)
	RETURN @Ret 
END 
GO

ALTER TABLE tblORDER 
ADD TotalAmt as (dbo.fn_calcTotalOrder(OrderID))
GO 

--Computed column (TotalOrderAmt) for the total cost of a vendor purchase order (within tblVENDOR_PURCHASE_ORDER)
CREATE FUNCTION fn_calcTotalOrderAmt (@VenPurchaseOrderID INT)
RETURNS NUMERIC (20,2) 
AS
BEGIN 
	DECLARE @Ret NUMERIC(30,2) =
		(SELECT (VPO.OrderQty*PP.Price) AS TotalOrderAmt
			FROM tblVENDOR_PURCHASE_ORDER VPO
			JOIN tblPRODUCT P ON P.ProductID = VPO.ProductID
			JOIN tblPRODUCT_PRICE PP ON PP.ProductID = P.ProductID
			WHERE VPO.VendorPurchaseOrderID = @VenPurchaseOrderID
			AND PP.EndDate IS NULL)
	RETURN @Ret 
END 
GO

ALTER TABLE tblVENDOR_PURCHASE_ORDER
ADD TotalOrderAmt as (dbo.fn_calcTotalOrderAmt(VendorPurchaseOrderID))
GO 

-----------------------------------------------------------------------------
---------------Business Rules---------------

--In abiding with U.S. laws, this is a constraint where anyone under 21 years old can't add alcohol to their cart
CREATE FUNCTION fn_AlcoholCartUnder21()
RETURNS INT
AS
BEGIN
DECLARE @ReturnValue INT = 0
	IF EXISTS (
				SELECT *
				FROM tblCUSTOMER C 
				JOIN tblCART CA ON CA.CustID = C.CustID
				JOIN tblPRODUCT P ON P.ProductID = CA.ProductID
				JOIN tblPRODUCT_TYPE PT ON PT.ProductTypeID = P.ProductTypeID
				WHERE (DATEDIFF(DAY, C.DateOfBirth, GETDATE())/365.25 <= 21)
					AND PT.ProductTypeName = 'Alcohol'
				)
       BEGIN
				SET @ReturnValue = 1
	   END
RETURN @ReturnValue
END
GO

ALTER TABLE tblCART WITH NOCHECK
	ADD CONSTRAINT chk_AlcoholCartUnder21
	CHECK (dbo.fn_AlcoholCartUnder21() = 0)
GO

--Amy is under 21 years old and shouldn't be able to buy beer
--uspADDCART located below
EXEC uspADDCART
@FName = 'Amy',
@LName = 'Schumacher',
@DOB = '1/1/1999',
@ProdName = 'Beer',
@ProdSKU = '111111',
@Cart_Qty = '2'
GO

--Business rule where individuals under the age of 13 can't be customers 
CREATE FUNCTION fn_NoUnder13Cust()
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = 0 
       IF EXISTS (SELECT *
					FROM tblCUSTOMER
					WHERE DATEDIFF(DAY, DateOfBirth, GETDATE())/365.25 <= 13)
       BEGIN
					SET @Ret = 1
       END
RETURN @Ret
END
GO

ALTER TABLE tblCUSTOMER WITH NOCHECK
	ADD CONSTRAINT chk_NoUnder13Cust
	CHECK (dbo.fn_NoUnder13Cust() = 0)
GO

--Jon Snow is only 9 years old so he shouldn't be able to be added as a customer
EXEC uspADDCUSTOMER
@CustMembDate = '1/5/2019',
@FName = 'Jon',
@LName = 'Snow',
@Address = '4123 51st Ave',
@City = 'Seattle',
@County = 'King',
@State = 'WA',
@ZIP = '22222',
@Email = 'jsnow@gmail.com',
@Phone = '123-151-2654',
@DOB = '1/1/2010'

--- Create a business rule that customer orders should not be in the future (orders should not be made after today's date)
CREATE FUNCTION fn_NoFutureOrder()
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = 0 -- normal 
       IF EXISTS (SELECT *
					FROM tblORDER O
						WHERE OrderDate > GETDATE())
       BEGIN
              SET @Ret = 1
       END
RETURN @Ret
END
GO

ALTER TABLE tblORDER WITH NOCHECK
	ADD CONSTRAINT chk_NoFutureOrder
	CHECK (dbo.fn_NoFutureOrder() = 0)
GO

--- Customer 1 shouldn't be able to add an order for the year 2023
INSERT INTO tblORDER(CustID, OrderDate)
VALUES(1, '2/1/2023')
GO

----- Create a business rule that product SKU codes must be between 6 and 12 characters long
CREATE FUNCTION fn_SKULength()
RETURNS INT
AS
BEGIN
DECLARE @Ret INT = 0 -- normal 
       IF EXISTS (SELECT *
					FROM tblPRODUCT
					WHERE LEN(ProductSKU) NOT BETWEEN 6 AND 12)
       BEGIN
              SET @Ret = 1
       END
RETURN @Ret
END
GO

ALTER TABLE tblPRODUCT WITH NOCHECK
	ADD CONSTRAINT chk_SKULength
	CHECK (dbo.fn_SKULength() = 0)
GO

--Shouldn't be able to add Whiskey which has a SKU length of 5 
EXEC uspADDPRODUCT
@ProdTypeName = 'Alcohol',
@ProdName = 'Beer',
@ProdSKU = '12345',
@BeginDate = '2/19/2019'


-----------------------------------------------------------------------------
---------------Stored Procedures---------------

--Stored procedure, adding products to tblCART
CREATE PROCEDURE uspADDCART
@FName nvarchar(35),
@LName nvarchar(35),
@DOB Date, 
@ProdName varchar(50),
@ProdSKU nvarchar(100),
@Cart_Qty INT
AS
DECLARE @Cust_ID INT
DECLARE @Prod_ID INT
DECLARE @CartDate Date
SET @Cust_ID = 
	(
	SELECT CustID
	FROM tblCUSTOMER
	WHERE CustFName = @FName
	AND CustLName = @LName
	AND DateOfBirth = @DOB
	)
SET @Prod_ID = 
	(
	SELECT ProductID
	FROM tblPRODUCT
	WHERE ProductName = @ProdName
	AND ProductSKU = @ProdSKU
	)
SET @CartDate = GETDATE()

BEGIN TRAN T3
INSERT INTO tblCART(CustID, ProductID, Qty, CartDate) 
VALUES(@Cust_ID, @Prod_ID, @Cart_Qty, @CartDate)

IF @@ERROR <> 0
	ROLLBACK TRAN T3
ELSE 
	COMMIT TRAN T3

GO

EXEC uspADDCART
@FName = 'Harry',
@LName = 'Potter',
@DOB = '5/5/1985',
@ProdName = 'Beer',
@ProdSKU = '111111',
@Cart_Qty = '2'

EXEC uspADDCART
@FName = 'Harry',
@LName = 'Potter',
@DOB = '5/5/1985',
@ProdName = 'Wool Jacket',
@ProdSKU = '222222',
@Cart_Qty = '1'

EXEC uspADDCART
@FName = 'Harry',
@LName = 'Potter',
@DOB = '5/5/1985',
@ProdName = 'Pad Thai',
@ProdSKU = '122456',
@Cart_Qty = '1'

EXEC uspADDCART
@FName = 'Harry',
@LName = 'Potter',
@DOB = '5/5/1985',
@ProdName = 'Sofa Bed',
@ProdSKU = '233654',
@Cart_Qty = '1'

EXEC uspADDCART
@FName = 'Harry',
@LName = 'Potter',
@DOB = '5/5/1985',
@ProdName = 'Kitchen Knife',
@ProdSKU = '366458',
@Cart_Qty = '1'
GO

---Procedure to add Tracking Numbers
CREATE PROCEDURE uspADDTRACKNUMBER
@ShipCoName nvarchar(35),
@TrackNum nvarchar(35),
@BeginDate date,
@EndDate date =NULL
AS
BEGIN
DECLARE @Ship_ID INT
SET @Ship_ID = 
	(
	SELECT ShipperID
	FROM tblSHIPPER
	WHERE ShipperCompanyName = @ShipCoName
	)

INSERT INTO tblTRACK(ShipperID, TrackNum, BeginDate, EndDate)
VALUES(@Ship_ID, @TrackNum, @BeginDate,@EndDate)
END
GO

---Inserting 5 Values
EXEC uspADDTRACKNUMBER
@ShipCoName = 'DHL',
@TrackNum = 'FN2046',
@BeginDate = '3/10/2019'

EXEC uspADDTRACKNUMBER
@ShipCoName = 'UPS',
@TrackNum = 'FN2045',
@BeginDate = '3/11/2019'

EXEC uspADDTRACKNUMBER
@ShipCoName = 'FedEx',
@TrackNum = 'FN2047',
@BeginDate = '3/12/2019'

EXEC uspADDTRACKNUMBER
@ShipCoName = 'USPS',
@TrackNum = 'TN3245',
@BeginDate = '3/13/2019'

EXEC uspADDTRACKNUMBER
@ShipCoName = 'FastShipper',
@TrackNum = 'TN3246',
@BeginDate = '3/14/2019'
GO

--Stored procedure for tblSHIPMENT where orders are being assigned tracking numbers
CREATE PROCEDURE uspADDSHIPMENT
@ShipCoName nvarchar(35),
@TrackNum nvarchar(35),
@OrderNum INT,
@ShipDate date
AS
BEGIN
DECLARE @Order_ID INT
SET @Order_ID=
   (
   SELECT OrderID
   FROM tblORDER
   WHERE OrderID= @OrderNum
   )
   

DECLARE @Track_ID INT
SET @Track_ID=
    (
    SELECT TrackID
    FROM tblTRACK
	WHERE TrackNum = @TrackNum
	)

BEGIN TRAN T4
INSERT INTO tblSHIPMENT(OrderID, TrackID, ShipmentDate)
VALUES(@Order_ID, @Track_ID, @ShipDate)
IF @@ERROR <> 0
	ROLLBACK TRAN T4
ELSE 
	COMMIT TRAN T4
END
GO

---Insert 5 VALUES
EXEC uspADDSHIPMENT
@ShipCoName ='DHL',
@TrackNum = 'FN2046',
@OrderNum =1,
@ShipDate ='3/10/2019'

EXEC uspADDSHIPMENT
@ShipCoName ='UPS',
@TrackNum = 'FN2045',
@OrderNum =2,
@ShipDate ='3/11/2019'

EXEC uspADDSHIPMENT
@ShipCoName ='FedEx',
@TrackNum = 'FN2047',
@OrderNum =3,
@ShipDate ='3/12/2019'

EXEC uspADDSHIPMENT
@ShipCoName ='USPS',
@TrackNum = 'TN3245',
@OrderNum =4,
@ShipDate ='3/13/2019'

EXEC uspADDSHIPMENT
@ShipCoName ='FastShipper',
@TrackNum = 'TN3246',
@OrderNum =5,
@ShipDate ='3/14/2019'
GO

--Stored procedure, adding line items for an order
CREATE PROCEDURE uspADDLINEITEM
@FName nvarchar(35),
@LName nvarchar(35),
@DOB Date, 
@OrderDate Date,
@OrderNum INT,
@ProdName varchar(50), 
@ProdSKU nvarchar(100),
@Qty int
AS
DECLARE @Cust_ID INT
DECLARE @Ord_ID INT
DECLARE @Prod_ID INT
SET @Cust_ID = 
	(
	SELECT CustID
	FROM tblCUSTOMER
	WHERE CustFName = @FName
	AND CustLname = @LName
	AND DateOfBirth = @DOB
	)
SET @Ord_ID = 
	(
	SELECT OrderID
	FROM tblORDER
	WHERE OrderID = @OrderNum
	AND OrderDate = @OrderDate
	)
SET @Prod_ID = 
	(
	SELECT ProductID
	FROM tblPRODUCT
	WHERE ProductName = @ProdName
	AND ProductSKU = @ProdSKU
	)

BEGIN TRAN T5
INSERT INTO tblLINE_ITEM(OrderID, ProductID, Qty)
VALUES(@Ord_ID, @Prod_ID, @Qty)

IF @@ERROR <> 0
	ROLLBACK TRAN T5
ELSE 
	COMMIT TRAN T5
GO

EXEC uspADDLINEITEM
@FName = 'Fred',
@LName = 'Weasley',
@DOB = '3/1/1991',
@OrderDate = '3/1/2019',
@OrderNum = '2',
@ProdName = 'Kitchen Knife',
@ProdSKU = '366458',
@Qty = '2'
GO

EXEC uspADDLINEITEM
@FName = 'Fred',
@LName = 'Weasley',
@DOB = '3/1/1991',
@OrderDate = '3/1/2019',
@OrderNum = '2',
@ProdName = 'Beer',
@ProdSKU = '111111',
@Qty = '6'
GO

EXEC uspADDLINEITEM
@FName = 'Fred',
@LName = 'Weasley',
@DOB = '3/1/1991',
@OrderDate = '3/1/2019',
@OrderNum = '2',
@ProdName = 'Wool Jacket',
@ProdSKU = '222222',
@Qty = '6'
GO

EXEC uspADDLINEITEM
@FName = 'Amy',
@LName = 'Schumacher',
@DOB = '1/1/1999',
@OrderDate = '2/1/2019',
@OrderNum = '1',
@ProdName = 'Wool Jacket',
@ProdSKU = '222222',
@Qty = '1'
GO

EXEC uspADDLINEITEM
@FName = 'Amy',
@LName = 'Schumacher',
@DOB = '1/1/1999',
@OrderDate = '2/1/2019',
@OrderNum = '1',
@ProdName = 'Sofa Bed',
@ProdSKU = '233654',
@Qty = '1'
GO

--Stored procedure, adding new orders 
CREATE PROCEDURE uspADDORDER
@Fname varchar(40),
@LName nvarchar(35),
@DOB DATE,
@Order_Date DATE
AS
BEGIN
DECLARE @Cust_ID INT
SET @Cust_ID=
   (
   SELECT CustID
   FROM tblCUSTOMER
   WHERE CustFName = @Fname
   AND CustLName = @LName
   AND DateOfBirth = @DOB
   )

INSERT INTO tblORDER(CustID, OrderDate)
VALUES(@Cust_ID, @Order_Date)
END
GO

EXEC uspADDORDER
@Fname ='Amy',
@Lname = 'Schumacher',
@DOB ='1999-01-01',
@Order_Date = '3/10/2019'

EXEC uspADDORDER
@Fname ='Fred',
@Lname = 'Weasley',
@DOB ='1991-03-01',
@Order_Date = '2/11/2019'

EXEC uspADDORDER
@Fname ='Harry',
@Lname = 'Potter',
@DOB ='1985-05-05',
@Order_Date = '2/12/2019'

EXEC uspADDORDER
@Fname ='Hermione',
@Lname = 'Granger',
@DOB ='1989-11-01',
@Order_Date = '2/13/2019'

EXEC uspADDORDER
@Fname ='Kanye',
@Lname = 'East',
@DOB ='1989-11-01',
@Order_Date = '2/14/2019'

GO

--Stored procedure, adding new purchase orders from vendors
CREATE PROCEDURE uspADDVENDORPURCHASEORDER
@VendorName varchar(40),
@Prod_Name varchar(40),
@PurchaseDate DATE,
@OrderQty INT

AS
BEGIN
DECLARE @Vendor_ID INT
DECLARE @Prod_ID INT
DECLARE @Price INT

SET @Vendor_ID=
   (
   SELECT VendorID
   FROM tblVENDOR
   WHERE VendorBusinessName = @VendorName
   )

SET @Prod_ID=
   (
   SELECT ProductID
   FROM tblPRODUCT
   WHERE ProductName = @Prod_Name
   )

SET @Price=
   (
   SELECT Price
   FROM tblPRODUCT_PRICE PP1
   JOIN tblPRODUCT P1 ON PP1.ProductID=P1.ProductID
   WHERE PP1.ProductID = @Prod_ID
   )

INSERT INTO tblVENDOR_PURCHASE_ORDER(VendorID, ProductID, PurchaseDate, OrderQty)
VALUES(@Vendor_ID,@Prod_ID,@PurchaseDate,@OrderQty)
END
GO

---Insert 5 values into tbl Vendor Purchase Order

EXEC uspADDVENDORPURCHASEORDER
@VendorName ='Vodka Peoples',
@Prod_Name ='Vodka',
@PurchaseDate ='1900-11-01',
@OrderQty =30000

EXEC uspADDVENDORPURCHASEORDER
@VendorName ='Food Distribution Center',
@Prod_Name ='Kitchen Knife',
@PurchaseDate ='1888-12-04',
@OrderQty =50000

EXEC uspADDVENDORPURCHASEORDER
@VendorName ='Clothes Distribution Center',
@Prod_Name ='Wool Jacket',
@PurchaseDate ='1945-3-01',
@OrderQty = 990000

EXEC uspADDVENDORPURCHASEORDER
@VendorName ='Food Distribution Center',
@Prod_Name ='Pad Thai',
@PurchaseDate ='2015-11-01',
@OrderQty =45000

EXEC uspADDVENDORPURCHASEORDER
@VendorName ='Sofa Store',
@Prod_Name ='Sofa Bed',
@PurchaseDate ='2002-01-01',
@OrderQty =70000
GO

--- Stored Procedure for tblSHIPMENT_STATUS -- this table tracks the shipment status of various orders
CREATE PROCEDURE uspADDSHIPMENTSTATUS
@OrderID varchar(40),
@StatusName varchar(40),
@StatusDate DATE

AS
BEGIN
DECLARE @ShipmentID INT
DECLARE @StatusID INT

SET @ShipmentID=
   (
   SELECT ShipmentID
   FROM tblSHIPMENT
   WHERE OrderID = @OrderID
   )

SET @StatusID=
   (
   SELECT StatusID
   FROM tblSTATUS
   WHERE StatusName = @StatusName
   )

INSERT INTO tblSHIPMENT_STATUS(ShipmentID,StatusID, StatusDate)
VALUES(@ShipmentID,@StatusID,@StatusDate)
END
GO

--- Insert for tbl Shipment Status


EXEC uspADDSHIPMENTSTATUS
@OrderID ='1',
@StatusName = 'Pending',
@StatusDate ='02/10/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='1',
@StatusName = 'Processing',
@StatusDate ='02/11/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='1',
@StatusName = 'Shipped',
@StatusDate ='02/12/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='1',
@StatusName = 'OutForDelivery',
@StatusDate ='02/12/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='1',
@StatusName = 'Delivered',
@StatusDate ='02/13/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='2',
@StatusName = 'Pending',
@StatusDate ='02/11/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='2',
@StatusName = 'Processing',
@StatusDate ='02/11/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='2',
@StatusName = 'Shipped',
@StatusDate ='02/11/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='2',
@StatusName = 'OutForDelivery',
@StatusDate ='02/11/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='2',
@StatusName = 'Delivered',
@StatusDate ='02/15/2019'


EXEC uspADDSHIPMENTSTATUS
@OrderID ='3',
@StatusName = 'Pending',
@StatusDate ='03/1/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='3',
@StatusName = 'Processing',
@StatusDate ='03/2/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='3',
@StatusName = 'Shipped',
@StatusDate ='03/3/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='4',
@StatusName = 'Pending',
@StatusDate ='03/3/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='4',
@StatusName = 'Processing',
@StatusDate ='03/3/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='4',
@StatusName = 'Shipped',
@StatusDate ='03/4/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='5',
@StatusName = 'Pending',
@StatusDate ='03/4/2019'

EXEC uspADDSHIPMENTSTATUS
@OrderID ='5',
@StatusName = 'Processing',
@StatusDate ='03/4/2019'
