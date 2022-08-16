require 'json'
require 'curb'
require 'yaml'
# $stdout = File.open "std-in.txt", "a"
# $stdout.close
 
spec = JSON.parse($stdin.read)
p spec
metadata = spec["resource"]["metadata"]
p metadata
labels = metadata["labels"]
p labels
retriever = Curl::Easy.new 'https://my-metrics-exporter.default.svc.cluster.local/apis/custom.metrics.k8s.io/v1beta1/namespaces/default/services/my-metrics-exporter/instance'
retriever.ssl_verify_peer = false
response = retriever.perform
p response
$stdout.write(response)
# p response