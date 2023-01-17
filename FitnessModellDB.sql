DROP TABLE IF EXISTS	Membership;
DROP TABLE IF EXISTS	Trainer;
DROP TABLE IF EXISTS	Exercises;
DROP TABLE IF EXISTS	Workout;
DROP TABLE IF EXISTS	[User];
DROP TABLE IF EXISTS 	UserWorkout;

CREATE TABLE [User] (
	Id 		  		INTEGER 		IDENTITY(1,1) PRIMARY KEY,	-- auto increment
	Name 	  		VARCHAR(255)  	NOT NULL UNIQUE,
	PhoneNumber		VARCHAR(16) 	NOT NULL UNIQUE,
	TrainerId		INTEGER			NOT NULL UNIQUE,
	MembershipId	INTEGER 		NOT NULL UNIQUE,
	FOREIGN KEY (TrainerId) 		REFERENCES Trainer(Id),
	FOREIGN KEY (MembershipId) 		REFERENCES Membership(Id)
);

CREATE TABLE Workout (
	Id 		  			INTEGER 		IDENTITY(1,1) PRIMARY KEY,	-- auto increment
	NumOfExercises		INTEGER			NOT NULL UNIQUE,
	WorkoutDuration		VARCHAR(10)		NOT NULL UNIQUE,
	ExercisesId			INTEGER			NOT NULL UNIQUE,
	Description			VARCHAR(255),
	FOREIGN KEY (ExercisesId) 			REFERENCES Exercises(Id)
);

CREATE TABLE Exercises (
	Id 		  		INTEGER 		IDENTITY(1,1) PRIMARY KEY,	-- auto increment
	Name			VARCHAR(255) 	NOT NULL UNIQUE,
	MuscleGroup		VARCHAR(255) 	NOT NULL UNIQUE,
	[Sets]			INTEGER			NOT NULL UNIQUE,
	Repetitions 	INTEGER  		NOT NULL UNIQUE,
	Description		VARCHAR(255)
);

CREATE TABLE Trainer (
	Id 		  		INTEGER 		IDENTITY(1,1) PRIMARY KEY,	-- auto increment
	Name	  		VARCHAR(255)  	NOT NULL UNIQUE,
	PhoneNumber		VARCHAR(16) 	NOT NULL UNIQUE,
	Description		VARCHAR(255)  	NOT NULL UNIQUE
);

CREATE TABLE Membership(
	Id   			INTEGER  	IDENTITY(1,1) PRIMARY KEY,
	DateOfPurchase  DATE 		NOT NULL UNIQUE,
	DateOfExpiry	DATE		NOT NULL UNIQUE,
	Price  			FLOAT 		NOT NULL UNIQUE
);

CREATE TABLE UserWorkout(
	UserId			INTEGER		IDENTITY(1,1) PRIMARY KEY,
	WorkoutId       INTEGER		IDENTITY(1,1) PRIMARY KEY,
	FOREIGN KEY (UserId)		REFERENCES [User](Id),
	FOREIGN KEY (WorkoutId)		REFERENCES Workout(Id)
);
