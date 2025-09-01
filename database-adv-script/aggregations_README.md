# SQL Aggregation & Window Functions

## 1. Total Bookings per User
- **Function:** `COUNT` with `GROUP BY`
- **Logic:** Counts the total number of bookings for each user.
- **Key Points:**
  - `GROUP BY` aggregates bookings per user.
  - `LEFT JOIN` ensures users with zero bookings are included.
- **Use Case:** Find the total bookings made by each user and rank activity.

---

## 2. Ranking Properties by Bookings
- **Function:** `RANK()` or `ROW_NUMBER()` window function
- **Logic:** Ranks properties based on the total number of bookings.
- **Note:**
  - `COUNT` aggregates bookings per property.
  - `RANK()` preserves ties, `ROW_NUMBER()` assigns unique sequential numbers.
  - `OVER (ORDER BY COUNT(...) DESC)` determines the ranking order.
- **Use Case:** Identify the most popular properties based on bookings.

