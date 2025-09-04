# Query Performance Report on Partitioning the Booking Table

## Background
The `booking` table grew significantly, causing queries filtered by date to perform full sequential scans. This led to slow performance when fetching bookings for specific date ranges or users.

## Partitioning Strategy
- Implemented **range partitioning** on the `booking` table by `start_date`.
- Created yearly partitions (`booking_2023`, `booking_2024`, and `booking_future`).
- Added indexes on `user_id` within each partition for faster lookups.

## Performance Comparison

### Before Partitioning
```sql
EXPLAIN ANALYZE
SELECT * 
FROM booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
```
### After partitioning
```sql
EXPLAIN ANALYZE
SELECT * 
FROM booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
```
### After partitioning and indexing
```sql
EXPLAIN ANALYZE
SELECT *
FROM booking
WHERE user_id = 'some-user-uuid'
  AND start_date BETWEEN '2024-01-01' AND '2024-12-31';
```
## Observed Improvements
- Reduced Scan Scope – Only relevant partitions are queried, lowering I/O cost.
- Faster Execution – Queries by date range run significantly faster.
- Efficient Index Usage – Indexes within partitions further improve lookups.
- Better Scalability – Future partitions can be added per year/month, maintaining query efficiency.
## Conclusion
Partitioning the booking table by start_date, combined with targeted indexing, provided a major performance boost for date-based and user-specific queries. This approach scales well as data volume continues to grow.

