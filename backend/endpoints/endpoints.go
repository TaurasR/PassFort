package endpoints

import (
	"database/sql"
	"log"
	"net/http"

	"main/userManagement"

	"github.com/gin-gonic/gin"
)

type LoginCredentials struct {
	Username string `json:"username"`
	Password string `json:"password"`
	BioAuth  bool   `json:"bioauth"`
}

func GetPasswords(c *gin.Context) {
	// Logic to retrieve passwords
}

func CreatePassword(c *gin.Context) {
	// Logic to create a new password
}

func getPasswords(db *sql.DB, userID int) ([]string, error) {
	var passwords []string

	rows, err := db.Query("SELECT password FROM passwords WHERE user_id = ?", userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var password string
		if err := rows.Scan(&password); err != nil {
			return nil, err
		}
		passwords = append(passwords, password)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return passwords, nil
}

func LoginUser(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		var creds LoginCredentials

		if err := c.ShouldBindJSON(&creds); err != nil {
			log.Printf("Error occurred: %v", err)
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
			return
		}

		// Fetch user from database
		user, err := userManagement.GetUserData(db, creds.Username)
		if err != nil {
			log.Println("User was not returned")
			return
		}

		// Check if the provided password matches the hashed password in the database
		if userManagement.CheckPasswordMatchLogin(creds.Password, user.PasswordHashed) {
			if creds.BioAuth {
				// If biometric authentication is successful, generate a JWT token
				// token := GenerateJWT(user) // This needs implementation
				// c.JSON(http.StatusOK, gin.H{"token": token})

				// Fetch and decrypt the user's passwords
				passwords, err := getPasswords(db, user.Id) // This needs implementation
				if err != nil {
					log.Println("Failed to fetch passwords")
					return
				}

				decryptedPasswords := make(map[string]string)
				for _, password := range passwords {
					decryptedPassword, err := userManagement.Decrypt([]byte(password), []byte(user.DecryptionKey))
					if err != nil {
						log.Println("Failed to decrypt password")
						return
					}
					decryptedPasswords[password] = string(decryptedPassword)
				}

				// Send the decrypted passwords to the client
				c.JSON(http.StatusOK, gin.H{"passwords": decryptedPasswords})
			} else {
				// If biometric authentication fails, send a verification code
				userManagement.SendVerificationCode(user.Email, db)
				c.JSON(http.StatusUnauthorized, gin.H{
					"error": "Biometric authentication failed. Sending verification code.",
				})
			}
		} else {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
		}
	}
}

func Register(db *sql.DB) gin.HandlerFunc {
	return userManagement.RegisterUser(db)
}

func DebugUsers(db *sql.DB) gin.HandlerFunc {
	return userManagement.FetchUsers(db)
}

func VerifyAuthentication(db *sql.DB) gin.HandlerFunc {
	return userManagement.VerifyCode(db)
}
