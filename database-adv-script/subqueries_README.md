# Subqueries

## 1. Properties with Average Rating > 4.0
- **Type:** Simple subquery in `WHERE ... IN`
- **Logic:** Calculates the average rating for each property in the `review` table and returns only those property IDs where `AVG(rating) > 4.0`

---

## 2. Users with More Than 3 Bookings
- **Type:** Correlated subquery (depends on outer query row)
- **Logic:** For each user in the `user` table, counts the number of bookings in the `booking` table and returns the user if the count is greater than 3


