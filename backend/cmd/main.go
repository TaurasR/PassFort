package main

import (
	"net/http"

	"main/endpoints"

	"github.com/gin-gonic/gin"

	"database/sql"
	"log"

	_ "github.com/mattn/go-sqlite3"
)

func main() {

	db, err := sql.Open("sqlite3", "backend/db/passfort.db") //open db connection
	if err != nil {
		log.Fatal("Error opening database: ", err)
	}
	defer db.Close() // close db

	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})

	r.POST("/login", endpoints.LoginUser(db))
	r.POST("/register", endpoints.RegisterUser(db))

	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}
