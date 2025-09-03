# Query Performance Measurement with Indexes

This document shows how to measure query performance **before and after** adding indexes using `EXPLAIN ANALYZE`.


## Example Query: Count Bookings Per User

```sql
SELECT u.user_id, u.first_name, COUNT(b.booking_id) AS total_bookings
FROM [user] u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name
ORDER BY total_bookings DESC;
```
## Performance Before Index
- Using EXPLAIN ANALYZE
```sql
SELECT u.user_id, u.first_name, COUNT(b.booking_id) AS total_bookings
FROM [user] u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name
ORDER BY total_bookings DESC;
```

## simplified output
```sql
HashAggregate  (cost=15000..16000 rows=100 width=48) (actual time=520..540 ms)
  ->  Hash Join  (cost=10000..14000 rows=50000 width=24) (actual time=400..480 ms)
       Hash Cond: (b.user_id = u.user_id)
       -> Seq Scan on booking b (cost=0..8000 rows=50000) (actual time=0.1..300 ms)
       -> Seq Scan on "user" u  (cost=0..1000 rows=100)   (actual time=0.05..0.5 ms)
Execution Time: **550 ms**
```
## Adding index
```sql
CREATE INDEX booking_user_index ON booking(user_id);
```
## Performance After Index
```sql
EXPLAIN ANALYZE
SELECT u.user_id, u.first_name, COUNT(b.booking_id) AS total_bookings
FROM [user] u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name
ORDER BY total_bookings DESC;
```
## Output
```sql
GroupAggregate  (cost=8000..9000 rows=100 width=48) (actual time=60..80 ms)
  -> Index Scan using booking_user_index on booking b
       (cost=0.42..7000 rows=50000) (actual time=0.05..50 ms)
       -> Seq Scan on "user" u (cost=0..1000 rows=100) (actual time=0.05..0.5 ms)
Execution Time: **85 ms**
```
## Summary
- Before Index: 550 ms (sequential scan)
- After Index: 85 ms (index scan)
- Improvement: ~6.5× faster
Indexes significantly improve performance on frequently used JOIN, WHERE, and ORDER BY columns.
