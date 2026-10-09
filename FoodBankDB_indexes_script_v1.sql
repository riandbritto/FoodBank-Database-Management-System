use FoodBankDB
go

-- non clustered indexes

-- drop if exists
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_DonorPhoneNumber' AND object_id = OBJECT_ID('Donor'))
BEGIN
    DROP INDEX IX_DonorPhoneNumber ON Donor;
END

IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_DonationStatus' AND object_id = OBJECT_ID('Donation'))
BEGIN
    DROP INDEX IX_DonationStatus ON Donation;
END

IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_RecipientEmail' AND object_id = OBJECT_ID('Recipient'))
BEGIN
    DROP INDEX IX_RecipientEmail ON Recipient;
END


-- donor phone number
CREATE NONCLUSTERED INDEX IX_DonorPhoneNumber
ON Donor (DonorPhoneNumber);

-- donation status
CREATE NONCLUSTERED INDEX IX_DonationStatus
ON Donation (DonationStatus);

-- recipient email
CREATE NONCLUSTERED INDEX IX_RecipientEmail
ON Recipient (RecipientEmail);

-- test case (time performance test)

-- Query without index
SET STATISTICS TIME ON;

SELECT * FROM Donor
WHERE DonorPhoneNumber = '6171234567';

SET STATISTICS TIME OFF;

-- Query after creating the indexes
SET STATISTICS TIME ON;

SELECT * FROM Donor
WHERE DonorPhoneNumber = '6171234567';

SET STATISTICS TIME OFF;




