require 'sinatra'
require 'json'
# require_relative 'sinatra_ssl'
# set :ssl_certificate, "server.cert"
# set :ssl_key, "server.key"
# set :port, 6443
get '/apis/custom.metrics.k8s.io/v1beta1' do
  content_type 'applciation/json'
  {"status": "healthy"}.to_json

end

get '/apis/custom.metrics.k8s.io/v1beta1/namespaces/default/services/my-metrics-exporter/instance' do 
  content_type 'applciation/json'
  p 'hey'
  {
    kind: "MetricValueList",
    apiVersion: "custom.metrics.k8s.io/v1beta1",
    # metadata: {
    #     selfLink: "/apis/custom.metrics.k8s.io/v1beta1"
    # },
    items: [
      {
        describedObject: {
            kind: "Service",
            namespace: "default",
            name: "my-metrics-exporter",
            apiVersion: "/v1beta1"
        },
            metricName: "instance",
            timestamp: Time.now.strftime("%Y-%m-%dT%I:%M:%SZ"),
            value: JSON.parse(File.read("./value.json"))["value"]
        }
    ]
  }.to_json
end

get '/try' do
    "helloworld"
end

post '/change_metric' do
  metric = { value: params[:value] }
  File.write( "./value.json", JSON.dump(metric))
  {param: params.to_json, file: JSON.parse(File.read("./value.json")) }.to_json
end