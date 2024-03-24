package endpoints

import (
	"database/sql"
	"log"
	"net/http"

	"main/userManagement"

	"strconv"

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

func LoginUser(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		var creds LoginCredentials

		if err := c.ShouldBindJSON(&creds); err != nil {
			log.Printf("Error occurred: %v", err)
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request body"})
			return
		}

		//Implement user fetch from database
		user, err := userManagement.GetUserData(db, creds.Username)
		if err != nil {
			log.Println("User was not returned")
			return
		}

		if userManagement.CheckPasswordMatchLogin(creds.Password, user.PasswordHashed) {
			if creds.BioAuth {
				c.JSON(http.StatusOK, gin.H{"token": "token"})
				// token := GenerateJWT(user) // This needs implementation
				// c.JSON(http.StatusOK, gin.H{"token": token})
			} else {
				//call email verification
				// userManagement.SendVerificationCode(user.Email, db) // We could work around this
				c.JSON(http.StatusUnauthorized, gin.H{
					"error": "Biometric authentication failed. Sending verification code.",
					"id":    strconv.Itoa(user.Id),
				})
			}
			return
		} else {
			return
		}

	}

}

func Register(db *sql.DB) gin.HandlerFunc {
	return userManagement.RegisterUser(db)
}

func DebugUsers(db *sql.DB) gin.HandlerFunc {
	return userManagement.FetchUsers(db)
}

func SendVerificationCode(db *sql.DB) gin.HandlerFunc {
	return userManagement.SendVerificationCode(db)
}

func VerifyVerificationCode(db *sql.DB) gin.HandlerFunc {
	return userManagement.VerifyCode(db)
}