import json
import sys
import math

# JSON piped into this script example:
# {
#   "metrics": [
#     {
#       "resource": "flask-metric-869879868f-jgbg4",
#       "value": "{\"value\": 0, \"available\": 5, \"min\": 0, \"max\": 5}"
#     }
#   ],
#   "resource": {
#     "kind": "Deployment",
#     "apiVersion": "apps/v1",
#     "metadata": {
#       "name": "flask-metric",
#       "namespace": "default",
#     },
#     ...
#   },
#   "runType": "api"
# }

def main():
    # Parse JSON into a dict
    spec = json.loads(sys.stdin.read())
    evaluate(spec)

def evaluate(spec):
    # Count total available
    total_available = 0
    for metric in spec["metrics"]:
        json_value = json.loads(metric["value"])
        available = json_value["available"]
        total_available += int(available)

    # Get current replica count
    target_replica_count = int(spec["resource"]["spec"]["replicas"])

    # Decrease target replicas if more than 5 available
    if total_available > 10:
        target_replica_count -= 1

    # Increase target replicas if none available
    if total_available <= 0:
        target_replica_count += 1

    # Build JSON dict with targetReplicas
    evaluation = {}
    evaluation["targetReplicas"] = target_replica_count
    print(evaluation)
    # Output JSON to stdout
    sys.stdout.write(json.dumps(evaluation))

if __name__ == "__main__":
    main()
