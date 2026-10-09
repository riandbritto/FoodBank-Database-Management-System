Use FoodBankDB
GO

-- Donor table
INSERT INTO Donor (DonorFirstName, DonorStreet, DonorCity, DonorState, DonorZipCode, DonorPhoneNumber, DonorEmail, DonorType)
VALUES 
('Alice', '123 Elm St', 'Boston', 'MA', 02101, 6171234567, 'alice@example.com', 'Individual'),
('Bob', '456 Oak Ave', 'Cambridge', 'MA', 02139, 6172345678, 'bob@example.com', 'Company'),
('Charlie', '789 Pine Rd', 'Somerville', 'MA', 02144, 6173456789, 'charlie@example.com', 'Individual'),
('Diana', '321 Maple St', 'Newton', 'MA', 02458, 7814567890, 'diana@example.com', 'Company'),
('Ethan', '654 Birch Ln', 'Quincy', 'MA', 02169, 6175678901, 'ethan@example.com', 'Individual'),
('Fiona', '987 Cedar St', 'Medford', 'MA', 02155, 7816789012, 'fiona@example.com', 'Individual'),
('George', '111 Spruce Ave', 'Waltham', 'MA', 02451, 7817890123, 'george@example.com', 'Company'),
('Hannah', '222 Ash Rd', 'Brookline', 'MA', 02446, 6178901234, 'hannah@example.com', 'Company'),
('Ian', '333 Willow St', 'Revere', 'MA', 02151, 6179012345, 'ian@example.com', 'Individual'),
('Jill', '444 Poplar Ln', 'Malden', 'MA', 02148, 7819123456, 'jill@example.com', 'Individual');

-- Donation table
INSERT INTO Donation (DonorID, DonationType, DonationStatus)
VALUES 
(1, 'Item', 'Complete'),
(2, 'Funds', 'Complete'),
(3, 'Item', 'Pending'),
(4, 'Funds', 'Complete'),
(5, 'Item', 'Complete'),
(6, 'Funds', 'Pending'),
(7, 'Item', 'Complete'),
(8, 'Funds', 'Complete'),
(9, 'Item', 'Pending'),
(10, 'Funds', 'Complete');

-- Funds table
INSERT INTO Funds (DonationID, Amount, PaymentMethod)
VALUES 
(2, 100, 'Cash'),
(4, 200, 'Check'),
(6, 150, 'Cash'),
(8, 300, 'Check'),
(10, 250, 'Cash');

-- DistributionCenter table
INSERT INTO DistributionCenter (CenterName, CenterStreet, CenterCity, CenterState, CenterZipCode, CenterCapacity, CenterHours)
VALUES 
('North Center', '10 Center St', 'Boston', 'MA', 02110, 500, '9AM-5PM'),
('South Center', '20 South Rd', 'Quincy', 'MA', 02169, 600, '8AM-4PM'),
('East Center', '30 East Ave', 'Cambridge', 'MA', 02139, 450, '10AM-6PM'),
('West Center', '40 West Blvd', 'Newton', 'MA', 02458, 700, '7AM-3PM'),
('Central Center', '50 Central Sq', 'Somerville', 'MA', 02144, 550, '9AM-5PM'),
('Seaport Center', '60 Harbor St', 'Boston', 'MA', 02210, 400, '8AM-6PM'),
('Riverside Center', '70 River Rd', 'Medford', 'MA', 02155, 300, '9AM-5PM'),
('Highland Center', '80 Hilltop Dr', 'Malden', 'MA', 02148, 500, '9AM-6PM'),
('Maple Center', '90 Maple Ave', 'Revere', 'MA', 02151, 350, '8AM-4PM'),
('Green Center', '100 Green St', 'Brookline', 'MA', 02446, 650, '10AM-7PM');


