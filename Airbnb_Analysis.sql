CREATE DATABASE air;

use air;
CREATE TABLE airbnb_listings (
    `id` INT PRIMARY KEY,
    `name` VARCHAR(255),
    `host_id` BIGINT,
    `host_identity_verified` VARCHAR(50),
    `host_name` VARCHAR(255),
    `neighbourhood_group` VARCHAR(100),
    `neighbourhood` VARCHAR(100),
    `lat` DECIMAL(10, 8),
    `long` DECIMAL(11, 8),
    `country` VARCHAR(100),
    `country_code` VARCHAR(10),
    `instant_bookable` VARCHAR(50),
    `cancellation_policy` VARCHAR(50),
    `room_type` VARCHAR(50),
    `Construction_year` INT,
    `price` DECIMAL(11, 8),
    `service_fee` VARCHAR(20),
    `minimum_nights` INT,
    `number_of_reviews` INT,
    `last_review` VARCHAR(50), 
    `reviews_per_month` DECIMAL(5, 2),
    `review_rate_number` INT,
    `calculated_host_listings_count` INT,
    `availability_365` INT,
    `house_rules` TEXT,
    `license` VARCHAR(100)
);

select * from airbnb_listings
limit 20;

select count(*) from airbnb_listings;

-- how does price vary across neighbourhood
select neighbourhood_group, round(avg(price), 2) as total_price
from airbnb_listings
group by neighbourhood_group
order by total_price desc;

-- which room type is most common and prefered
select room_type, count(*) as No_of_bookings 
from airbnb_listings 
group by room_type
order by count(*) desc;

--  which listings are inactive and active
select case 
when availability_365 = 0 then "Inactive"
when availability_365 > 100 then "Midium active"
else "Active"
end as availability_status,
count(*) as No_of_bookings
from airbnb_listings
group by availability_status
order by count(*) desc;

-- which host have multiple listings 
select host_name, count(distinct host_id) as No_of_listings from airbnb_listings
group by host_name
order by count(host_id) desc
limit 10;

-- which listing are most popular
select name, reviews_per_month, review_rate_number
from airbnb_listings
ORDER BY reviews_per_month DESC, review_rate_number DESC
LIMIT 10;

-- Host Verification vs Ratings
SELECT host_identity_verified, ROUND(AVG(review_rate_number), 2) AS Avg_rating, COUNT(*) AS Total_listings
FROM airbnb_listings
GROUP BY host_identity_verified;

-- Construction Year Insights
SELECT Construction_year, ROUND(AVG(price), 2) AS Avg_price, COUNT(*) AS Total_properties
FROM airbnb_listings 
GROUP BY Construction_year
ORDER BY ROUND(AVG(price), 2) DESC;

-- Cancellation Policy vs. Ratings
SELECT cancellation_policy, ROUND(AVG(review_rate_number), 2) AS avg_rating, COUNT(*) AS Total_properties,
ROUND(AVG(reviews_per_month), 2) AS avg_reviews_per_listing
FROM airbnb_listings 
GROUP BY cancellation_policy
ORDER BY avg_rating DESC;