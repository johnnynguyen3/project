-- Trainer Entity
CREATE TABLE Trainer (
    TrainerID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Certification VARCHAR(255) NOT NULL,
    ContactInfo VARCHAR(255) NOT NULL

);

-- Room Entity
CREATE TABLE Room (
    RoomID SERIAL PRIMARY KEY,
    Capacity INT NOT NULL,
    Availability INT NOT NULL
);

-- Club Staff Entity
CREATE TABLE ClubStaff (
    StaffID SERIAL PRIMARY KEY,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Name VARCHAR(255) UNIQUE NOT NULL,
    ContactInfo VARCHAR(255)
);

-- FitnessEquipment Entity
CREATE TABLE FitnessEquipment (
    EquipmentID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    MaitenanceSchedule Date
);

CREATE TABLE Schedule (
    ScheduleID SERIAL PRIMARY KEY,
    Description VARCHAR(255) NOT NULL,
    Date DATE,
    Duration INT,
    Time VARCHAR(255) NOT NULL,
    Type TEXT NOT NULL
);

CREATE TABLE FitnessAchievement (
    AchievementID SERIAL PRIMARY KEY,
    DateAchieved DATE,
    Description VARCHAR(255),
    MemberID INT
);

CREATE TABLE HealthStatistics (
    HealthStatID SERIAL PRIMARY KEY,
    Type VARCHAR(100),
    Value DECIMAL(10, 2),
    Date DATE,
    MemberID INT
);

-- ExerciseRoutine Entity
CREATE TABLE ExerciseRoutine (
    RoutineID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    MemberID INT
);

-- Member Entity
CREATE TABLE Member (
    MemberID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    FitnessGoals VARCHAR(255),
    ContactInfo VARCHAR(255) NOT NULL,
    LoyaltyPoints INT,
    HealthMetrics INT,
    Routine INT,
    Achievements INT,
    FOREIGN KEY (HealthMetrics) 
        REFERENCES HealthStatistics(HealthStatID),
    FOREIGN KEY (Routine) 
        REFERENCES ExerciseRoutine(RoutineID),
    FOREIGN KEY (Achievements) 
        REFERENCES FitnessAchievement(AchievementID)
);

-- Class Entity
CREATE TABLE Class (
    ClassID SERIAL PRIMARY KEY,
    ScheduleID INT,
    RoomID INT,
    Description VARCHAR(255),
    Name VARCHAR(100),
    TrainerID INT,
    FOREIGN KEY (ScheduleID) 
        REFERENCES Schedule(ScheduleID),
    FOREIGN KEY (RoomID) 
        REFERENCES Room(RoomID),
    FOREIGN KEY (TrainerID) 
        REFERENCES Trainer(TrainerID)
);

-- Transaction Entity
CREATE TABLE Transaction (
    TransactionID SERIAL PRIMARY KEY,
    Date DATE,
    Amount INT NOT NULL,
    Type VARCHAR(255) NOT NULl,
    MemberID INT
);

ALTER TABLE FitnessAchievement
    ADD FOREIGN KEY (MemberID) REFERENCES Member(MemberID);

ALTER TABLE HealthStatistics
    ADD FOREIGN KEY (MemberID) REFERENCES Member(MemberID);

ALTER TABLE Transaction
    ADD FOREIGN KEY (MemberID) REFERENCES Member(MemberID);

ALTER TABLE ExerciseRoutine
    ADD FOREIGN KEY (MemberID) REFERENCES Member(MemberID);