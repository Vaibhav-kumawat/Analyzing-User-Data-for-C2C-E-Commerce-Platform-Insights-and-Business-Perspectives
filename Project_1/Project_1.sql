# Q.1. Create new schema as ecommerce
CREATE DATABASE ecommerce;
USE ecommerce;

/* Q.2. Import .csv file users_data into MySQL
		(right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> 
        Next -> choose options : Create a new table , select delete if exist -> next -> next) */
        
# Q.3. Run SQL command to see the structure of table
SHOW TABLES;
DESC users_data;

# Q.4. Run SQL command to select first 100 rows of the database
SELECT * FROM users_data LIMIT 100;

# Q.5. How many distinct values exist in table for field country and language
SELECT DISTINCT country, language FROM users_data;

# Q.6. Check whether male users are having maximum followers or female users.
SELECT gender, SUM(socialNbFollowers) FROM users_data GROUP BY gender;

/* Q.7. Calculate the total users those
		a. Uses Profile Picture in their Profile
		b. Uses Application for Ecommerce platform
		c. Uses Android app
		d. Uses ios app */
        
SELECT count(*) users FROM users_data WHERE hasProfilePicture = "True";
SELECT count(*) users FROM users_data WHERE hasAnyApp = "True";
SELECT count(*) users FROM users_data WHERE hasAndroidApp = "True";
SELECT count(*) users FROM users_data WHERE hasIosApp = "True";

/* Q.8. Calculate the total number of buyers for each country and sort the result in 
		descending order of total number of buyers. (Hint: consider only those users 
        having at least 1 product bought.)*/
        
SELECT 
    country, SUM(productsBought) buyers
FROM
    users_data
WHERE
    productsBought >= 1
GROUP BY country
ORDER BY SUM(productsBought) DESC;

/* Q.9. Calculate the total number of sellers for each country and sort the result in ascending 
		order of total number of sellers. (Hint: consider only those users having at least 1 
        product sold.) */
        
SELECT 
    country, SUM(productsSold) sellers
FROM
    users_data
WHERE
    productsSold >= 1
GROUP BY country
ORDER BY SUM(productsSold) ASC;

# Q.10. Display name of top 10 countries having maximum products pass rate.
SELECT 
    country, SUM(productsPassRate)
FROM
    users_data
GROUP BY country
ORDER BY SUM(productsPassRate) DESC
LIMIT 10;

# Q.11. Calculate the number of users on an ecommerce platform for different language choices.
SELECT 
    language, COUNT(*) users
FROM
    users_data
GROUP BY language;

/* Q.12. Check the choice of female users about putting the product in a wishlist or to like 
		socially on an ecommerce platform. (Hint: use UNION to answer this question.) */
        
SELECT 
    gender, SUM(productsWished)
FROM
    users_data
WHERE
    gender = 'F' 
UNION SELECT 
    gender, SUM(socialProductsLiked)
FROM
    users_data
WHERE
    gender = 'F';

/* Q.13. Check the choice of male users about being seller or buyer. (Hint: use UNION to 
		solve this question.) */
        
SELECT 
    gender, SUM(productsSold)
FROM
    users_data
WHERE
    gender = 'M' 
UNION SELECT 
    gender, SUM(productsBought)
FROM
    users_data
WHERE
    gender = 'M';

# Q.14. Which country is having maximum number of buyers?
SELECT 
    country, SUM(productsBought) buyers
FROM
    users_data
GROUP BY country
ORDER BY SUM(productsBought) DESC
LIMIT 1;

# Q.15. List the name of 10 countries having zero number of sellers.
SELECT 
    country, productsSold
FROM
    users_data
WHERE
    productsSold = 0
LIMIT 10;

# Q.16. Display record of top 110 users who have used ecommerce platform recently.
SELECT * FROM users_data ORDER BY daysSinceLastLogin LIMIT 110;

# Q.17. Calculate the number of female users those who have not logged in since last 100 days.
SELECT 
    gender, COUNT(*) users
FROM
    users_data
WHERE
    gender = 'F'
        AND daysSinceLastLogin >= 100
GROUP BY gender;

# Q.18. Display the number of female users of each country at ecommerce platform.
SELECT 
    country, gender, COUNT(*) users
FROM
    users_data
WHERE
    gender = 'F'
GROUP BY country
ORDER BY country;

# Q.19. Display the number of male users of each country at ecommerce platform.
SELECT 
    country, gender, COUNT(*) users
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country
ORDER BY country;

/* Q.20. Calculate the average number of products sold and bought on ecommerce 
		platform by male users for each country. */
        
SELECT 
    country, gender, AVG(productsSold), AVG(productsBought)
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country;