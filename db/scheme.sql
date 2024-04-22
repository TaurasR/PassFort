CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    password TEXT NOT NULL, -- Hashed password
    email TEXT NOT NULL UNIQUE
    decryption_key TEXT NOT NULL, -- Key to decrypt the passwords
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

CREATE TABLE user_codes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    code TEXT NOT NULL,
    expires_at DATETIME NOT NULL,
    used BOOLEAN DEFAULT FALSE, -- To mark if the code has been used

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
