import json
import sys
import requests

# JSON piped into this script example:
# {
#   "resource": {
#     "kind": "Deployment",
#     "apiVersion": "apps/v1",
#     "metadata": {
#       "name": "flask-metric",
#       "namespace": "default",
#     },
#     ...
#   },
#   "runType": "scaler"
# }

def main():
    # Parse JSON into a dict
    spec = json.loads(sys.stdin.read())
    metric(spec)

def metric(spec):
    # Get Pod IP
    status = spec["resource"]["status"]
    ip = status["podIP"]
    try:
        # Make request to Pod metric endpoint
        # (see ../flask-metrics/ folder for simple flask app exposing this endpoint)
        response = requests.get(f"http://{ip}:5000/metric")
        # Output whatever metrics are gathered to stdout
        sys.stdout.write(response.text)
    except HTTPError as http_err:
        # If an error occurs, output error to stderr and exit with status 1
        sys.stderr.write(f"HTTP error occurred: {http_err}")
        exit(1)
    except Exception as err:
        # If an error occurs, output error to stderr and exit with status 1
        sys.stderr.write(f"Other error occurred: {err}")
        exit(1)

if __name__ == "__main__":
    main()