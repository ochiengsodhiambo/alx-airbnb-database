## Entities and Attributes

--role
CREATE TABLE [role] (
  [role_id] uuid PRIMARY KEY,
  [role_name] nvarchar(100) UNIQUE NOT NULL
);
GO

CREATE TABLE [user] (
  [user_id] uuid PRIMARY KEY,
  [first_name] nvarchar(255) NOT NULL,
  [last_name] nvarchar(255) NOT NULL,
  [email] nvarchar(255) UNIQUE NOT NULL,
  [password_hash] nvarchar(255) NOT NULL,
  [phone_number] nvarchar(255),
  [role_id] uuid NOT NULL,
  [created_at] timestamp DEFAULT now(),
  FOREIGN KEY ([role_id]) REFERENCES [role]([role_id])
);
GO

-- location

CREATE TABLE [location] (
  [location_id] uuid PRIMARY KEY,
  [city] nvarchar(255) NOT NULL,
  [state] nvarchar(255),
  [country] nvarchar(255) NOT NULL
);
GO

-- properties

CREATE TABLE [property] (
  [property_id] uuid PRIMARY KEY,
  [host_id] uuid NOT NULL,
  [name] nvarchar(255) NOT NULL,
  [description] text NOT NULL,
  [location_id] uuid NOT NULL,
  [price_per_night] decimal(10,2) NOT NULL,
  [created_at] timestamp DEFAULT now(),
  [updated_at] timestamp DEFAULT now(),
  FOREIGN KEY ([host_id]) REFERENCES [user]([user_id]),
  FOREIGN KEY ([location_id]) REFERENCES [location]([location_id])
);
GO

-- booking

CREATE TABLE [booking] (
  [booking_id] uuid PRIMARY KEY,
  [property_id] uuid NOT NULL,
  [user_id] uuid NOT NULL,
  [start_date] date NOT NULL,
  [end_date] date NOT NULL,
  [total_price] decimal(10,2) NOT NULL,
  [status] nvarchar(50) NOT NULL,
  [created_at] timestamp DEFAULT now(),
  FOREIGN KEY ([property_id]) REFERENCES [property]([property_id]),
  FOREIGN KEY ([user_id]) REFERENCES [user]([user_id])
);
GO

-- payment

CREATE TABLE [payment] (
  [payment_id] uuid PRIMARY KEY,
  [booking_id] uuid NOT NULL,
  [amount] decimal(10,2) NOT NULL,
  [payment_date] timestamp DEFAULT now(),
  [payment_method] nvarchar(50) NOT NULL,
  FOREIGN KEY ([booking_id]) REFERENCES [booking]([booking_id])
);
GO

-- review

CREATE TABLE [review] (
  [review_id] uuid PRIMARY KEY,
  [property_id] uuid NOT NULL,
  [user_id] uuid NOT NULL,
  [rating] int NOT NULL CHECK ([rating] BETWEEN 1 AND 5),
  [comment] text NOT NULL,
  [created_at] timestamp DEFAULT now(),
  FOREIGN KEY ([property_id]) REFERENCES [property]([property_id]),
  FOREIGN KEY ([user_id]) REFERENCES [user]([user_id])
);
GO

-- message
CREATE TABLE [message] (
  [message_id] uuid PRIMARY KEY,
  [sender_id] uuid NOT NULL,
  [recipient_id] uuid NOT NULL,
  [message_body] text NOT NULL,
  [sent_at] timestamp DEFAULT now(),
  FOREIGN KEY ([sender_id]) REFERENCES [user]([user_id]),
  FOREIGN KEY ([recipient_id]) REFERENCES [user]([user_id])
);
GO

-- indexes

CREATE INDEX [user_email_index] ON [user] ("email");
GO

CREATE INDEX [booking_property_index] ON [booking] ("property_id");
GO

CREATE INDEX [payment_booking_index] ON [payment] ("booking_id");
GO
