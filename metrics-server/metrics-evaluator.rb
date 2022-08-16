require json


    # Parse provided spec into a dict
spec = JSON.parse($stdin.read)

value = spec["metrics"][0]["value"].to_i

evaluation = {}
evaluation["targetReplicas"] = value

$stdout.write(evaluation.to_json)