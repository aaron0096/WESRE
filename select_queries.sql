## Select all rows and columns from the Exercise table. (64 rows)
SELECT * from exercise;

## Select all rows and columns from the Client table. (500 rows)
SELECT * from `client`;
 
##Select all columns from Client where the City is Metairie. (29 rows)
SELECT * from `client`
WHERE City='Metairie';

##Is there a Client with the ClientId '818u7faf-7b4b-48a2-bf12-7a26c92de20c'? (0 rows)
SELECT * from `client`
WHERE ClientID='818u7faf-7b4b-48a2-bf12-7a26c92de20c';


##How many rows are in the Goal table? (17 rows)
SELECT COUNT(*) from Goal;

##Select Name and LevelId from the Workout table. (26 rows)
SELECT workout.Name , workout.LevelId from workout;


##Select Name, LevelId, and Notes from Workout where LevelId is 2. (11 rows)
SELECT workout.Name , workout.LevelId , workout.Notes from workout
WHERE LevelId=2;

##Select FirstName, LastName, and City from Client where City is Metairie, Kenner, or Gretna. (77 rows)
SELECT client.FirstName , client.LastName , client.City from `client`
WHERE city in ('Metairie', 'Kenner', 'Gretna');

##Select FirstName, LastName, and BirthDate from Client for Clients born in the 1980s. (72 rows)
SELECT client.FirstName , client.LastName , client.BirthDate from `client`
WHERE BirthDate between "1980-01-01" and "1989-12-30";

##Write the query above in a different way.
SELECT client.FirstName , client.LastName , client.BirthDate from `client`
WHERE BirthDate > "1980-01-01" AND BirthDate < "1989-12-30";

##How many rows in the Login table have a .gov EmailAddress? (17 rows)
SELECT count(*) from login
WHERE EmailAddress like '%.gov';

##How many Logins do NOT have a .com EmailAddress? (122 rows)
SELECT count(*) from login
WHERE EmailAddress not like '%.com';

##Select first and last name of Clients without a BirthDate. (37 rows)
SELECT client.firstname , client.lastname from client
where birthdate is null;

##Select the Name of each ExerciseCategory that has a parent (ParentCategoryId value is not null). (12 rows)
SELECT exercisecategory.Name from exercisecategory 
WHERE ParentCategoryId is not null;

##Select Name and Notes of each level 3 Workout that contains the word 'you' in its Notes. (4 rows)
SELECT workout.Name , workout.Notes from workout
WHERE notes LIKE '%you%' and LevelId=3;

##Select FirstName, LastName, City from Client whose LastName starts with L,M, or N and who live in LaPlace. (5 rows)
SELECT client.FirstName , client.LastName , client.City from client
where city="LaPlace" AND
(LastName like 'L%' or LastName like 'M%' or LastName like 'N%');

##Select InvoiceId, Description, Price, Quantity, ServiceDate and the line item total, a calculated value, from InvoiceLineItem,
## where the line item total is between 15 and 25 dollars. (667 rows)
SELECT `InvoiceID`, `Description`, `Price`, `Quantity`, `ServiceDate` , `Price` * `Quantity` as `Line Item Total` 
from invoicelineitem
where `Price` * `Quantity` between 15 and 25;


##Does the database include an email address for the Client, Estrella Bazely?
##This requires two queries:
##Select a Client record for Estrella Bazely. Does it exist?
##If it does, select a Login record that matches its ClientId.
SELECT client.FirstName , client.LastName , login.EmailAddress
from client
INNER JOIN login
on client.clientid = login.clientid
WHERE client.FirstName="Estrella" and client.LastName="Bazely";


##What are the Goals of the Workout with the Name 'This Is Parkour'?
##You need three queries!
##Select the WorkoutId from Workout where Name equals 'This Is Parkour'. (1 row)
##Select GoalId from WorkoutGoal where the WorkoutId matches the WorkoutId from your first query. (3 rows)
##Select the goal name from Goal where the GoalId is one of the GoalIds from your second query. (3 rows)
##Results:
##Endurance
##Muscle Bulk
##Focus: Shoulders
SELECT goal.Name
from goal

inner join workoutgoal
on workoutgoal.GoalId = goal.GoalId

inner join workout
on workout.WorkoutId = workoutgoal.WorkoutId

where workout.Name = "This Is Parkour";
