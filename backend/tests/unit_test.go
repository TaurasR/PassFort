package tests

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"main/endpoints"
	"main/userManagement"

	"github.com/gin-gonic/gin"
)

func TestCreatePassword(t *testing.T) {
	// Create a new Gin context for testing
	router := gin.Default()
	router.GET("/password", endpoints.CreatePassword)

	// Create a new HTTP request to the "/password" endpoint
	req, err := http.NewRequest("GET", "/password", nil)
	if err != nil {
		t.Fatal(err)
	}

	// Create a new HTTP recorder to capture the response
	rec := httptest.NewRecorder()

	// Serve the HTTP request and record the response
	router.ServeHTTP(rec, req)

	// Check the HTTP status code
	if rec.Code != http.StatusOK {
		t.Errorf("expected status code %d, got %d", http.StatusOK, rec.Code)
	}

	// Parse the JSON response body
	var response struct {
		Password string `json:"password"`
	}
	err = json.Unmarshal(rec.Body.Bytes(), &response)
	if err != nil {
		t.Fatal(err)
	}

	// Check if the generated password is not empty
	if response.Password == "" {
		t.Error("expected non-empty password, got empty password")
	} else {
		t.Log("PASSED: Password is not empty")
	}

	// Add more assertions as needed
	if len(response.Password) != 16 {
		t.Errorf("expected password length of 16, got %d", len(response.Password))
	} else {
		t.Log("PASSED: Password length is 16")
	}
}

func TestGenerateUserKey(t *testing.T) {
	username := "testuser"

	key, err := userManagement.GenerateUserKey(username)
	if err != nil {
		t.Fatalf("generateUserKey returned an error: %v", err)
	}

	if len(key) != 32 {
		t.Errorf("generateUserKey returned a key of incorrect length: got %v want %v", len(key), 32)
	}
}
