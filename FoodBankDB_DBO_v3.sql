--CREATE DATABASE FoodBankDB

IF DB_ID('FoodBankDB') IS NULL
BEGIN
    CREATE DATABASE FoodBankDB;
END;
GO

USE FoodBankDB;
GO


-- drop if exists
DROP TABLE IF EXISTS Items
DROP TABLE IF EXISTS Funds
DROP TABLE IF EXISTS OrderItems
DROP TABLE IF EXISTS [Order]
DROP TABLE IF EXISTS Donation
DROP TABLE IF EXISTS Volunteer
DROP TABLE IF EXISTS Donor
DROP TABLE IF EXISTS Inventory
DROP TABLE IF EXISTS Recipient
DROP TABLE IF EXISTS Program
DROP TABLE IF EXISTS DistributionCenter
DROP TABLE IF EXISTS Supplier



-- Donor table
CREATE TABLE Donor(
    DonorID int IDENTITY(1, 1)  not null,
    DonorFirstName VARCHAR(100),
    DonorStreet VARCHAR(255),
    DonorCity VARCHAR(30),
    DonorState CHAR(2),
    DonorZipCode CHAR(5) not null,
    DonorPhoneNumber CHAR(10) unique,
    DonorEmail VARCHAR(100) unique,
    DonorType VARCHAR(30) CONSTRAINT DonorType_CHK CHECK (DonorType in ('Individual', 'Company'))
    CONSTRAINT Donor_PK PRIMARY KEY(DonorID) 
);

-- Donation table
Create TABLE Donation(
    DonationID int IDENTITY(1, 1) not null,
    DonorID int not null,
    DonationType VARCHAR(5) CONSTRAINT DonationType_CHK CHECK (DonationType in ('Item', 'Funds')) not null,
    DonationStatus VARCHAR(20) CONSTRAINT Status_CHK CHECK (DonationStatus in ('Pending', 'Complete')),
    DonationDate DATETIME DEFAULT(getDate()) not null,
    CONSTRAINT Donation_PK PRIMARY KEY(DonationID),
    CONSTRAINT Donation_FK FOREIGN KEY(DonorID) REFERENCES Donor(DonorID)
);

-- Funds table
CREATE TABLE Funds(
    DonationID int not null,
    Amount int not null,
    PaymentMethod VARCHAR(50) CONSTRAINT PaymentMethod_CHK CHECK (PaymentMethod in ('Cash', 'Check')) not null,
    CONSTRAINT Fund_PK PRIMARY KEY(DonationID),
    CONSTRAINT Fund_FK FOREIGN KEY (DonationID) REFERENCES Donation(DonationID)
)

-- Distribution Center table
CREATE TABLE DistributionCenter(
    CenterID int IDENTITY(1, 1) not null,
    CenterName VARCHAR(50),
    CenterStreet VARCHAR(50) not null,
    CenterCity VARCHAR(30),
    CenterState CHAR(2),
    CenterZipCode CHAR(5) not null,
    CenterCapacity int not null,
    CenterHours VARCHAR(50)
    CONSTRAINT Center_PK PRIMARY KEY (CenterID)
);

-- Inventory table
CREATE TABLE Inventory(
    InventoryID int IDENTITY(1, 1) not null,
    CenterID int not null,
    InventoryCapacity int not null,
    InventoryStreet VARCHAR(50) not null,
    InventoryCity VARCHAR(30),
    InventoryState CHAR(2),
    InventoryZipCode CHAR(5) not null,
    StockQuantity int not NULL
    CONSTRAINT Inventory_PK PRIMARY KEY (InventoryID),
    CONSTRAINT Inventory_FK FOREIGN KEY (CenterID) REFERENCES DistributionCenter(CenterID)
);

