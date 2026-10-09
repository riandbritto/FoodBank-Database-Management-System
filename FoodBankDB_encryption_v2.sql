USE FoodBankDB;
GO

-- Drop the 'EncryptedAmount' column if it exists in the Funds table
IF EXISTS (
    SELECT * FROM sys.columns 
    WHERE object_id = OBJECT_ID('Funds') AND name = 'EncryptedAmount'
)
BEGIN
    ALTER TABLE Funds DROP COLUMN EncryptedAmount;
END
GO

-- Drop encryption objects if they exist
IF EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'DonationSymmetricKey')
    DROP SYMMETRIC KEY DonationSymmetricKey;

IF EXISTS (SELECT * FROM sys.certificates WHERE name = 'DonationCert')
    DROP CERTIFICATE DonationCert;

IF EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
    DROP MASTER KEY;
GO

-- Create the master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongPassword123!';
GO

-- Create the certificate
CREATE CERTIFICATE DonationCert  
WITH SUBJECT = 'Donation Encryption Certificate';
GO

-- Create the symmetric key
CREATE SYMMETRIC KEY DonationSymmetricKey  
WITH ALGORITHM = AES_256  
ENCRYPTION BY CERTIFICATE DonationCert;
GO

-- Add the EncryptedAmount column to the Funds table
ALTER TABLE Funds  
ADD EncryptedAmount VARBINARY(MAX);
GO

-- Open symmetric key, encrypt values, and decrypt for viewing in the same session
OPEN SYMMETRIC KEY DonationSymmetricKey DECRYPTION BY CERTIFICATE DonationCert;

-- Encrypt the Amount values into EncryptedAmount
UPDATE Funds
SET EncryptedAmount = ENCRYPTBYKEY(KEY_GUID('DonationSymmetricKey'), CAST(Amount AS VARBINARY(MAX)))
WHERE Amount IS NOT NULL;

-- View original and decrypted amounts
SELECT DonationID, 
       Amount,
       CASE 
           WHEN DECRYPTBYKEY(EncryptedAmount) IS NOT NULL 
           THEN CONVERT(INT, DECRYPTBYKEY(EncryptedAmount)) 
           ELSE NULL 
       END AS DecryptedAmount
FROM Funds;

-- Close the symmetric key
CLOSE SYMMETRIC KEY DonationSymmetricKey;
GO
