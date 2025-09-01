--INNER JOIN to retrieve all bookings and the respective users who made those bookings
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM booking b
INNER JOIN [user] u ON b.user_id = u.user_id;

--LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.price_per_night,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at
FROM property p
LEFT JOIN review r ON p.property_id = r.property_id
    ORDER BY r.rating ASC;

--FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM [user] u
FULL OUTER JOIN booking b ON u.user_id = b.user_id;
