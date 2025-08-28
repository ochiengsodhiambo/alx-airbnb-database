##Application of normalization principles to ensure the database is in the third normal form (3NF)
#Instructions:
- Review your schema and identify any potential redundancies or violations of normalization principles.
- Adjust your database design to achieve 3NF, if necessary.
# Explanation of the normalization steps
## Step 1: First Normal Form (1NF)
**Requirements:**
- All tables have a primary key.
- Attributes are atomic (no multi-valued or repeating groups).
- Data is stored in rows and columns.

**Review of Current Schema:**
- Each of the table has a primary key (`uuid`).
- Attributes are atomic (`first_name`, `last_name`, `email`, etc.).
- Issues:
  - `role` in `user` is an **ENUM** — better modeled as a separate lookup/reference table (`role`) for flexibility.
  - `location` in `property` is a single text field. This is **non-atomic** since it may contain city, state, and country.

**Adjustment for 1NF:**
- Creating `role` table with the fields(`role_id`, `role_name`) and referencing it from `user`.
- Creating `location` table with the fields (`location_id`, `city`, `state`, `country`) and referencing it from `property`.

## Step 2: Second Normal Form (2NF)
**Requirements:**
- Already in 1NF.
- No partial dependency (all non-key attributes depend on the whole primary key).

**Review of Current Schema:**
- No composite primary keys are used (all are `uuid`).
- No attributes depend on part of a key.

**Adjustment for 2NF:**
- Not required.

## Step 3: Third Normal Form (3NF)
**Requirements:**
- Already in 2NF.
- No transitive dependency (non-key attributes should not depend on other non-key attributes).

**Review of Current Schema:**
- `property.description` is marked **UNIQUE**, which doesn’t make sense since descriptions are not guaranteed unique. This could cause unnecessary constraints.
- `booking.end_date` is marked **UNIQUE**, which means no two bookings can end on the same date across the whole system (too restrictive). It should only depend on `booking_id`.
- `message.message_body` is marked **UNIQUE**, which is incorrect because different users may send identical messages.

**Adjustments for 3NF:**
- Removal of **UNIQUE** constraint from `property.description`, `booking.end_date`, and `message.message_body`.
- Ensuring non-key attributes depend only on the key:
  - `total_price` in `booking` should not be stored if it can be derived as `(nights * property.pricepernight)`. Keep it only if needed for auditing.
  - `location` already refactored into its own table, so no redundancy remains.
  - `role` already refactored into its own table, avoiding transitive dependency.

## Final 3NF Schema (Simplified)

### User
- `user_id` (PK)  
- `first_name`  
- `last_name`  
- `email` (unique)  
- `password_hash`  
- `phone_number`  
- `role_id` (FK → role.role_id)  
- `created_at`  

### Role
- `role_id` (PK)  
- `role_name`  

### Property
- `property_id` (PK)  
- `host_id` (FK → user.user_id)  
- `name`  
- `description`  
- `location_id` (FK → location.location_id)  
- `price_per_night`  
- `created_at`  
- `updated_at`  

### Location
- `location_id` (PK)  
- `city`  
- `state`  
- `country`  

### Booking
- `booking_id` (PK)  
- `property_id` (FK → property.property_id)  
- `user_id` (FK → user.user_id)  
- `start_date`  
- `end_date`  
- `total_price`  
- `status`  
- `created_at`  

### Payment
- `payment_id` (PK)  
- `booking_id` (FK → booking.booking_id)  
- `amount`  
- `payment_date`  
- `payment_method`  

### Review
- `review_id` (PK)  
- `property_id` (FK → property.property_id)  
- `user_id` (FK → user.user_id)  
- `rating`  
- `comment`  
- `created_at`  

### Message
- `message_id` (PK)  
- `sender_id` (FK → user.user_id)  
- `recipient_id` (FK → user.user_id)  
- `message_body`  
- `sent_at`  

---

## Relevance of 3NF Applied
- Eliminates redundancy  like the instance where locations and roles are now stored separately.
- Maintains data consistency and scalability.
- Ensuring all non-key attributes depend solely on the primary key.
