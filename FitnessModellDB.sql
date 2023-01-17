DROP TABLE IF EXISTS	Membership;
DROP TABLE IF EXISTS	Trainer;
DROP TABLE IF EXISTS	Exercises;
DROP TABLE IF EXISTS	Workout;
DROP TABLE IF EXISTS	[User];
DROP TABLE IF EXISTS 	UserWorkout;

CREATE TABLE [User] (
	Id 		  		INTEGER 		IDENTITY(1,1) PRIMARY KEY,	-- auto increment
	Name 	  		VARCHAR(255)  	NOT NULL,
	PhoneNumber		VARCHAR(16) 	NOT NULL,
	TrainerId		INTEGER			NOT NULL,
	MembershipId	INTEGER 		NOT NULL,
	FOREIGN KEY (TrainerId) 		REFERENCES Trainer(Id),
	FOREIGN KEY (MembershipId) 		REFERENCES Membership(Id)
);

CREATE TABLE Workout (
	Id 		  			INTEGER 		IDENTITY(1,1) PRIMARY KEY,	-- auto increment
	NumOfExercises		INTEGER			NOT NULL,
	WorkoutDuration		VARCHAR(10)		NOT NULL,
	ExercisesId			INTEGER			NOT NULL,
	Description			VARCHAR(255),
	FOREIGN KEY (ExercisesId) 			REFERENCES Exercises(Id)
);

CREATE TABLE Exercises (
	Id 		  		INTEGER 		IDENTITY(1,1) PRIMARY KEY,	-- auto increment
	Name			VARCHAR(255) 	NOT NULL,
	MuscleGroup		VARCHAR(255) 	NOT NULL,
	[Sets]			INTEGER			NOT NULL,
	Repetitions 	INTEGER  		NOT NULL,
	Description		VARCHAR(255)
);

CREATE TABLE Trainer (
	Id 		  		INTEGER 		IDENTITY(1,1) PRIMARY KEY,	-- auto increment
	Name	  		VARCHAR(255)  	NOT NULL,
	PhoneNumber		VARCHAR(16) 	NOT NULL,
	Description		VARCHAR(255)  	NOT NULL
);

CREATE TABLE Membership(
	Id   			INTEGER  	IDENTITY(1,1) PRIMARY KEY,
	DateOfPurchase  DATE 		NOT NULL,
	DateOfExpiry	DATE		NOT NULL,
	Price  			FLOAT 		NOT NULL
);

CREATE TABLE UserWorkout(
	UserId			INTEGER		IDENTITY(1,1) PRIMARY KEY,
	WorkoutId       INTEGER		IDENTITY(1,1) PRIMARY KEY,
	FOREIGN KEY (UserId)		REFERENCES [User](Id),
	FOREIGN KEY (WorkoutId)		REFERENCES Workout(Id)
);
