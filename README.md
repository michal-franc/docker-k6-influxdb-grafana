Sample project showing how to use `k6` to load test a simple `api` with `influxdb` as a time series data target and `grafana` for visualizations.

Dependancies:
- docker-compose -> `sudo apt-get install docker-compose`
- go - https://golang.org/dl/
- k6 - https://github.com/loadimpact/k6 if you have go 10+ installation is pretty simple `go get github.com/loadimpact/k6`

based on 
https://github.com/nicolargo/docker-influxdb-grafana

### GO minimal API

It uses simple api in `GO` which binds to `:8000` port and exposes `/hello` endpoint.

### Influxdb and Grafana

Influxdb uses default configuration apart from `max-body-size` which was increased to accept `HTTP` requests sent from `K6` engine running `load_test.js` script.

Grafana uses provisioning to spin up an instance with automatically configured data source of `InfluxDB` and default dashboard for `K6` - https://grafana.com/dashboards/2587.

### Makefile and how to run the sample

To run the sample use `make run`. This automatically creates:
- docker swarm with InfluxDB and Grafana instance
- load_tests database on InfluxDB
- folders to hold data for Grafana and InfluxDB
- compiles minimal go app
- starts minimal go app in paraller process keeping the PID in file for later kill
- starts k6 to generate load test data and sends it to InfluxDB 

After `make run` you need to open browser and go to `localhost:3000` log in as `admin:admin` and open the dashboard.


Enjoy :)
