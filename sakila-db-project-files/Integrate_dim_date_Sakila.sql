# ===================================================================================
# How to Integrate a Dimension table. In other words, how to look-up Foreign Key
# values FROM a dimension table and add them to new Fact table columns.
#
# First, go to Edit -> Preferences -> SQL Editor and disable 'Safe Edits'.
# Close SQL Workbench and Reconnect to the Server Instance.
# ===================================================================================

USE sakila_project;

# ==============================================================
# Step 1: Add New Column(s)
# ==============================================================
ALTER TABLE sakila_project.fact_rental
ADD COLUMN rental_date_key int NOT NULL AFTER rental_date,
ADD COLUMN payment_date_key int NOT NULL AFTER payment_date,
ADD COLUMN return_date_key int NOT NULL AFTER return_date;

# ==============================================================
# Step 2: Update New Column(s) with value from Dimension table
#         WHERE Business Keys in both tables match.
# ==============================================================
UPDATE sakila_project.fact_rental AS fr
JOIN sakila_project.dim_date AS dd
ON DATE(fr.rental_date) = dd.full_date
SET fr.rental_date_key = dd.date_key;

UPDATE sakila_project.fact_rental AS fr
JOIN sakila_project.dim_date AS dd
ON DATE(fr.payment_date) = dd.full_date
SET fr.payment_date_key = dd.date_key;

UPDATE sakila_project.fact_rental AS fr
JOIN sakila_project.dim_date AS dd
ON DATE(fr.return_date) = dd.full_date
SET fr.return_date_key = dd.date_key;

# ==============================================================
# Step 3: Validate that newly updated columns contain valid data
# ==============================================================
SELECT rental_date
	, rental_date_key
    , payment_date
	, payment_date_key
    , return_date
    , return_date_key
FROM sakila_project.fact_rental
LIMIT 10;

# =============================================================
# Step 4: If values are correct then drop old column(s)
# =============================================================
ALTER TABLE sakila_project.fact_rental
DROP COLUMN rental_date,
DROP COLUMN payment_date,
DROP COLUMN return_date;

# =============================================================
# Step 5: Validate Finished Fact Table.
# =============================================================
SELECT * FROM sakila_project.fact_rental
LIMIT 10;

