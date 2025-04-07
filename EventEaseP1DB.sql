-- Switch to master database
USE master;

-- Drop database if it exists
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'EventEaseP1DB')
BEGIN
    ALTER DATABASE EventEaseP1DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EventEaseP1DB;
END

-- Create the new database
CREATE DATABASE EventEaseP1DB;

-- Switch to the new database
USE EventEaseP1DB;

-- Venue Table
CREATE TABLE Venue (
    VenueID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing VenueID
    VenueName VARCHAR(355) NOT NULL,
    Location VARCHAR(355) NOT NULL,
    Capacity INT NOT NULL,
    ImageUrl VARCHAR(500)
);

-- Insert example data
INSERT INTO Venue (VenueName, Location, Capacity, ImageUrl)
VALUES ('The Social Club', 'PTA', 1250, 'https://www.google.com/imgres?q=the%20social%20club%20pretoria&imgurl=https%3A%2F%2Flookaside.fbsbx.com%2Flookaside%2Fcrawler%2Fmedia%2F%3Fmedia_id%3D975567907902815&imgrefurl=https%3A%2F%2Fwww.facebook.com%2Fphoto.php%3Ffbid%3D975567907902815%26id%3D100063488439328%26set%3Da.534042562055354&docid=rTDev2BgaQ574M&tbnid=jUPPIiPCRIgkKM&vet=12ahUKEwjSxpf8pcSMAxXaVkEAHeewKgUQM3oECBYQAA..i&w=1440&h=961&hcb=2&ved=2ahUKEwjSxpf8pcSMAxXaVkEAHeewKgUQM3oECBYQAA');

-- Event Table
CREATE TABLE Event (
    EventID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing EventID
    EventName VARCHAR(355) NOT NULL,
    EventDate DATE NOT NULL DEFAULT GETDATE(),
    Description VARCHAR(MAX),
    VenueID INT NULL,
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
);

-- Insert example data
INSERT INTO Event (EventName, EventDate,Description,VenueID)
VALUES ('Spring Break', '2024-09-17','HERE WE GO!',Null);

-- Booking Table
CREATE TABLE Booking(
    BookingID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing BookingID
    EventID INT NOT NULL,
    VenueID INT NOT NULL,
    BookingDate DATE NOT NULL DEFAULT GETDATE()
    FOREIGN KEY (EventID) REFERENCES Event(EventId),
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueId),
    CONSTRAINT UQ_Booking UNIQUE (EventId, VenueId)
);

    INSERT INTO Booking (EventID, VenueID, BookingDate)
    VALUES (1, 1, '2024-06-10');


-- Final Data Check (only select from the three tables)
SELECT * FROM Venue;
SELECT * FROM Event;
SELECT * FROM Booking;