use FoodBankDB
go

-- drop if exists
-- procedures
IF OBJECT_ID('AddNewDonor', 'P') IS NOT NULL
    DROP PROCEDURE AddNewDonor;
IF OBJECT_ID('RemoveDonor', 'P') IS NOT NULL
    DROP PROCEDURE RemoveDonor;
IF OBJECT_ID('AddDonation', 'P') IS NOT NULL
    DROP PROCEDURE AddDonation;
IF OBJECT_ID('GetDonorHistory', 'P') IS NOT NULL
    DROP PROCEDURE GetDonorHistory;
IF OBJECT_ID('UpdateInventory', 'P') IS NOT NULL
    DROP PROCEDURE UpdateInventory;
IF OBJECT_ID('ProcessDistribution', 'P') IS NOT NULL
    DROP PROCEDURE ProcessDistribution;
IF OBJECT_ID('RegisterRecipient', 'P') IS NOT NULL
    DROP PROCEDURE RegisterRecipient;
IF OBJECT_ID('CreateOrder', 'P') IS NOT NULL
    DROP PROCEDURE CreateOrder;
IF OBJECT_ID('AddOrderItem', 'P') IS NOT NULL
    DROP PROCEDURE AddOrderItem;
IF OBJECT_ID('TrackOrder', 'P') IS NOT NULL
    DROP PROCEDURE TrackOrder;
-- views
IF OBJECT_ID('DonorDonationSummary', 'V') IS NOT NULL
    DROP VIEW DonorDonationSummary;
IF OBJECT_ID('InventoryTracking', 'V') IS NOT NULL
    DROP VIEW InventoryTracking;
IF OBJECT_ID('TotalItemsNeeded', 'V') IS NOT NULL
    DROP VIEW TotalItemsNeeded;
-- UDFs
IF OBJECT_ID('fn_GetTotalDonations', 'FN') IS NOT NULL
    DROP FUNCTION fn_GetTotalDonations;
IF OBJECT_ID('fn_GetInventoryValue', 'FN') IS NOT NULL
    DROP FUNCTION fn_GetInventoryValue;
IF OBJECT_ID('fn_CalculateRemainingStock', 'FN') IS NOT NULL
    DROP FUNCTION fn_CalculateRemainingStock;
-- triggers
IF OBJECT_ID('AuditDonation', 'U') IS NOT NULL  
    DROP TABLE AuditDonation;
IF OBJECT_ID('trg_AuditDonation', 'TR') IS NOT NULL  
    DROP TRIGGER trg_AuditDonation;
GO



-- procedures


-- add donors
CREATE PROCEDURE AddNewDonor
    @DonorFirstName VARCHAR(100),
    @DonorStreet VARCHAR(255),
    @DonorCity VARCHAR(30),
    @DonorState VARCHAR(2),
    @DonorZipCode INT,
    @DonorPhoneNumber BIGINT,
    @DonorEmail VARCHAR(100),
    @DonorType VARCHAR(30)
AS
BEGIN
    INSERT INTO Donor (DonorFirstName, DonorStreet, DonorCity, DonorState, DonorZipCode, DonorPhoneNumber, DonorEmail, DonorType)
    VALUES (@DonorFirstName, @DonorStreet, @DonorCity, @DonorState, @DonorZipCode, @DonorPhoneNumber, @DonorEmail, @DonorType);
END;
go

-- remove donor
CREATE PROCEDURE RemoveDonor
    @DonorID INT
AS
BEGIN
    -- Delete donations related to the donor
    DELETE FROM Donation
    WHERE DonorID = @DonorID;

    -- Delete orders related to the donor
    DELETE FROM [Order]
    WHERE DonationID IN (SELECT DonationID FROM Donation WHERE DonorID = @DonorID);

    -- Finally, delete the donor
    DELETE FROM Donor
    WHERE DonorID = @DonorID;
END;
GO


-- add donation
CREATE PROCEDURE AddDonation
    @DonorID INT,
    @DonationType VARCHAR(5),
    @Amount INT = NULL,
    @ItemName VARCHAR(50) = NULL,
    @Quantity INT = NULL
