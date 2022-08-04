USE PersonalTrainer;

-- Select all columns from ExerciseCategory and Exercise.
-- The tables should be joined on ExerciseCategoryId.
-- This query returns all Exercises and their associated ExerciseCategory.
-- 64 rows
Select * from exercisecategory
inner join exercise
on exercisecategory.ExerciseCategoryID = exercise.exercisecategoryID;

--------------------
    
-- Select ExerciseCategory.Name and Exercise.Name
-- where the ExerciseCategory does not have a ParentCategoryId (it is null).
-- Again, join the tables on their shared key (ExerciseCategoryId).
-- 9 rows
Select * from exercisecategory
inner join exercise
on exercisecategory.ExerciseCategoryID = exercise.exercisecategoryID
where exercisecategory.ParentCategoryId is null;

--------------------

-- The query above is a little confusing. At first glance, it's hard to tell
-- which Name belongs to ExerciseCategory and which belongs to Exercise.
-- Rewrite the query using an aliases. 
-- Alias ExerciseCategory.Name as 'CategoryName'.
-- Alias Exercise.Name as 'ExerciseName'.
-- 9 rows
Select *, exercisecategory.Name as CategoryName , exercise.Name as ExerciseName
from exercisecategory
inner join exercise
on exercisecategory.ExerciseCategoryID = exercise.exercisecategoryID
where exercisecategory.ParentCategoryId is null;

--------------------

-- Select FirstName, LastName, and BirthDate from Client
-- and EmailAddress from Login 
-- where Client.BirthDate is in the 1990s.
-- Join the tables by their key relationship. 
-- What is the primary-foreign key relationship?
-- 35 rows

Select `client`.firstname , `client`.lastname , `client`.BirthDate , login.EmailAddress
from `client`
inner join login
on login.ClientId = `client`.ClientId
where `client`.BirthDate between "1990-01-01" and "1999-12-30" ;

--------------------

-- Select Workout.Name, Client.FirstName, and Client.LastName
-- for Clients with LastNames starting with 'C'?
-- How are Clients and Workouts related?
-- 25 rows

Select Workout.Name, Client.FirstName, Client.LastName
from `client`
inner join clientworkout on clientworkout.ClientId = `client`.ClientId
inner join workout on workout.WorkoutId = clientworkout.WorkoutId
where `client`.LastName like "C%";

--------------------

-- Select Names from Workouts and their Goals.
-- This is a many-to-many relationship with a bridge table.
-- Use aliases appropriately to avoid ambiguous columns in the result.

Select workout.name as WorkoutName , goal.name as GoalName from workout
inner join workoutgoal on workout.WorkoutId = workoutgoal.WorkoutId
inner join goal on workoutgoal.GoalId = goal.GoalId
order by workout.name asc;

--------------------

-- Select FirstName and LastName from Client.
-- Select ClientId and EmailAddress from Login.
-- Join the tables, but make Login optional.
-- 500 rows

select `client`.FirstName , `client`.LastName , Login.clientID , login.EmailAddress
from `client`
left outer join login on login.ClientId = `client`.ClientId
order by `client`.FirstName , `client`.LastName;

--------------------

-- Using the query above as a foundation, select Clients
-- who do _not_ have a Login.
-- 200 rows

select `client`.FirstName , `client`.LastName , Login.clientID , login.EmailAddress from `client`
left outer join login on login.ClientId = `client`.ClientId
where login.EmailAddress is null
order by `client`.FirstName , `client`.LastName;

--------------------

