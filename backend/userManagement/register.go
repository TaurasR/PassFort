package userManagement

import (
	"crypto/rand"
	"database/sql"
	"log"
	"net/http"

	"crypto/sha256"

	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
	"golang.org/x/crypto/pbkdf2"

	"strings"
)

func hashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

func generateUserKey(username string) ([]byte, error) {
	// Generate a random salt for the user.
	salt := make([]byte, 16)
	_, err := rand.Read(salt)
	if err != nil {
		return nil, err
	}

	// Use PBKDF2 to derive a key from the master key and the salt.
	key := pbkdf2.Key(masterKey, salt, 4096, 32, sha256.New)

	return key, nil
}

func RegisterUser(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		var newUser User

		// Bind the JSON to the newUser struct
		if err := c.ShouldBindJSON(&newUser); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
			return
		}

		// Hash the password
		hashedPassword, err := hashPassword(newUser.PasswordHashed)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to hash password"})
			return
		}

		//Generate user-key
		key, err := generateUserKey(newUser.Username)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate user key"})
			return
		}

		// Encrypting user data before inserting into the database
		encryptedName, err := Encrypt([]byte(newUser.Name), key)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to encrypt user data"})
			return
		}
		encryptedSurname, err := Encrypt([]byte(newUser.Surname), key)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to encrypt user data"})
			return
		}
		encryptedEmail, err := Encrypt([]byte(newUser.Email), key)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to encrypt user data"})
			return
		}
		encryptedUsername, err := Encrypt([]byte(newUser.Username), key)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to encrypt user data"})
			return
		}
		encryptedPassword, err := Encrypt([]byte(hashedPassword), key)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to encrypt user data"})
			return
		}

		encryptedKey, err := Encrypt(key, masterKey)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to encrypt user data"})
			return
		}

		// Insert the new user into the database
		query := `INSERT INTO users (username, password, name, surname, email, decryption_key) VALUES (?, ?, ?, ?, ?, ?)`
		_, err = db.Exec(query, encryptedUsername, encryptedPassword, encryptedName, encryptedSurname, encryptedEmail, encryptedKey)
		if err != nil {
			// Handle potential errors, such as duplicate usernames
			if strings.Contains(err.Error(), "UNIQUE constraint failed") {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to register user. This username is already taken"})
			} else {
				log.Printf("Error occurred: %v", err)
				c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to register user"})
			}

			return
		}

		// Successfully registered user
		c.JSON(http.StatusOK, gin.H{"message": "User registered successfully"})
	}
}
