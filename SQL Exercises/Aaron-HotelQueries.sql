## 1) Write a query that returns a list of reservations that end in July 2023, 
## including the name of the guest, the room number(s), and the reservation dates.

SELECT r.room, g.FullName , r.start_date , r.end_date from reservations r
join guest g on g.guest_id = r.guest_id
where r.end_date <= "2023-07-30" and r.end_date >= "2023-07-01";

# ------- RESULT -------
-- 205	Aaron Low	2023-06-28	2023-07-02
-- 204	Walter  Holaway	2023-07-13	2023-07-14
-- 401	Wilfred  Vise	2023-07-18	2023-07-21
-- 303	Bettyann Seery	2023-07-28	2023-07-29
# ----------------------

## 2) Write a query that returns a list of all reservations for rooms with a jacuzzi,
## displaying the guest's name, the room number, and the dates of the reservation.

SELECT g.FullName , r.room , r.start_date , r.end_date from guest g
	join reservations r on r.guest_id = g.guest_id
	join roomdata rd on rd.room = r.room
	join amenities a on a.am_id = rd.am_id
WHERE a.Jacuzzi = 1;

# ------- RESULT -------
-- Karie  Yang	201	2023-03-06	2023-03-07
-- Bettyann Seery	203	2023-02-05	2023-02-10
-- Karie  Yang	203	2023-09-13	2023-09-15
-- Walter  Holaway	301	2023-04-09	2023-04-13
-- Mack Simmer	301	2023-11-22	2023-11-25
-- Bettyann Seery	303	2023-07-28	2023-07-29
-- Aaron Low	205	2023-06-28	2023-07-02
-- Wilfred  Vise	207	2023-04-23	2023-04-24
-- Duane Cullison	305	2023-02-22	2023-02-24
-- Bettyann Seery	305	2023-08-30	2023-09-01
-- Aaron Low	307	2023-03-17	2023-03-20
# ----------------------

## 3) Write a query that returns all the rooms reserved for a specific guest, including
## the guest's name, the room(s) reserved, the starting date of the reservation, and how 
## many people were included in the reservation. (Choose a guest's name from the existing data.)

SELECT g.FullName , r.room , r.start_date , r.end_date , r.Adults , r.Children ,
	   sum(r.adults + r.children ) TotalGuest from guest g
	join reservations r on r.guest_id = g.guest_id
where g.FullName like "Mack Simmer"
group by r.reservationid;

# ------- RESULT -------
-- Mack Simmer	308	2023-02-02	2023-02-04	1	0	1
-- Mack Simmer	208	2023-09-16	2023-09-17	2	0	2
-- Mack Simmer	206	2023-11-22	2023-11-25	2	0	2
-- Mack Simmer	301	2023-11-22	2023-11-25	2	2	4
# ----------------------

## 4) Write a query that returns a list of rooms, reservation ID, and per-room cost for each reservation.
## The results should include all rooms, whether or not there is a reservation associated with the room.

SELECT rd.room , r.reservationid , r.totalcost from reservations r
	right join roomdata rd on rd.room = r.room
order by rd.room;

# ------- RESULT -------
-- 201	4	199.99
-- 202	7	349.98
-- 203	2	999.95
-- 203	21	399.98
-- 204	16	184.99
-- 205	15	699.96
-- 206	12	599.96
-- 206	23	449.97
-- 207	10	174.99
-- 208	13	599.96
-- 208	20	149.99
-- 301	9	799.96
-- 301	24	599.97
-- 302	6	924.95
-- 302	25	699.96
-- 303	18	199.99
-- 304	14	184.99
-- 305	3	349.98
-- 305	19	349.98
-- 306		
-- 307	5	524.97
-- 308	1	299.98
-- 401	11	1199.97
-- 401	17	1259.97
-- 401	22	1199.97
-- 402		
# ----------------------

## 5) Write a query that returns all the rooms accommodating at least three guests and that are reserved on any date in April 2023.

SELECT r.room , sum(r.adults + r.children) TotalGuests from reservations r
where r.start_date >= '2023-04-1' and r.end_date <= '2023-04-30'
group by r.reservationid
having sum(r.adults + r.children) >= 3;

# ------- RESULT -------
# NULL RESULT
# ----------------------

## 6) Write a query that returns a list of all guest names and the number of reservations per guest,
## sorted starting with the guest with the most reservations and then by the guest's last name.

SELECT count(*) TotalReservations , g.FirstName , g.LastName from guest g
join reservations r on r.guest_id = g.guest_id
group by g.guest_id
order by count(*) , g.LastName;

# ------- RESULT -------
-- 1	Zachery 	Luechtefeld
-- 2	Duane	Cullison
-- 2	Walter 	Holaway
-- 2	Aurore 	Lipton
-- 2	Aaron	Low
-- 2	Maritza 	Tilton
-- 2	Joleen 	Tison
-- 2	Wilfred 	Vise
-- 2	Karie 	Yang
-- 3	Bettyann	Seery
-- 4	Mack	Simmer
# ----------------------

## 7) Write a query that displays the name, address, and phone number of a guest based
## on their phone number. (Choose a phone number from the existing data.)

SELECT g.FullName , g.Address , g.Phone from guest g
where g.Phone like "(377) 507-0974";

# ------- RESULT -------
-- Aurore  Lipton	762 Wild Rose Street	(377) 507-0974
# ----------------------

##For each query, include:
##The request from this assignment as a comment above the query, including the number
##The query itself
##The results of the query in a comment under the query