AS
BEGIN
    DECLARE @DonationID INT;

    -- Insert into Donation table
    INSERT INTO Donation (DonorID, DonationType, DonationStatus, DonationDate)
    VALUES (@DonorID, @DonationType, 'Pending', GETDATE());
    
    SET @DonationID = SCOPE_IDENTITY();

    -- If it's a monetary donation, add to Funds
    IF @DonationType = 'Funds'
    BEGIN
        INSERT INTO Funds (DonationID, Amount, PaymentMethod)
        VALUES (@DonationID, @Amount, 'Cash');
    END
    ELSE
    BEGIN
        -- If it's an item donation, insert into Items table
        INSERT INTO Items (DonationID, ItemName, Quantity)
        VALUES (@DonationID, @ItemName, @Quantity);
    END;
END;
go

-- get donor history
CREATE PROCEDURE GetDonorHistory
    @DonorID INT
AS
BEGIN
    SELECT DonationID, DonationType, DonationStatus, DonationDate
    FROM Donation
    WHERE DonorID = @DonorID;
END;
go

-- update inventory
CREATE PROCEDURE UpdateInventory
    @InventoryID INT,
    @ItemName VARCHAR(50),
    @Quantity INT
AS
BEGIN
    UPDATE Inventory
    SET StockQuantity = StockQuantity + @Quantity
    WHERE InventoryID = @InventoryID;
END;
go

-- allocate distributions
CREATE PROCEDURE ProcessDistribution
    @OrderID INT,          
    @InventoryID INT,      
    @ItemName VARCHAR(50), 
    @Quantity INT          
AS
BEGIN
    -- Declare variable to store available stock
    DECLARE @AvailableStock INT;

    -- Retrieve current stock quantity
    SELECT @AvailableStock = StockQuantity 
    FROM Inventory 
    WHERE InventoryID = @InventoryID;

    -- Check if enough stock is available
    IF @AvailableStock >= @Quantity
    BEGIN
        -- Deduct stock from inventory
        UPDATE Inventory
        SET StockQuantity = StockQuantity - @Quantity
        WHERE InventoryID = @InventoryID;
        
        -- Log the distribution in OrderItems
        INSERT INTO OrderItems (OrderID, OrderItemName, OrderItemQuantity)
        VALUES (@OrderID, @ItemName, @Quantity);
    END
    ELSE
    BEGIN
        -- Handle insufficient stock scenario
        PRINT 'Error: Not enough stock available.';
    END
END;
GO

-- register recipient
CREATE PROCEDURE RegisterRecipient
    @ProgramID INT,
    @RecipientFirstName VARCHAR(30),
    @RecipientLastName VARCHAR(30),
    @RecipientPhoneNumber BIGINT,
    @RecipientEmail VARCHAR(100),
    @RecipientHouseholdSize INT
AS
BEGIN
    INSERT INTO Recipient (ProgramID, RecipientFirstName, RecipientLastName, RecipientPhoneNumber, RecipientEmail, RecipientHouseholdSize)
    VALUES (@ProgramID, @RecipientFirstName, @RecipientLastName, @RecipientPhoneNumber, @RecipientEmail, @RecipientHouseholdSize);
END;
go

-- create order
CREATE PROCEDURE CreateOrder
    @DonationID INT,
    @CenterID INT,
    @OrderCost DECIMAL(10,2)
AS
BEGIN
    INSERT INTO [Order] (DonationID, CenterID, OrderDate, OrderCost)
    VALUES (@DonationID, @CenterID, GETDATE(), @OrderCost);
END;
GO

-- add order items
CREATE PROCEDURE AddOrderItem
    @OrderID INT,
    @SupplierID INT,
    @OrderItemName VARCHAR(50),
    @OrderItemQuantity INT,
    @OrderItemCost DECIMAL(10,2)
AS
BEGIN
    -- Ensure Order exists before inserting
    IF NOT EXISTS (SELECT 1 FROM [Order] WHERE OrderID = @OrderID)
    BEGIN
        PRINT 'Error: Order does not exist.';
        RETURN;
    END;

    -- Ensure Supplier exists
    IF NOT EXISTS (SELECT 1 FROM Supplier WHERE SupplierID = @SupplierID)
    BEGIN
        PRINT 'Error: Supplier does not exist.';
        RETURN;
    END;

    -- Insert new OrderItem
    INSERT INTO OrderItems (OrderID, SupplierID, OrderItemName, OrderItemQuantity, OrderItemCost)
    VALUES (@OrderID, @SupplierID, @OrderItemName, @OrderItemQuantity, @OrderItemCost);
