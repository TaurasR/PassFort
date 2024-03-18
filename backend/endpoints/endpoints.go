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

		if err := c.ShouldBindJSON(creds); err != nil {
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
			c.JSON(http.StatusOK, gin.H{"token": "token"})
			return
		} else {
			return
		}
		// token := GenerateJWT(user) // This needs implementation
		// c.JSON(http.StatusOK, gin.H{"token": token})
	}

}

func RegisterUser(db *sql.DB) gin.HandlerFunc {
	return func(c *gin.Context) {

	}
}

func AuthenticateLogin(c *gin.Context) {
	// Logic to authenticate the user
}
