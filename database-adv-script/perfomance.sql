SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.description AS property_description,
    p.price_per_night,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM booking b
INNER JOIN [user] u 
    ON b.user_id = u.user_id
INNER JOIN property p 
    ON b.property_id = p.property_id
LEFT JOIN payment pay 
    ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;
