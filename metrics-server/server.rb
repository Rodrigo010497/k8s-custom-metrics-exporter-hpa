require 'sinatra'
require 'json'
require_relative 'sinatra_ssl'
set :ssl_certificate, "server.cert"
set :ssl_key, "server.key"
set :port, 6443

get '/apis/custom.metrics.k8s.io/v1beta1' do
  content_type 'applciation/json'
  {"status": "healthy"}.to_json

end

get '/apis/custom.metrics.k8s.io/v1beta1/namespaces/default/services/my-metrics-exporter/instance' do 
  content_type 'applciation/json'
  {
    kind: "MetricValueList",
    apiVersion: "custom.metrics.k8s.io/v1beta1",
    metadata: {
        selfLink: "/apis/custom.metrics.k8s.io/v1beta1"
    },
    items: [
      {
        describedObject: {
            kind: "Service",
            namespace: "default",
            name: "my-metrics-exporter",
            apiVersion: "/v1beta1"
        },
            metricName: "instance",
            timestamp: "time",#(Time.now.getutc).to_s,
            value: 6 #session[:vualto_user] ? Job.queued.count : Job.queued.where(client: session[:client]).count
        }
    ]
  }.to_json
end

get '/try' do
    "helloworld"
end