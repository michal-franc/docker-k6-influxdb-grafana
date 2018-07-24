import http from "k6/http";
import { check, sleep } from "k6";

export let options = {
  vus: 10,
  rps: 100,
  duration: "5s"
};

export default function() {

  let response = http.get("http://localhost:8000/hello");

  check(response, {
    "status was 200": (r) => r.status == 200,
    "time below 30ms": (r) => r.timings.duration < 30
  });
}
