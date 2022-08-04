use PersonalTrainer;

-- Use an aggregate to count the number of Clients.
-- 500 rows
select count(*) from `client`;

--------------------

-- Use an aggregate to count Client.BirthDate.
-- The number is different than total Clients. Why? ## Null values
-- 463 rows

select count(`client`.birthdate) from `client`;

--------------------

-- Group Clients by City and count them.
-- Order by the number of Clients desc.
-- 20 rows

select `client`.City, count(*) from `client`
group by City
order by count(*) desc;

--------------------

-- Calculate a total per invoice using only the InvoiceLineItem table.
-- Group by InvoiceId.
-- You'll need an expression for the line item total: Price * Quantity.
-- Aggregate per group using SUM().
-- 1000 rows

select ili.InvoiceId , sum(ili.Price * ili.Quantity) as TotalPrice from invoicelineitem ili
group by ili.InvoiceId;

--------------------

-- Calculate a total per invoice using only the InvoiceLineItem table.
-- (See above.)
-- Only include totals greater than $500.00.
-- Order from lowest total to highest.
-- 234 rows

select ili.InvoiceId , sum(ili.Price * ili.Quantity) as TotalPrice from invoicelineitem ili
group by ili.InvoiceId
having sum(ili.Price * ili.Quantity) > 500
order by sum(ili.Price * ili.Quantity);

--------------------

-- Calculate the average line item total
-- grouped by InvoiceLineItem.Description.
-- 3 rows

select ili.`Description`, avg(ili.Price * ili.Quantity) as AvgPrice from invoicelineitem ili
group by ili.`Description`;

--------------------

-- Select ClientId, FirstName, and LastName from Client
-- for clients who have *paid* over $1000 total.
-- Paid is Invoice.InvoiceStatus = 2.
-- Order by LastName, then FirstName.
-- 146 rows

select c.ClientId , c.FirstName , c.LastName from `client` c
join invoice i on i.ClientId = c.ClientId
join invoicelineitem ili on ili.InvoiceId = i.InvoiceId
where i.InvoiceStatus = 2
group by c.ClientId
having sum(ili.Price * ili.Quantity) > 1000
order by c.LastName , c.FirstName;

--------------------

-- Count exercises by category.
-- Group by ExerciseCategory.Name.
-- Order by exercise count descending.
-- 13 rows

select ec.`name` , count(ec.ExerciseCategoryId) as count from exercisecategory ec
join exercise e on e.ExerciseCategoryId = ec.ExerciseCategoryId
group by ec.Name
order by count(ec.ExerciseCategoryId) desc;

--------------------

-- Select Exercise.Name along with the minimum, maximum,
-- and average ExerciseInstance.Sets.
-- Order by Exercise.Name.
-- 64 rows

select e.Name , min(ei.Sets) MinSets , max(ei.Sets) MaxSets , avg(ei.Sets) AvgSets from exercise e
join exerciseinstance ei on ei.ExerciseId = e.ExerciseId
group by e.Name
order by e.Name;

--------------------

-- Find the minimum and maximum Client.BirthDate
-- per Workout.
-- 26 rows
-- Sample: 
-- WorkoutName, EarliestBirthDate, LatestBirthDate
-- '3, 2, 1... Yoga!', '1928-04-28', '1993-02-07'

select w.`Name` , min(c.BirthDate) EarliestBirthDate , max(c.BirthDate) LatestBirthDate from workout w 
join clientworkout cw on cw.WorkoutId = w.WorkoutId
join `client` c on c.ClientId = cw.ClientId
group by w.`Name`
order by w.`Name`;

--------------------

-- Count client goals.
-- Be careful not to exclude rows for clients without goals.
-- 500 rows total
-- 50 rows with no goals

select c.ClientId, count(cg.GoalId) from `client` c
left join clientgoal cg on cg.ClientId = c.ClientId
group by c.ClientId
order by count(cg.GoalId);

--------------------

-- Select Exercise.Name, Unit.Name, 
-- and minimum and maximum ExerciseInstanceUnitValue.Value
-- for all exercises with a configured ExerciseInstanceUnitValue.
-- Order by Exercise.Name, then Unit.Name.
-- 82 rows

select e.Name ExerciseName, u.Name UnitName, min(eiuv.Value) MinVal, max(eiuv.Value) MaxVal from exercise e
join exerciseinstance ei on ei.ExerciseId = e.ExerciseId
join exerciseinstanceunitvalue eiuv on eiuv.ExerciseInstanceId = ei.ExerciseInstanceId
join unit u on u.UnitId = eiuv.UnitId
group by e.ExerciseId , e.Name , u.UnitId , u.Name
order by e.Name , u.Name;

--------------------

-- Modify the query above to include ExerciseCategory.Name.
-- Order by ExerciseCategory.Name, then Exercise.Name, then Unit.Name.
-- 82 rows

select ec.Name ExerciseCatName, e.Name ExerciseName, u.Name UnitName, min(eiuv.Value) MinVal, max(eiuv.Value) MaxVal from exercise e
join exercisecategory ec on ec.ExerciseCategoryId = e.ExerciseCategoryId
join exerciseinstance ei on ei.ExerciseId = e.ExerciseId
join exerciseinstanceunitvalue eiuv on eiuv.ExerciseInstanceId = ei.ExerciseInstanceId
join unit u on u.UnitId = eiuv.UnitId
group by e.ExerciseId , e.Name , u.UnitId , u.Name
order by ec.Name, e.Name , u.Name;

--------------------

-- Select the minimum and maximum age in years for
-- each Level.
-- To calculate age in years, use the MySQL function DATEDIFF.
-- 4 rows

select  w.LevelId,
		min( datediff(now(), c.birthdate)/365 ) as MinYears,
		max( datediff(now(), c.birthdate)/365 ) as MaxYears 
        from `client` c
join clientworkout cw on cw.ClientId = c.ClientId
join workout w on cw.WorkoutId = w.WorkoutId
group by  w.levelid;

--------------------

-- Stretch Goal!
-- Count logins by email extension (.com, .net, .org, etc...).
-- Research SQL functions to isolate a very specific part of a string value.
-- 27 rows (27 unique email extensions)

select concat(".", substring_index(login.emailaddress , ".", -1 )) EmailExtension , count(*)  from login
group by substring_index(login.emailaddress , ".", -1 )
order by substring_index(login.emailaddress , ".", -1 );

--------------------

-- Stretch Goal!
-- Match client goals to workout goals.
-- Select Client FirstName and LastName and Workout.Name for
-- all workouts that match at least 2 of a client's goals.
-- Order by the client's last name, then first name.
-- 139 rows

select w.name WorkoutName , c.FirstName , c.LastName , count(cg.GoalId) GoalCount
from `client` c
join clientgoal cg on cg.ClientId = c.ClientId
join goal g on g.GoalId = cg.GoalId
join workoutgoal wg on wg.GoalId = g.GoalId
join workout w on w.WorkoutId = wg.WorkoutId
#join clientworkout cw on cw.WorkoutId = wg.WorkoutId
#join `client` c2 on c2.ClientId = cw.ClientId
group by w.Name , c.FirstName , c.LastName
having count(cg.GoalId) >= 2
order by c.LastName , c.FirstName;
	
--------------------
