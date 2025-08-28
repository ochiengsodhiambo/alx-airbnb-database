
-- role

INSERT INTO [role] (role_id, role_name) VALUES
('r1', 'Admin'),
('r2', 'Host'),
('r3', 'Guest');

-- user

INSERT INTO [user] (user_id, first_name, last_name, email, password_hash, phone_number, role_id, created_at) VALUES
('u1', 'Alice', 'Johnson', 'alice@example.com', 'hashed_pw1', '+254700111111', 'r2', now()), -- Host
('u2', 'Bob', 'Smith', 'bob@example.com', 'hashed_pw2', '+254700222222', 'r3', now()), -- Guest
('u3', 'Charlie', 'Admin', 'charlie@example.com', 'hashed_pw3', '+254700333333', 'r1', now()), -- Admin
('u4', 'Diana', 'Wanjiru', 'diana@example.com', 'hashed_pw4', '+254700444444', 'r3', now()), -- Guest
('u5', 'Edward', 'Kamau', 'edward@example.com', 'hashed_pw5', '+254700555555', 'r2', now()); -- Host
GO

-- location

INSERT INTO [location] (location_id, city, state, country) VALUES
('l1', 'Nairobi', 'Nairobi County', 'Kenya'),
('l2', 'Mombasa', 'Coast', 'Kenya'),
('l3', 'Kisumu', 'Nyanza', 'Kenya'),
('l4', 'Watamu', 'Kilifi', 'Kenya'),
('l5', 'Diani', 'Kwale', 'Kenya');
GO

-- property

INSERT INTO [property] (property_id, host_id, name, description, location_id, price_per_night, created_at, updated_at) VALUES
('p1', 'u1', 'Ocean View Apartment', 'Beautiful apartment overlooking the Indian Ocean.', 'l2', 75.00, now(), now()),
('p2', 'u1', 'Nairobi City Loft', 'Modern loft in the heart of Nairobi.', 'l1', 50.00, now(), now()),
('p3', 'u5', 'Lake House Retreat', 'Relaxing house near Lake Victoria.', 'l3', 60.00, now(), now()),
('p4', 'u5', 'Watamu Beach Hut', 'Charming hut right by the beach.', 'l4', 40.00, now(), now()),
('p5', 'u1', 'Diani Villa', 'Luxurious villa with a private pool.', 'l5', 120.00, now(), now());
GO

-- booking

INSERT INTO [booking] (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('b1', 'p1', 'u2', '2025-09-01', '2025-09-04', 225.00, 'Confirmed', now()), -- Bob books Mombasa
('b2', 'p2', 'u4', '2025-09-10', '2025-09-12', 100.00, 'Completed', now()), -- Diana in Nairobi
('b3', 'p3', 'u2', '2025-08-15', '2025-08-18', 180.00, 'Cancelled', now()), -- Bob cancelled Kisumu
('b4', 'p4', 'u4', '2025-07-20', '2025-07-25', 200.00, 'Completed', now()), -- Diana in Watamu
('b5', 'p5', 'u2', '2025-12-15', '2025-12-20', 600.00, 'Pending', now()); -- Bob future booking Diani
GO

-- payment

INSERT INTO [payment] (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('pay1', 'b1', 225.00, now(), 'Credit Card'),
('pay2', 'b2', 100.00, now(), 'Mobile Money'),
('pay3', 'b3', 180.00, now(), 'Credit Card'), -- Refunded
('pay4', 'b4', 200.00, now(), 'Cash'),
('pay5', 'b5', 0.00, now(), 'Pending'); -- Not paid yet
GO

-- reviuew
  
INSERT INTO [review] (review_id, property_id, user_id, rating, comment, created_at) VALUES
('rev1', 'p1', 'u2', 5, 'Amazing ocean view, will come back again!', now()),
('rev2', 'p2', 'u4', 4, 'Nice city loft, but a bit noisy at night.', now()),
('rev3', 'p3', 'u2', 3, 'Had to cancel last minute, refund was smooth.', now()),
('rev4', 'p4', 'u4', 5, 'Perfect beach hut experience, loved it!', now()),
('rev5', 'p5', 'u2', 0, 'No review yet - booking pending.', now()); -- Placeholder
GO
