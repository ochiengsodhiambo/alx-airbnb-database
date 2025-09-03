
-- USER table indexes
CREATE INDEX user_role_index 
    ON [user](role_id);

-- user_id is PK (already indexed automatically)

-- BOOKING table indexes
CREATE INDEX booking_user_index 
    ON booking(user_id);

-- Dates are often filtered in ranges
CREATE INDEX booking_date_index 
    ON booking(start_date, end_date);

-- Booking status (e.g., Confirmed/Pending/Cancelled)
CREATE INDEX booking_status_index 
    ON booking(status);

-- PROPERTY table indexes
CREATE INDEX property_host_index 
    ON property(host_id);

CREATE INDEX property_location_index 
    ON property(location_id);

-- Price often used for filtering & sorting
CREATE INDEX property_price_index 
    ON property(price_per_night);

-- For showing newest listings
CREATE INDEX property_created_index 
    ON property(created_at);