-- Inventory table
INSERT INTO Inventory (CenterID, InventoryCapacity, InventoryStreet, InventoryCity, InventoryState, InventoryZipCode, StockQuantity)
VALUES 
(1, 200, '10 Center St', 'Boston', 'MA', 02110, 150),
(2, 250, '20 South Rd', 'Quincy', 'MA', 02169, 180),
(3, 180, '30 East Ave', 'Cambridge', 'MA', 02139, 140),
(4, 300, '40 West Blvd', 'Newton', 'MA', 02458, 200),
(5, 220, '50 Central Sq', 'Somerville', 'MA', 02144, 160),
(6, 150, '60 Harbor St', 'Boston', 'MA', 02210, 130),
(7, 130, '70 River Rd', 'Medford', 'MA', 02155, 120),
(8, 200, '80 Hilltop Dr', 'Malden', 'MA', 02148, 150),
(9, 160, '90 Maple Ave', 'Revere', 'MA', 02151, 140),
(10, 280, '100 Green St', 'Brookline', 'MA', 02446, 190);

-- Items table
INSERT INTO Items (DonationID, InventoryID, ItemName, Quantity) VALUES 
(1, 1, 'Canned Beans', 50),
(2, 2, 'Rice', 100),
(3, 3, 'Pasta', 75),
(4, 1, 'Peanut Butter', 40),
(5, 2, 'Canned Tuna', 60),
(6, 3, 'Tomato Sauce', 90),
(7, 1, 'Baby Formula', 30),
(8, 2, 'Chips', 80),
(9, 3, 'Bottled Water', 200),
(10, 1, 'Cereal', 70);


-- Volunteer table
INSERT INTO Volunteer (CenterID, VolunteerFirstName, VolunteerLastName, VolunteerStreet, VolunteerCity, VolunteerState, VolunteerZipCode, VolunteerPhoneNumber, VolunteerEmail)
VALUES 
(1, 'Mark', 'Johnson', '15 Beacon St', 'Boston', 'MA', 02108, 6172345670, 'mark.j@example.com'),
(2, 'Nina', 'Patel', '25 Elm Rd', 'Quincy', 'MA', 02169, 7813456781, 'nina.p@example.com'),
(3, 'Luke', 'Lee', '35 Pine Ave', 'Cambridge', 'MA', 02139, 6174567892, 'luke.lee@example.com'),
(4, 'Sara', 'Kim', '45 Oak Dr', 'Newton', 'MA', 02458, 7815678903, 'sara.kim@example.com'),
(5, 'Tom', 'Garcia', '55 Maple Ln', 'Somerville', 'MA', 02144, 6176789014, 'tom.g@example.com'),
(6, 'Emma', 'Wong', '65 Cedar St', 'Boston', 'MA', 02210, 6177890125, 'emma.w@example.com'),
(7, 'Raj', 'Singh', '75 Birch Rd', 'Medford', 'MA', 02155, 7818901236, 'raj.singh@example.com'),
(8, 'Lena', 'Chen', '85 Spruce Ave', 'Malden', 'MA', 02148, 7819012347, 'lena.chen@example.com'),
(9, 'Omar', 'Ali', '95 Ash St', 'Revere', 'MA', 02151, 6179123458, 'omar.ali@example.com'),
(10, 'Grace', 'Brown', '105 Willow Dr', 'Brookline', 'MA', 02446, 6179234569, 'grace.b@example.com');

-- Supplier table
INSERT INTO Supplier (SupplierName, SupplierStreet, SupplierCity, SupplierState, SupplierZipCode, SupplierPhoneNumber, SupplierEmail)
VALUES 
('Whole Harvest Foods', '1 Supply Way', 'Boston', 'MA', 02110, 6172341234, 'contact@wholeharvest.com'),
('Fresh Essentials', '2 Delivery Rd', 'Cambridge', 'MA', 02139, 6173452345, 'orders@freshessentials.com'),
('Community Grocers', '3 Market St', 'Newton', 'MA', 02458, 7814563456, 'info@communitygrocers.org'),
('City Wholesale', '4 Bulk Blvd', 'Quincy', 'MA', 02169, 7815674567, 'sales@citywholesale.net'),
('Farm2Pantry', '5 Local Rd', 'Medford', 'MA', 02155, 7816785678, 'farm@farm2pantry.org'),
('FoodLink Inc', '6 Depot St', 'Somerville', 'MA', 02144, 6177896789, 'support@foodlink.org'),
('HealthyCo', '7 Wellness Blvd', 'Revere', 'MA', 02151, 6178907890, 'contact@healthyco.com'),
('PantryPro', '8 Box Ln', 'Malden', 'MA', 02148, 7819018901, 'help@pantrypro.org'),
('AgriFoods', '9 Grain Dr', 'Brookline', 'MA', 02446, 6179129012, 'connect@agrifoods.com'),
('BulkSource', '10 Main St', 'Boston', 'MA', 02210, 6179230123, 'bulk@bulksource.com');

