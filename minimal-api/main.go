package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

// GetHello returns an awesome hello world
func GetHello(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World")
}

func main() {
	http.HandleFunc("/hello", GetHello)

	srv := &http.Server{
		Addr:         ":8000",
		WriteTimeout: 5 * time.Second,
		ReadTimeout:  5 * time.Second,
	}

	log.Println("Hello world app listetning on port 8000.")
	log.Println("Try curl localhost:8000/hello")
	log.Fatal(srv.ListenAndServe())
}
