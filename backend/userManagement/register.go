package userManagement

import (
	"database/sql"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"

	"strings"
)

func hashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
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

		// Insert the new user into the database
		query := `INSERT INTO users (username, password, name, surname, email) VALUES (?, ?, ?, ?, ?)`
		_, err = db.Exec(query, newUser.Username, hashedPassword, newUser.Name, newUser.Surname, newUser.Email)
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
