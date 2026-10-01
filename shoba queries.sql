select *
from shoba.customer_behaviour_data;

# PRODUCT ANALYSIS

-- what products are the customers currently buying the most of
select 
	category,
	count(customer_id) as total_orders,
	round((count(customer_id)*100/ sum(count(customer_id))over()),2) as order_distribution_pct,
	sum(purchase_amount) as Revenue,
	round(((sum(purchase_amount)/sum(sum(purchase_amount)) over()) *100 ) , 2)as revenue_pct 
from customer_behaviour_data
group by category
order by total_orders desc;

-- most of the revenue are coming from Clothing and accessories category
#Look at why the customers are buying those

-- who is buying clothing and accessories the most?
select
	gender,
    age_group,
    count(customer_id) as orders,
    sum(purchase_amount) as revenue,
    round(sum(purchase_amount)*100/sum(sum(purchase_amount))over(), 2) as revenue_percent
from customer_behaviour_data
where category in ('Clothing', 'Accessories')
group by gender, age_group
order by revenue_percent desc;

-- Are clothing products heavily discounted?
select 
	category,
    count(case when discount_applied = 'Yes' then 1 end) discounted_orders,
    sum(purchase_amount) as revenue
from customer_behaviour_data
group by category
order by discounted_orders desc;

-- What do repeat customers by the most of?
select 
	category,
    count(customer_id) as repeat_customers
from customer_behaviour_data
where previous_purchases > 5
group by category
order by repeat_customers desc;

-- so the clothing and accessories categories are highly discounted and have the most repeat customers hence, they have the most revenue and 


-- are the top rated products the most sold?
select 
	item_purchased,
    round(avg(review_rating),2) as avg_rating,
    count(customer_id) as sold_units,
    sum(purchase_amount) as revenue
from customer_behaviour_data
group by item_purchased
order by sold_units desc;

-- what are the top 3 most purchased products with each category
with item_counts as(
select 
	category, 
	item_purchased, 
	count(customer_id) as total_orders,
	row_number()over(partition by category order by count(customer_id) desc) as item_rank
	from customer_behaviour_data
	group by category, item_purchased
)
	select item_rank, category, item_purchased, total_orders
	from item_counts
	where item_rank <=3;


# CUSTOMER DEMOGRAPHIC ANALYSIS
-- how does the gender of the customers affect their purchase
select  
	gender,
	count(customer_id) as total_orders,
	round((count(customer_id) *100/sum(count(customer_id))over()),2)  as percentage_of_customers,
	round(avg(purchase_amount),2) as average_order_value,
	sum(purchase_amount) as Total_Revenue,
	round((sum(purchase_amount)*100)/sum(sum(purchase_amount))over(), 2) as revenue_percentage
from shoba.customer_behaviour_data
group by gender; 

-- which customers spent more than the average amount 
SELECT 
    gender,
    discount_applied,
    count(case when purchase_amount > avg_purchase then 1 end) as customers_above_avg,
    (count(case when purchase_amount > avg_purchase then 1 end) * 100.0 / 
     sum(count(*)) over(partition by gender)) AS percentage_of_total_gender
from customer_behaviour_data
cross join (
    select avg(purchase_amount) as avg_purchase 
    from customer_behaviour_data
) as overall_avg
group by gender, discount_applied;


-- Are repeat buyers (who have more than 5 different past purchases) more likely to subscribe? 
select 
	subscription_status, 
    count(customer_id) as repeat_buyers,
    round(100.0 * count(customer_id) / sum(count(customer_id)) over (), 2) as percentage_of_total
from customer_behaviour_data
where previous_purchases > 5
group by subscription_status;

-- what is the revenue by age group
select 
	age_group,
	count(customer_id) as num_of_orders,
	sum(purchase_amount) total_revenue
from customer_behaviour_data
group by age_group
order by total_revenue desc;

-- segment customers into new returning and loyal based on their total number of previous purchases and show the count of each segment
select 
		customer_segment,
        count(*) as total_orders
from (select 
			customer_id, 
			previous_purchases,
		case 
			when previous_purchases = 1 then 'New'
			when previous_purchases between 2 and 10 then 'Returning'
			else 'Loyal'
		end as customer_segment
from customer_behaviour_data) as customer_groups
group by customer_segment;

