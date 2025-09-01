# SQL Joins Summary

## INNER JOIN
- Returns only the rows that have matching values in **both tables**.
- Example: Retrieve all bookings with the users who made them.
- Excludes users with no bookings and bookings without users.

---

## LEFT JOIN
- Returns **all rows from the left table** and matching rows from the right table.
- If there is no match, right table columns return **NULL**.
- Example: Retrieve all properties and their reviews, including properties with no reviews.

---

## FULL OUTER JOIN
- Returns **all rows from both tables**, whether there is a match or not.
- Non-matching rows from either side will have **NULL** values for the missing columns.
- Example: Retrieve all users and all bookings, including users with no bookings and bookings not linked to a user.
