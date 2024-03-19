package userManagement

import (
	"database/sql"
	"log"

	"golang.org/x/crypto/bcrypt"

	_ "github.com/mattn/go-sqlite3"
)

type User struct {
	Id             int
	Username       string `json:"username" binding:"required"`
	PasswordHashed string `json:"password" binding:"required"`
	Name           string `json:"name" binding:"required"`
	Surname        string `json:"surname" binding:"required"`
	Email          string `json:"email" binding:"required"`
}

func GetUserData(db *sql.DB, username string) (*User, error) {

	var user User

	err := db.QueryRow("SELECT id, username, password FROM users WHERE username = ?", username).Scan(&user.Id, &user.Username, &user.PasswordHashed)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Fatal("The user doesn't exist in the database")
		}
		return nil, err
	}
	return &user, nil
}

func CheckPasswordMatchLogin(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}