-- which customers are subscribed?
select distinct gender
from customer_behaviour_data
where subscription_status ='Yes';

-- Do subscribed customers spend more?
select 
	subscription_status,
	count(customer_id) as total_orders,
	sum(purchase_amount) as total_spent,
	round(avg(purchase_amount), 2) as avg_spend
from customer_behaviour_data
group by subscription_status
order by total_spent desc;


# DISCOUNT ANALYSIS

-- who is using the discounts?
SELECT 
    gender,
    COUNT(customer_id) AS total_orders,
    COUNT(CASE WHEN discount_applied = 'Yes' THEN 1 END) AS discounted_orders,
    ROUND(100.0 * COUNT(CASE WHEN discount_applied = 'Yes' THEN 1 END) / COUNT(customer_id), 2) AS discount_adoption_pct
FROM customer_behaviour_data
GROUP BY gender;

# Females are not given discounts!

-- What age groups makes use of discounts the most?
select 
	age_group,
    count(customer_id)as total_orders,
    count(case when discount_applied = 'Yes' then 1 end) discounted_sales,
    round(100.0 *(count(case when discount_applied = 'Yes' then 1 end)/count(customer_id)) ,2)discount_adoption_pct
from customer_behaviour_data
group by age_group
order by discount_adoption_pct desc;

-- How much effect does discount have on the customer decisions
select 
	discount_applied,
    avg(purchase_amount) as a_o_v,
	sum(purchase_amount) as revenue,
	round((sum(purchase_amount)*100/ sum(sum(purchase_amount))over()),2) revenue_percentage,
	count(customer_id) as number_of_customers
from customer_behaviour_data
where gender = 'Male' -- since only male customers use discounts
group by discount_applied
order by discount_applied desc;

-- Does discount have more effect on certain product category?
select 
	category,
    avg(purchase_amount) as avg_order_value,
    count(customer_id) as total_orders,
    count(case when discount_applied = 'Yes' then 1 end) as discounted_orders,
    round(100.0*count(case when discount_applied = 'Yes' then 1 end)/count(customer_id),2) as discount_adoption_pct
from customer_behaviour_data
group by category
order by discount_adoption_pct desc;


# over 60% of the revenue gotten from males comes from discounted sales 

-- percentage of products sold on discount
SELECT 
    item_purchased,
    ROUND(AVG(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) * 100, 2) AS discount_rate
FROM customer_behaviour_data
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 10;

-- Do loyal and regular customers use more discounts?
select 
    case 
        when previous_purchases > 10 then 'Loyal Customer (>10 purchases)'
        else 'Regular Customer (<=10 purchases)'
    end as customer_segment,
    count(*) as total_orders,
    count(case when discount_applied = 'Yes' then 1 end) as discounted_orders,
    ROUND(100.0 * COUNT(case when discount_applied = 'Yes' then 1 end) / COUNT(*), 2) as discount_adoption_rate_pct
from customer_behaviour_data
group by
    case 
        when previous_purchases > 10 then 'Loyal Customer (>10 purchases)'
        else 'Regular Customer (<=10 purchases)'
    end;
    
    
-- How does AOV differ for discounted and non-disconuted orders in each category?
SELECT 
    category,
    -- AOV when a discount WAS applied
    ROUND(AVG(CASE WHEN discount_applied = 'Yes' THEN purchase_amount END), 2) AS aov_with_discount,
    
    -- AOV when a discount WAS NOT applied
    ROUND(AVG(CASE WHEN discount_applied = 'No' THEN purchase_amount END), 2) AS aov_no_discount,
    
    -- Overall AOV for the category
    ROUND(AVG(purchase_amount), 2) AS total_avg_order_value,
    
    -- order volume
    count(customer_id) as total_orders,
    -- Difference (Positive means they spend more when given a discount)
    ROUND(
        AVG(CASE WHEN discount_applied = 'Yes' THEN purchase_amount END) - 
        AVG(CASE WHEN discount_applied = 'No' THEN purchase_amount END), 2
    ) AS discount_impact
FROM customer_behaviour_data
GROUP BY category
ORDER BY discount_impact DESC;

