create database customers_behavior;
show databases;

use customers_behavior;

select * from customerstable limit 5; 

-- Find how much total money is spent by each gender

select gender, sum(purchase_amount) as revenue
from customerstable 
group by gender;	

-- List customers who used discounts but still spent more than the average amount

select customer_id,purchase_amount
from customerstable
where discount_applied = 'yes' and purchase_amount >= (select avg(purchase_amount ) from customerstable);

-- Show the top 10 products based on average customer ratings

select item_purchased,round( avg(review_rating),2) as "product ratings"
from customerstable
group by item_purchased
order by avg(review_rating) desc
limit 10;

-- Check how average spending changes for different shipping types 

select shipping_type,
round(avg(purchase_amount),2)
from customerstable
where shipping_type in ('standard','Express','free shipping')
group by shipping_type;

-- Compare subscribed and non-subscribed customers based on count and spending

select subscription_status,
count(customer_id) as total_customers,
round(avg(purchase_amount),2) as average_spend,
round(sum(purchase_amount),2) as total_revenue
from customerstable
group by subscription_status
order by total_revenue desc;

-- Find the products that are most often bought with discounts

select item_purchased,
round(100 * sum(case when discount_applied= 'yes' then 1 else 0 end)/count(*),2) as discount_rate
from customerstable
group by  item_purchased
order by discount_rate desc
limit 7;

-- Divide customers into New, Returning, and Loyal groups and count them

 with customer_type as (
 select customer_id,previous_purchases,
 case 
      when previous_purchases=1 then 'New'
      when previous_purchases between 2 and 10 then 'Returning'
	  else 'Loyal'
      end as customer_segment 
 from customerstable
 )
 
 select customer_segment,count(*) as "Numbers of customers"
 from customer_type
 group by customer_segment; 
 
 -- Find how many repeat buyers exist in each subscription category
 
 select subscription_status,
 count(customer_id) as repeat_buyers
 from customerstable
 where previous_purchases > 5
 group by subscription_status;
 
-- Analyze which age group generates the highest total revenue

select age_group,
sum(purchase_amount) as total_revenue
from customerstable
group by age_group
order by total_revenue desc;


 
 
  
 
 
 
 
 
 
 











 

 






 