END;
GO

-- track order
CREATE PROCEDURE TrackOrder
    @OrderID INT
AS
BEGIN
    SELECT OrderID, DonationID, CenterID, OrderDate, OrderCost
    FROM [Order]
    WHERE OrderID = @OrderID;
END;
GO

-- views

-- donor donation summary
CREATE VIEW DonorDonationSummary AS
SELECT 
    d.DonorID,
    d.DonorFirstName,
    COUNT(do.DonationID) AS TotalDonations,
    SUM(CASE WHEN do.DonationType = 'Funds' THEN f.Amount ELSE 0 END) AS TotalFundsDonated,
    SUM(CASE WHEN do.DonationType = 'Items' THEN i.Quantity ELSE 0 END) AS TotalItemsDonated
FROM Donor d
LEFT JOIN Donation do ON d.DonorID = do.DonorID
LEFT JOIN Funds f ON do.DonationID = f.DonationID
LEFT JOIN Items i ON do.DonationID = i.DonationID
GROUP BY d.DonorID, d.DonorFirstName;
GO

-- inventory tracking
CREATE VIEW InventoryTracking AS
SELECT 
    i.ItemName,                          
    SUM(i.Quantity) AS TotalStock,       
    COALESCE(SUM(oi.OrderItemQuantity), 0) AS TotalOrdered
FROM Items i
LEFT JOIN OrderItems oi ON i.ItemID = oi.OrderItemID  
GROUP BY i.ItemName;
GO

-- item quantity needed
CREATE VIEW TotalItemsNeeded AS
SELECT 
    i.ItemName,
    SUM(oi.OrderItemQuantity) AS TotalQuantityNeeded
FROM OrderItems oi
JOIN Items i ON oi.OrderItemID = i.ItemID
GROUP BY i.ItemName;
GO

-- UDFs
-- get total donations
CREATE FUNCTION fn_GetTotalDonations(@DonorID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);

    SELECT @Total = SUM(ISNULL(F.Amount, 0))
    FROM Donation D
    INNER JOIN Funds F ON D.DonationID = F.DonationID
    WHERE D.DonorID = @DonorID;

    RETURN @Total;
END;
GO

-- test case
SELECT dbo.fn_GetTotalDonations(1) AS TotalDonatedAmount;
GO

-- get inventory value
CREATE FUNCTION fn_GetInventoryValue()
RETURNS INT
AS
BEGIN
    DECLARE @TotalStock INT;

    SELECT @TotalStock = SUM(ISNULL(StockQuantity, 0))
    FROM Inventory;

    RETURN @TotalStock;
END;
GO

-- test case
SELECT dbo.fn_GetInventoryValue() AS TotalStockInAllCenters;
GO

-- remaining stock
CREATE FUNCTION fn_CalculateRemainingStock(@InventoryID INT)
RETURNS INT
AS
BEGIN
    DECLARE @RemainingStock INT;

    SELECT @RemainingStock = StockQuantity
    FROM Inventory
    WHERE InventoryID = @InventoryID;

    RETURN @RemainingStock;
END;
GO

-- test case
SELECT dbo.fn_CalculateRemainingStock(1) AS RemainingStockAtCenter;
GO

-- trigger
-- Create Audit Table
CREATE TABLE AuditDonation (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    DonationID INT,
    ActionType VARCHAR(10),
    ActionDate DATETIME DEFAULT GETDATE()
);
GO

-- Create Trigger
CREATE TRIGGER trg_AuditDonation
ON Donation
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Capture Inserted Records
    INSERT INTO AuditDonation (DonationID, ActionType)
    SELECT DonationID, 'INSERT'
    FROM inserted;

    -- Capture Updated Records
    INSERT INTO AuditDonation (DonationID, ActionType)
    SELECT DonationID, 'UPDATE'
    FROM inserted;

END;
GO

-- test case
SELECT * FROM AuditDonation;

-- insert
INSERT INTO Donation (DonorID, DonationType, DonationStatus, DonationDate)
VALUES (1, 'Item', 'Pending', GETDATE());

SELECT * FROM AuditDonation;

-- set status
UPDATE Donation
SET DonationStatus = 'Complete'
WHERE DonationID = 20;
UPDATE Donation
SET DonationStatus = 'Complete'
WHERE DonationID = 26;

SELECT * FROM AuditDonation;
SELECT * FROM Donation







