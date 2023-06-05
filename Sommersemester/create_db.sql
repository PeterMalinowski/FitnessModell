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
    Description NVARCHAR(100),
    PRIMARY KEY (Id)
);

CREATE TABLE [User] (
    Id INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    MembershipId INT NOT NULL,
    TrainerId INT,
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
    OverExerciseId INT,
    Description NVARCHAR(100),
    ExcerciseAttributes VARCHAR(MAX) NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (OverExerciseId) REFERENCES Exercise(Id)
);

CREATE TABLE Workout (
    Id INT NOT NULL,
    NumOfExercises INT NOT NULL,
    WorkoutDuration TIME NOT NULL,
    Description NVARCHAR(100),
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

CREATE VIEW OverExcercise AS 
SELECT e.Id AS ExerciseId, e.Name, o.Id AS OverExerciseId, o.Name AS OverExerciseName
FROM Exercise e
LEFT JOIN Exercise o ON e.OverExerciseId = o.Id;

INSERT INTO Exercise (Id, Name, MuscleGroup, Sets, Repetitions, OverExerciseId, Description, ExcerciseAttributes)
VALUES
    (1, 'Push-ups', 'Chest', 3, 10, 1, 'Basic bodyweight exercise', 'Difficulty: Beginner'),
    (2, 'Squats', 'Legs', 4, 12, 1, 'Compound lower-body exercise', 'Difficulty: Intermediate'),
    (3, 'Bench Press', 'Chest', 4, 8, 2, 'Strength training exercise', 'Difficulty: Advanced'),
    (4, 'Deadlifts', 'Back', 3, 6, 2, 'Full-body compound movement', 'Difficulty: Advanced'),
    (5, 'Shoulder Press', 'Shoulders', 3, 10, 1, 'Upper-body pressing exercise', 'Difficulty: Intermediate'),
    (6, 'Bicep Curls', 'Arms', 3, 12, NULL, 'Isolation exercise for biceps', 'Difficulty: Beginner'),
    (7, 'Plank', 'Core', 2, 60, NULL, 'Core-strengthening exercise', 'Difficulty: Beginner'),
    (8, 'Lunges', 'Legs', 3, 10, NULL, 'Lower-body exercise', 'Difficulty: Beginner'),
    (9, 'Dumbbell Flyes', 'Chest', 3, 12, 3, 'Isolation exercise for chest', 'Difficulty: Intermediate'),
    (10, 'Leg Press', 'Legs', 3, 15, 2, 'Compound leg exercise', 'Difficulty: Intermediate'),
    (11, 'Pull-ups', 'Back', 3, 8, 4, 'Upper-body compound exercise', 'Difficulty: Intermediate'),
    (12, 'Arnold Press', 'Shoulders', 3, 10, 5, 'Dumbbell shoulder exercise', 'Difficulty: Intermediate');

SELECT * FROM OverExcercise;