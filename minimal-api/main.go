package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"time"
)

// GetHello returns an awesome hello world
func GetHello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World")
}

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/hello", GetHello).Methods("GET")

	srv := &http.Server{
		Handler:      router,
		Addr:         ":8000",
		WriteTimeout: 5 * time.Second,
		ReadTimeout:  5 * time.Second,
	}

	log.Println("Hello world app listetning on port 8000.")
	log.Println("Try curl localhost:8000/hello")
	log.Fatal(srv.ListenAndServe())
}
