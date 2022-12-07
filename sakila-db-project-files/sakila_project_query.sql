SELECT dim_customer.first_name, 
	dim_customer.last_name,
	SUM(dim_payment.amount) AS total_payments,
	COUNT(dim_rental.rental_id) AS total_rentals
FROM sakila_project.fact_rental

JOIN sakila_project.dim_customer
ON fact_rental.customer_id = dim_customer.customer_id

JOIN sakila_project.dim_payment
ON fact_rental.payment_id = dim_payment.payment_id

JOIN sakila_project.dim_rental
ON fact_rental.rental_id = dim_rental.rental_id

GROUP BY dim_customer.customer_id
ORDER BY total_payments desc;
