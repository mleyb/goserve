package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
)

func main() {
	router := router()
	log.Fatal(http.ListenAndServe(":8081", router))
}

func router() *mux.Router {
    router := mux.NewRouter()
    router.HandleFunc("/", index).Methods("GET")
    return router
}

func index(w http.ResponseWriter, r *http.Request) {
	hostname, err := os.Hostname()
	if err != nil {
		panic(err)
	}
	fmt.Fprintf(w, "Hello from a Go service on host %q", hostname)
}