-- what is the average cost of discounted and non discounted items that customers buy
select 
	discount_applied,
    count(customer_id) as total_orders,
	round(avg(purchase_amount),2) as avg_cost,
    sum(purchase_amount) as total_revenue
from customer_behaviour_data
where gender = 'Male' -- since only the males were found to use discounts 
group by discount_applied;

-- Do subscribed customers use more discounts?
SELECT 
    gender,
    subscription_status,
    COUNT(customer_id) AS total_orders,
    COUNT(CASE WHEN discount_applied = 'Yes' THEN 1 END) AS discounted_orders,
    ROUND(100.0 * COUNT(CASE WHEN discount_applied = 'Yes' THEN 1 END) / COUNT(customer_id), 2) AS discount_adoption_pct
FROM customer_behaviour_data
GROUP BY gender, subscription_status
ORDER BY gender DESC, subscription_status DESC;



# SHIPPING ANALYSIS
 
 -- How do customers' purchase patterns differ by shipping preference?"
select	 
    shipping_type,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
    sum(purchase_amount) as total_revenue,
    count(customer_id) as total_orders
from customer_behaviour_data
group by shipping_type
order by total_orders desc;

-- who uses the different shipping methods?
select 
	age_group,
    count(customer_id) as orders
from customer_behaviour_data
where shipping_type = 'Free Shipping'
group by age_group
order by orders desc;

SELECT 
    shipping_type, 
    gender,
    subscription_status,
    COUNT(customer_id) AS total_orders,
    -- Shows the percentage share of orders for that specific shipping method
    ROUND(100.0 * COUNT(customer_id) / SUM(COUNT(customer_id)) OVER(PARTITION BY shipping_type), 2) AS share_of_method_pct
FROM customer_behaviour_data
GROUP BY shipping_type, gender, subscription_status
ORDER BY shipping_type, total_orders DESC;

SELECT 
    gender,
    subscription_status,
    shipping_type,
    COUNT(customer_id) AS total_orders,
    -- Shows how each demographic splits their shipping choices
    ROUND(100.0 * COUNT(customer_id) / SUM(COUNT(customer_id)) OVER(PARTITION BY gender, subscription_status), 2) AS preference_pct
FROM customer_behaviour_data
GROUP BY gender, subscription_status, shipping_type
ORDER BY gender, subscription_status, preference_pct DESC;


SELECT 
    gender,
    subscription_status,
    age_group,
    COUNT(customer_id) AS total_customers,
    -- Calculates the average loyalty level for this exact segment
    ROUND(AVG(previous_purchases), 1) AS avg_previous_purchases,
    -- Finds the maximum purchases in this group to see your absolute "Super Users"
    MAX(previous_purchases) AS max_previous_purchases
FROM customer_behaviour_data
GROUP BY gender, subscription_status, age_group
ORDER BY avg_previous_purchases DESC; -- Immediately puts your most loyal segments at the top

-- Seasonal Analysis
SELECT 
    season,
    category,
    COUNT(customer_id) AS total_orders,
    ROUND(AVG(purchase_amount), 2) AS avg_order_value,
    COUNT(CASE WHEN discount_applied = 'Yes' THEN 1 END) AS discounted_orders,
    -- Tracks if people become more deal-hungry in certain seasons
    ROUND(100.0 * COUNT(CASE WHEN discount_applied = 'Yes' THEN 1 END) / COUNT(customer_id), 2) AS discount_adoption_pct
FROM customer_behaviour_data
GROUP BY season, category
ORDER BY season, total_orders DESC;

SELECT 
    season,
    gender,
    COUNT(customer_id) AS total_orders,
    ROUND(AVG(purchase_amount), 2) AS avg_order_value,
    ROUND(SUM(purchase_amount), 2) AS total_revenue,
    COUNT(CASE WHEN discount_applied = 'Yes' THEN 1 END) AS discounted_orders,
    -- Tracks the discount adoption rate just for this gender in this season
    ROUND(100.0 * COUNT(CASE WHEN discount_applied = 'Yes' THEN 1 END) / COUNT(customer_id), 2) AS discount_adoption_pct
FROM customer_behaviour_data
GROUP BY season, gender
ORDER BY season, gender DESC; -- Keeps seasons grouped together with Men and Women side-by-side
