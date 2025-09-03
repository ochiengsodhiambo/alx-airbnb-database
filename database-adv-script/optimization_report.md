# Query Optimization for Bookings with User, Property, and Payment Details

This document describes how we optimized a query that retrieves bookings along with user, property, and payment details.  
The goal was to **reduce execution time** by minimizing unnecessary work and leveraging indexes.

---

## 1. Original Query

```sql
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
```
## Inefficiencies from EXPLAIN
1. Seq Scan on booking, user, property, payment
  - Means no indexes are being used for the joins.
  - The DB scans entire tables, which is inefficient at scale.
2. Hash Joins everywhere
  - Hash joins are chosen because there are no indexes on join keys (user_id, property_id, booking_id).
  - This requires building in-memory hash tables.
3. Sort Node on b.created_at
  - Sorting all rows after join → costly.
  - No index on created_at column, so sort must happen manually.

## Refactored Query
## Step 1: Ensure indexes exist
```sql
CREATE INDEX IF NOT EXISTS booking_user_index 
    ON booking(user_id);

CREATE INDEX IF NOT EXISTS booking_property_index 
    ON booking(property_id);

CREATE INDEX IF NOT EXISTS payment_booking_index 
    ON payment(booking_id);

CREATE INDEX IF NOT EXISTS booking_created_index 
    ON booking(created_at DESC);
```
## Step 2: Optimized query
```sql
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
    p.price_per_night,  -- omit p.description unless needed
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM booking b
JOIN [user] u 
    ON b.user_id = u.user_id
JOIN property p 
    ON b.property_id = p.property_id
LEFT JOIN payment pay 
    ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;
```
## Improvements and Why It’s Faster
- Indexes on join keys (user_id, property_id, booking_id) → prevent full table scans.
- Index on created_at DESC → avoids expensive sorting.
- Remove unnecessary text fields (like description) unless required.
- INNER JOIN vs LEFT JOIN: Kept LEFT JOIN only for payment, since some bookings may not have payments.