-- Does the Client, Romeo Seaward, have a Login?
-- Decide using a single query.
-- nope :(

select `client`.FirstName , `client`.LastName , Login.clientID , login.EmailAddress from `client`
Left join login on login.ClientId = `client`.ClientId
where `client`.FirstName like "Romeo" and `client`.LastName like "Seaward";

--------------------

-- Select ExerciseCategory.Name and its parent ExerciseCategory's Name.
-- This requires a self-join.
-- 12 rows

select c.`name` `Name` , p.ParentCategoryId
from exercisecategory p
join exercisecategory c
on p.ParentCategoryId = c.ExerciseCategoryId ;

--------------------
    
-- Rewrite the query above so that every ExerciseCategory.Name is
-- included, even if it doesn't have a parent.
-- 16 rows

select c.`name` `Name` , p.ParentCategoryId
from exercisecategory p
left join exercisecategory c
on p.ParentCategoryId = c.ExerciseCategoryId ;

--------------------
    
-- Are there Clients who are not signed up for a Workout?
-- 50 rows

select c.`firstname` , c.`lastname` , cw.workoutid
from `client` c
left join clientworkout cw
on c.ClientId = cw.ClientId
where cw.WorkoutId is null
order by c.`FirstName`, c.`LastName`;

--------------------

-- Which Beginner-Level Workouts satisfy at least one of Shell Creane's Goals?
-- Goals are associated to Clients through ClientGoal.
-- Goals are associated to Workouts through WorkoutGoal.
-- 6 rows, 4 unique rows

select distinct w.`name` , w.`levelid` from workout w
inner join workoutgoal wg on wg.WorkoutId = w.WorkoutId
inner join `goal` g on g.GoalId = wg.GoalId
inner join clientgoal cg on cg.GoalId = g.GoalId
inner join `client` c on c.ClientId = cg.ClientId
where c.FirstName like "Shell" and c.LastName like "Creane"
and w.LevelId=1
order by w.`name`;

--------------------

-- Select all Workouts. 
-- Join to the Goal, 'Core Strength', but make it optional.
-- You may have to look up the GoalId before writing the main query.
-- If you filter on Goal.Name in a WHERE clause, Workouts will be excluded.
-- Why? ### Optional join on 'Core Strength' includes other goalnames
-- 26 Workouts, 3 Goals

select distinct w.`Name` WorkoutName, g.Name from goal g
left join workoutgoal wg on wg.GoalId = g.GoalId
left join workout w on w.WorkoutId = wg.WorkoutId;
##where g.`Name` like "Core Strength" or g.`Name` is null;


--------------------

-- The relationship between Workouts and Exercises is... complicated.
-- Workout links to WorkoutDay (one day in a Workout routine)
-- which links to WorkoutDayExerciseInstance 
-- (Exercises can be repeated in a day so a bridge table is required) 
-- which links to ExerciseInstance 
-- (Exercises can be done with different weights, repetions,
-- laps, etc...) 
-- which finally links to Exercise.
-- Select Workout.Name and Exercise.Name for related Workouts and Exercises.

select distinct w.Name WorkoutName , e.Name ExerciseName from workout w
join workoutday wd on wd.WorkoutId = w.WorkoutId
join workoutdayexerciseinstance wdei on wdei.WorkoutDayId = wd.WorkoutDayId
join exerciseinstance ei on ei.ExerciseInstanceId = wdei.ExerciseInstanceId
join exercise e on e.ExerciseId = ei.ExerciseId
order by w.Name , e.Name;

--------------------
   
-- An ExerciseInstance is configured with ExerciseInstanceUnitValue.
-- It contains a Value and UnitId that links to Unit.
-- Example Unit/Value combos include 10 laps, 15 minutes, 200 pounds.
-- Select Exercise.Name, ExerciseInstanceUnitValue.Value, and Unit.Name
-- for the 'Plank' exercise. 
-- How many Planks are configured, which Units apply, and what 
-- are the configured Values?
-- 4 rows, 1 Unit, and 4 distinct Values

select e.name ExerciseName , concat(eiuv.value ," ",u.name) as Exercise, eiuv.value , u.name UnitName from exercise e
join exerciseinstance ei on ei.ExerciseId = e.ExerciseId
join exerciseinstanceunitvalue eiuv on eiuv.ExerciseInstanceId = ei.ExerciseInstanceId
join unit u on u.UnitId = eiuv.UnitId
where e.name like "Plank";


--------------------