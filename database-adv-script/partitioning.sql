-- Step 1: Creating the parent booking table partitioned by start_date
CREATE TABLE booking (
    booking_id     UUID PRIMARY KEY,
    user_id        UUID NOT NULL,
    property_id    UUID NOT NULL,
    start_date     DATE NOT NULL,
    end_date       DATE NOT NULL,
    total_price    DECIMAL(10,2),
    status         VARCHAR(50),
    created_at     TIMESTAMP DEFAULT now()
)
PARTITION BY RANGE (start_date);


--splitting by year
-- 2023 Bookings
CREATE TABLE booking_2023 PARTITION OF booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- 2024 Bookings
CREATE TABLE booking_2024 PARTITION OF booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Default partition for future years
CREATE TABLE booking_future PARTITION OF booking
    DEFAULT;
