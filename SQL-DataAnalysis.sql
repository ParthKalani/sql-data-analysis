use paypal;

#Final Account Balance
select account_id, SUM(if(transaction_type = 'deposit',amount,amount*-1))
from transactions
where is_fraud = 0
group by account_id;

select * 
from users;

#Average Transaction Amount per User
select user_id, user_name, avg(amount), dense_rank() Over(order by avg(amount) desc) as Rank1
from users u
join transactions t
ON (u.user_id = t.sender_id or u.user_id = t.receiver_id) and t.sender_id is not null and t.receiver_id is not null and is_fraud = 0 and is_fraudulent = 0
group by user_id, user_name;

#Unique Money Transfer Relationships
select count(t.transaction_id) as 'Two-way transaction Count'
from transactions t
where t.sender_id is not null and t.receiver_id is not null and is_fraud = 0;

#Determining High-Value Customers
select user_id, user_name
from users u
join transactions t
ON (u.user_id = t.sender_id or u.user_id = t.receiver_id) and t.sender_id is not null and t.receiver_id is not null and is_fraud = 0 and is_fraudulent = 0
Where (if( transaction_type = 'deposit', amount, 0) > 5000 or if(transaction_type !='deposit', amount, 0) >1000) AND (month(transaction_date) = month(curdate()) - 1)
group by user_id, user_name;

#Analyzing User Transaction Data
select user_id, user_name, avg(amount), sum(amount)
from users u
join transactions t
ON (u.user_id = t.sender_id or u.user_id = t.receiver_id) and t.sender_id is not null and t.receiver_id is not null and is_fraud = 0 and is_fraudulent = 0
group by user_id, user_name
Having count(t.transaction_id) >1;