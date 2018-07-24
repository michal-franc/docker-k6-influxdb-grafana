.PHONY: run up down load-test

run: up build-api load-test

build-api:
	cd minimal-api && go build

up: prepare-data-folders
	docker-compose up -d
	sleep 2

prepare-data-folders:
	mkdir -p data/grafana
	sudo chown 472:472 data/grafana
	mkdir -p data/influxdb

clean: down
	sudo rm -rf data 

down:
	docker-compose stop
	docker-compose rm -f

load-test:
	./minimal-api/minimal-api & echo $$! > api.PID
	k6 run --out influxdb=http://localhost:8086/load_tests load-tests/load_test.js
	kill `cat api.PID`
	rm api.PID
