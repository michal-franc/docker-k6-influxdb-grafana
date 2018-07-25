.PHONY: run load-test

run: start minimal-api/minimal-api load-test

minimal-api/minimal-api:
	cd minimal-api && go build

start: data
	touch start 
	docker-compose up -d
	curl -XPOST 'http://localhost:8086/query' --data-urlencode 'q=CREATE DATABASE load_tests'
	sleep 2

data:
	mkdir -p data/grafana
	sudo chown 472:472 data/grafana
	mkdir -p data/influxdb

clean: stop
	sudo rm -rf data 

stop:
	docker-compose stop
	docker-compose rm -f
	rm start 

load-test:
	./minimal-api/minimal-api & echo $$! > api.PID
	k6 run --out influxdb=http://localhost:8086/load_tests load-tests/load_test.js
	kill `cat api.PID`
	rm api.PID
