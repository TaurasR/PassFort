CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    password TEXT NOT NULL, -- Hashed password
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE saved_passwords (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    password TEXT NOT NULL, -- Encrypted password
    username TEXT NOT NULL, -- Username for the saved password
    website TEXT NOT NULL,
    name TEXT NOT NULL, -- Name/description for this password entry
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
