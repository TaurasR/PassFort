package userManagement

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"time"

	"net/smtp"

	"math/rand/v2"

	"github.com/gin-gonic/gin"
	"github.com/jordan-wright/email"
)

const (
	smtpAuthAddress = "smtp.gmail.com"
	smtpServerAddress = "smtp.gmail.com:587"
)

type EmailSender interface {
	SendEmail(
		subject string,
		content string,
		to []string,
	) error
}

type GmailSender struct {
	name              string
	fromEmailAddress  string
	fromEmailPassword string
}

func NewGmailSender(name string, fromEmailAddress string, fromEmailPassword string) EmailSender {
	return &GmailSender {
		name:              name,
		fromEmailAddress:  fromEmailAddress,
		fromEmailPassword: fromEmailPassword,
	}
}

func (sender *GmailSender) SendEmail(subject string, content string, to []string) error {
	e := email.NewEmail()
	e.From = fmt.Sprintf("%s <%s>", sender.name, sender.fromEmailAddress)
	e.Subject = subject
	e.HTML = []byte(content)
	e.To = to

	smtpAuth := smtp.PlainAuth("", sender.fromEmailAddress, sender.fromEmailPassword, smtpAuthAddress)
	return e.Send(smtpServerAddress, smtpAuth)
}

func GenerateVerificationCode() (string) {
	var code = ""
	n := 10
	for i := 0; i < 6; i++ {
		value := rand.IntN(n)

		code = code + strconv.Itoa(value)
	}

	return code
}

// Send verification code
func SendVerificationCode(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context){
		code := GenerateVerificationCode()

		var input struct {
			Email string `json:"email"`
		}
		if err := c.ShouldBindJSON(&input); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
			return
		}
	
		expiration := time.Now().Add(10 * time.Minute)
		var userID int
		var err = db.QueryRow("SELECT id FROM users WHERE email = ?", input.Email).Scan(&userID)
		if err != nil {
			log.Printf("Error fetching user ID for email %s: %v", input.Email, err)
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
		sender := NewGmailSender("PassFort", "passfortprogram@gmail.com", "oqlvkbtisvfimnpu")

		subject := "[PassFort] Elektroninio pašto patvirtinimas"
		content := fmt.Sprintf(`
		<h2>Elektroninio pašto patvirtinimas</h2>
		<p>Įveskite kodą į telefoną.</p>
		<p>Jūsų kodas yra: <strong>%s</strong></p>
		`, code)

		to := []string{input.Email}

		sender.SendEmail(subject, content, to)
		c.JSON(http.StatusOK, gin.H{"message": "Email sent successfully"})
	}
}

// VerifyCode is a handler for verifying the code submitted by the user
func VerifyCode(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		var input struct {
			Email  string `json:"email"`
			Code   string `json:"code"`
		}
		if err := c.BindJSON(&input); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
			return
		}

		var userID int
		var err = db.QueryRow("SELECT id FROM users WHERE email = ?", input.Email).Scan(&userID)

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
