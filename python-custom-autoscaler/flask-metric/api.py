from flask import Flask, abort
import json
app = Flask(__name__)

MAX_METRIC = 5
MIN_METRIC = 0
global_metric = 0

@app.route("/metric")
def metric():
    return json.dumps({
        "value": global_metric,
        "available": MAX_METRIC - global_metric,
        "min": MIN_METRIC,
        "max": MAX_METRIC 
    })

@app.route("/increment", methods = ["POST"])
def increment():
    global global_metric
    if global_metric >= MAX_METRIC:
        abort(400, f"Metric cannot be incremented beyond {MAX_METRIC}")
    global_metric += 1
    return json.dumps({
        "value": global_metric,
        "available": MAX_METRIC - global_metric,
        "min": MIN_METRIC,
        "max": MAX_METRIC 
    })

@app.route("/decrement", methods = ["POST"])
def decrement():
    global global_metric
    if global_metric <= MIN_METRIC:
        abort(400, f"Metric cannot be decremented below {MIN_METRIC}")
    global_metric -= 1
    return json.dumps({
        "value": global_metric,
        "available": MAX_METRIC - global_metric,
        "min": MIN_METRIC,
        "max": MAX_METRIC 
    })

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")