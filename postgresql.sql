
-- practice joins
-- 1
SELECT * FROM invoice i
join invoice_line li 
ON i.invoice_id = li.invoice_id 
WHERE unit_price > 1 
-- 2
SELECT first_name,last_name,total,invoice_date FROM customer s 
join invoice i 
ON i.customer_id = s.customer_id
-- 3
SELECT e.first_name,e.last_name,s.first_name,s.last_name FROM customer s 
join employee e 
ON e.employee_id = s.support_rep_id
-- 4
SELECT title,name FROM album a
join artist ar 
ON ar.artist_id = a.artist_id
-- 5
SELECT name,track_id FROM playlist_track pt
join playlist p 
ON p.playlist_id = pt.playlist_id
-- 6
SELECT distinct  t.name,p.name FROM playlist p
join playlist_track pt 
ON p.playlist_id = pt.playlist_id
join track t
ON t.track_id = pt.Playlist_id
--7
SELECT  t.name,a.title FROM track t
join album a 
ON t.album_id =  a.album_id
join genre g
ON t.genre_id = g.genre_id
WHERE g.name = 'Alternative & Punk'

-- practice nested queries

-- 1
SELECT *
FROM invoice
WHERE invoice_id IN ( SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99 )
-- 2
SELECT *
FROM playlist_track
WHERE playlist_id IN 
( SELECT playlist_id FROM playlist WHERE name = 'Music' )
-- 3
SELECT name
FROM track
WHERE track_id IN ( SELECT track_id FROM playlist_track WHERE playlist_id = 5 );
-- 4
SELECT *
FROM track
WHERE genre_id IN ( SELECT genre_id FROM genre WHERE name = 'Comedy' )
-- 5
SELECT *
FROM track
WHERE album_id IN ( SELECT album_id FROM album WHERE title = 'Fireball' )
-- 6
SELECT *
FROM track
WHERE album_id IN ( 
  SELECT album_id FROM album WHERE artist_id IN ( 
    SELECT artist_id FROM artist WHERE name = 'Queen'
  )
); 

-- updating row
-- 1
UPDATE customer 
SET fax = null
WHERE fax is not 
null
-- 2
UPDATE customer 
SET company = 'self'
WHERE company is 
null
-- 3
UPDATE customer 
SET last_name = 'Thompson'
WHERE first_name =
'Julia' AND last_name='Barnett'
-- 4
UPDATE customer 
SET support_rep_id = 4
WHERE email =
'luisrojas@yahoo.cl'
-- 5
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
AND composer IS null

-- group by 

-- 1
SELECT DISTINCT composer
FROM track
-- 2
SELECT DISTINCT billing_postal_code
FROM invoice
-- 3
SELECT DISTINCT company
FROM customer

-- delete

-- 1
DELETE 
FROM practice_delete 
WHERE type = 'bronze';
-- 2
DELETE
FROM practice_delete
WHERE type = 'silver'
-- 3
DELETE
FROM practice_delete
WHERE value = 150

-- 

CREATE TABLE shopper (name text, email text, shopper_id SERIAL PRIMARY KEY)
INSERT INTO shopper ( name, email ) VALUES ('john', 'jogger@gmail'),
 ('allex', 'ger@gmail'),
 ('jeff', 'joer@gmail')

create table produce ( name text, price numeric, produce_id SERIAL PRIMARY KEY ) 

INSERT INTO produce ( name, price ) VALUES ('apple', 4.6),
 ('orange', 46.56),
 ('banana', 460000.4)

CREATE TABLE orders (shopper_id NUMERIC, produce_id NUMERIC, order_id SERIAL PRIMARY KEY )

INSERT INTO orders (shopper_id,produce_id) VALUES (1,3),
 (1,2),
 (2,2),
 (2,1),
 (3,1),
 (3,3)

-- 
select name from orders o
join produce p 
on o.produce_id = p.produce_id 
where order_id = 1
-- 
select * 
from orders
-- 
select sum(price) from orders o
join produce p 
on o.produce_id = p.produce_id 
where order_id = 1 
-- 
select * from orders o
join shopper p 
on o.produce_id = p.produce_id 
where shopper_id= 3
-- 
select * from orders o
join shopper p 
on o.shopper_id = p.Shopper_id 
where p.shopper_id= 3
-- 
select count(*) from orders o
join shopper p 
on o.shopper_id = p.Shopper_id 
where p.shopper_id= 3