-- Items table
CREATE TABLE Items(
    ItemID int IDENTITY(1, 1) not null,
    DonationID int not null,
    InventoryID int not null,
    ItemName VARCHAR(50) not null,
    Quantity int not null,
    CONSTRAINT Item_PK PRIMARY KEY (ItemID),
    CONSTRAINT Item_FK1 FOREIGN KEY (DonationID) REFERENCES Donation(DonationID),
    CONSTRAINT Item_FK2 FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
);



-- Volunteer table
CREATE TABLE Volunteer(
    VolunteerID int IDENTITY(1, 1) not null,
    CenterID int not null,
    VolunteerFirstName VARCHAR(30) not null,
    VolunteerLastName VARCHAR(30) not null,
    VolunteerStreet VARCHAR(50),
    VolunteerCity VARCHAR(30),
    VolunteerState CHAR(2),
    VolunteerZipCode CHAR(5),
    VolunteerPhoneNumber CHAR(10) unique not null,
    VolunteerEmail VARCHAR(100) unique,
    CONSTRAINT Volunteer_PK PRIMARY KEY (VolunteerID),
    CONSTRAINT Volunteer_FK FOREIGN KEY (CenterID) REFERENCES DistributionCenter(CenterID)
);

-- Supplier table
CREATE TABLE Supplier(
    SupplierID int IDENTITY(1, 1) not null,
    SupplierName VARCHAR(100) not null,
    SupplierStreet VARCHAR(50),
    SupplierCity VARCHAR(30),
    SupplierState CHAR(2),
    SupplierZipCode CHAR(5) not null,
    SupplierPhoneNumber CHAR(10) unique not null,
    SupplierEmail VARCHAR(100) unique,
    CONSTRAINT Supplier_PK PRIMARY KEY (SupplierID)
);

-- Order table, check if 'Order Items' entity is needed
CREATE TABLE [Order] (
    OrderID int IDENTITY(1, 1) not null,
    DonationID int not null,
    CenterID int not null,
    OrderDate DATETIME DEFAULT(getDate()) not null,
    OrderCost int not null
    CONSTRAINT Order_PK PRIMARY KEY (OrderID),
    CONSTRAINT Order_FK1 FOREIGN KEY (DonationID) REFERENCES Donation(DonationID),
    CONSTRAINT Order_FK2 FOREIGN KEY (CenterID) REFERENCES DistributionCenter(CenterID)
);

-- OrderItems table
CREATE TABLE OrderItems (
    OrderItemID int IDENTITY(1, 1) not null,
    OrderID int not null,
    SupplierID int not null,
    OrderItemName VARCHAR(50) not null,
    OrderItemQuantity int not null,
    OrderItemCost int not null,
    CONSTRAINT OrderItem_PK PRIMARY KEY (OrderItemID),
    CONSTRAINT OrderItem_FK1 FOREIGN KEY (OrderID) REFERENCES [Order](OrderID),
    CONSTRAINT OrderItem_FK2 FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),

);


-- Program table
CREATE TABLE Program(
    ProgramID int IDENTITY(1, 1) not null,
    CenterID int not null,
    ProgramName VARCHAR(100) not null,
    ProgramDescription VARCHAR(300),
    ProgramEligibility VARCHAR(500) not null,
    ProgramDate DATETIME DEFAULT(getDate()) not null,
    CONSTRAINT Program_PK PRIMARY KEY (ProgramID),
    CONSTRAINT Program_FK FOREIGN KEY (CenterID) REFERENCES DistributionCenter(CenterID)
);

-- Recipient table
CREATE TABLE Recipient (
    RecipientID int IDENTITY(1, 1) not null,
    ProgramID int not null,
    RecipientFirstName VARCHAR(30),
    RecipientLastName VARCHAR(30),
    RecipientPhoneNumber CHAR(10) unique not null,
    RecipientEmail VARCHAR(100) unique,
    RecipientHouseholdSize int not null,
    CONSTRAINT Recipient_PK PRIMARY KEY (RecipientID),
    CONSTRAINT Recipient_FK FOREIGN KEY (ProgramID) REFERENCES Program(ProgramID)
);
