USE tempdb;
GO    
BEGIN
    DECLARE @DBNAME AS VARCHAR(MAX) = 'FitnessDB'
    IF EXISTS(SELECT * FROM sys.databases WHERE Name = @DBNAME)
    BEGIN
        -- Disconnect all users and recreate database.
        EXEC('ALTER DATABASE ' + @DBNAME + ' SET SINGLE_USER WITH ROLLBACK IMMEDIATE');
        EXEC('DROP DATABASE ' + @DBNAME);
    END;
    EXEC('CREATE DATABASE ' + @DBNAME);
END;
USE FitnessDB;   -- Change to your database name (USE does not allow variables)
GO

-- Create tables

CREATE TABLE Membership (
    Id INT NOT NULL,
    DateOfPurchase DATE NOT NULL,
    DateOfExpiry DATE NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Trainer (
    Id INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    Description NVARCHAR(100) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE [User] (
    Id INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    TrainerId INT,
    MembershipId INT,
    PRIMARY KEY (Id),
    FOREIGN KEY (TrainerId) REFERENCES Trainer(Id),
    FOREIGN KEY (MembershipId) REFERENCES Membership(Id)
);

CREATE TABLE Exercise (
    Id INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    MuscleGroup NVARCHAR(50) NOT NULL,
    Sets INT NOT NULL,
    Repetitions INT NOT NULL,
    Description NVARCHAR(100) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Workout (
    Id INT NOT NULL,
    NumOfExercises INT NOT NULL,
    WorkoutDuration TIME NOT NULL,
    Description NVARCHAR(100) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE UserWorkout (
    UserId INT NOT NULL,
    WorkoutId INT NOT NULL,
    Date DATE NOT NULL,
    PRIMARY KEY (UserId, WorkoutId),
    FOREIGN KEY (UserId) REFERENCES [User](Id),
    FOREIGN KEY (WorkoutId) REFERENCES Workout(Id)
);

