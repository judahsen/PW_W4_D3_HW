--1. List all customers who live in Texas (use
--JOINs)

SELECT CONCAT (first_name,' ' ,last_name) AS Name, district
FROM customer
JOIN address
ON customer.address_id = address.address_id 
WHERE district = 'Texas';
--Jennifer Davis,Kim Cruz, Richard Mccrary,Bryan Hardison,Ian Still 

--2. Get all payments above $6.99 with the Customer's Full Name 

select concat(first_name, ' ' , last_name) as name, amount
from customer 
join payment
on customer.customer_id = payment.customer_id 
where amount > 6.99

--3. Show all customers names who have made payments over $175(use subqueries) 

select first_name, last_name
from customer 
where customer_id IN(
	select customer_id
	from payment
	group by customer_id
	having SUM(amount) > 175
	order by SUM (amount) desc 
	);

--4. List all customers that live in Nepal (use the city table) 

select CONCAT(first_name, ' ', last_name) as full_name, country
from customer 
join address 
on customer.address_id = address.address_id 
join city 
on address.city_id = city.city_id 
join country 
on city.country_id = country.country_id 
where country = 'Nepal';
-- only showed 1 Kevin Schuler

--5. Which staff member had the most transactions? 

select CONCAT(first_name, ' ', last_name) as full_name, count(amount) as total_transactions
from staff 
join payment 
on staff.staff_id = payment.staff_id 
group by full_name
order by count(amount) desc;
-- jon Stephens = 7304

--6. How many movies of each rating are there? 

select rating, count(rating) as total_rating_movies
from film 
group by rating;
-- NC-17 =210 ,G = 178 , PG = 194, R = 195, PG-13 = 223

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

select first_name, last_name
from customer 
where customer_id IN(
	select customer_id 
	from payment 
	group by customer_id 
	having SUM(amount) > 6.99
	order by sum (amount) desc
);

--8. How many free rentals did our stores give away?

SELECT count(rental_id) AS total_rentals_given
FROM rental
WHERE rental_id  IN (
	SELECT rental_id
	FROM payment
	GROUP BY rental_id 
	HAVING SUM (amount) = 0
);
-- 24 free rentals