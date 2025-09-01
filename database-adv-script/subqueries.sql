--all properties where the average rating > 4.0
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.price_per_night
FROM property p
WHERE p.property_id IN 
  (SELECT r.property_id
    FROM review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0)

--users who have made > 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM [user] u
WHERE 
  (SELECT COUNT(*)
    FROM booking b
    WHERE b.user_id = u.user_id) > 3;