-- Order table
INSERT INTO [Order] (DonationID, CenterID, OrderDate, OrderCost)
VALUES 
(1, 1, '2024-11-01', 250),
(2, 2, '2024-11-03', 300),
(3, 3, '2024-11-05', 400),
(4, 4, '2024-11-07', 350),
(5, 5, '2024-11-09', 500),
(6, 6, '2024-11-11', 600),
(7, 7, '2024-11-13', 450),
(8, 8, '2024-11-15', 550),
(9, 9, '2024-11-17', 620),
(10, 10, '2024-11-19', 700);


-- OrderItems table
INSERT INTO OrderItems (OrderID, SupplierID, OrderItemName, OrderItemQuantity, OrderItemCost)
VALUES 
(1, 1, 'Canned Corn', 100, 50),
(2, 2, 'Rice', 200, 80),
(3, 3, 'Canned Tuna', 150, 90),
(4, 4, 'Flour Bags', 120, 70),
(5, 5, 'Peanut Butter', 130, 85),
(6, 6, 'Cooking Oil', 140, 100),
(7, 7, 'Cereal Boxes', 160, 110),
(8, 8, 'Pasta', 180, 95),
(9, 9, 'Dried Beans', 200, 120),
(10, 10, 'Soup Cans', 220, 130);


-- Program table
INSERT INTO Program (CenterID, ProgramName, ProgramDescription, ProgramEligibility, ProgramDate)
VALUES 
(1, 'Family Food Package', 'Monthly food box for families in need', 'Low-income families with dependents', '2024-12-01'),
(2, 'Senior Meals', 'Prepared meals for seniors', 'Age 60+ and income-qualified', '2024-12-02'),
(3, 'Emergency Pantry Access', 'Access to pantry during emergencies', 'Anyone with emergency documentation', '2024-12-03'),
(4, 'Weekend Kids Pack', 'Nutritional packs for school children', 'K-12 students enrolled in public schools', '2024-12-04'),
(5, 'Holiday Drive', 'Seasonal support for families', 'Registered food bank recipients', '2024-12-05'),
(6, 'Veterans Program', 'Support packages for veterans', 'Must provide veteran ID', '2024-12-06'),
(7, 'Single Parents Support', 'Food support for single-parent homes', 'Must show custody paperwork', '2024-12-07'),
(8, 'Job Transition Packs', 'Short-term food aid for job seekers', 'Unemployed with proof of job search', '2024-12-08'),
(9, 'Healthy Start', 'Nutrition kits for expecting mothers', 'Pregnant or breastfeeding', '2024-12-09'),
(10, 'After-School Snack', 'Snacks for kids after school', 'Grades K-6, program registration required', '2024-12-10');


-- Recipient table
INSERT INTO Recipient (ProgramID, RecipientFirstName, RecipientLastName, RecipientPhoneNumber, RecipientEmail, RecipientHouseholdSize)
VALUES 
(1, 'Emily', 'Stone', 6171112233, 'emily.stone@example.com', 4),
(2, 'George', 'Brown', 6172223344, 'george.b@example.com', 1),
(3, 'Linda', 'Martinez', 6173334455, 'linda.m@example.com', 3),
(4, 'Carlos', 'Lopez', 6174445566, 'carlos.lopez@example.com', 5),
(5, 'Tina', 'Nguyen', 6175556677, 'tina.nguyen@example.com', 2),
(6, 'Peter', 'Williams', 6176667788, 'peter.w@example.com', 1),
(7, 'Maria', 'Johnson', 6177778899, 'maria.j@example.com', 3),
(8, 'Jake', 'Lee', 6178889900, 'jake.lee@example.com', 2),
(9, 'Sophia', 'Kim', 6179990011, 'sophia.kim@example.com', 3),
(10, 'Brian', 'Clark', 6170001122, 'brian.clark@example.com', 4);

