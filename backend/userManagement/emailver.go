package userManagement

import (
	"crypto/rand"
	"database/sql"
	"encoding/base64"
	"log"
	"net/http"
	"strconv"
	"time"

	"net/smtp"

	"github.com/gin-gonic/gin"
)

func GenerateVerificationCode() (string, error) {
	randomBytes := make([]byte, 6) // Adjust size as needed
	_, err := rand.Read(randomBytes)
	if err != nil {
		return "", err
	}
	return base64.URLEncoding.EncodeToString(randomBytes), nil
}

func SendEmail(userEmail string, code string) {
	from := "my_email@gmail.com"
	password := "super_secret_password"
	to := []string{"recipient@email.com"}
	smtpHost := "smtp.gmail.com"
	smtpPort := "587"

	emailBody := "Hello! Thank you for using our app! Authentication code: " + code
	message := []byte("Subject: Your Verification Code\n" +
		"From: " + from + "\n" +
		"To: " + userEmail + "\n\n" +
		emailBody)

	// Create authentication
	auth := smtp.PlainAuth("", from, password, smtpHost)

	// Send actual message
	err := smtp.SendMail(smtpHost+":"+smtpPort, auth, from, to, message)
	if err != nil {
		log.Fatal(err)
	}
}

func SendVerificationCode(userEmail string, db *sql.DB) {
	code, err := GenerateVerificationCode()
	if err != nil {
		log.Printf("Error generating verification code: %v", err)
		return
	}

	expiration := time.Now().Add(10 * time.Minute)
	// Fetch user ID based on email
	var userID int
	err = db.QueryRow("SELECT id FROM users WHERE email = ?", userEmail).Scan(&userID)
	if err != nil {
		log.Printf("Error fetching user ID for email %s: %v", userEmail, err)
		return
	}

	// Store code and expiration in the database associated with the user's ID
	_, err = db.Exec("INSERT INTO user_codes (user_id, code, expires_at, used) VALUES (?, ?, ?, ?)",
		userID, code, expiration, false)
	if err != nil {
		log.Printf("Error saving verification code for user %d: %v", userID, err)
		return
	}

	// Send the code via email
	SendEmail(userEmail, code) // Implement email sending logic
}

// VerifyCode is a handler for verifying the code submitted by the user
func VerifyCode(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		var input struct {
			UserID string `json:"userId"`
			Code   string `json:"code"`
		}
		if err := c.BindJSON(&input); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
			return
		}

		// Convert userID from string to int
		userID, err := strconv.Atoi(input.UserID)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid userID"})
			return
		}

		var userCode string
		var expire time.Time
		err = db.QueryRow("SELECT code, expires_at FROM user_codes WHERE user_id = ?", userID).Scan(&userCode, &expire)
		if err != nil {
			log.Printf("Error fetching user code")
			return
		}

		if input.Code == userCode && time.Now().Before(expire) {
			c.JSON(http.StatusOK, gin.H{"message": "Verification successful"})

		} else {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid or expired code"})
		}
	}

}
