# require 'webrick/ssl'

# module Sinatra
#   class Application
#     def self.run!
#       certificate_content = File.open(ssl_certificate).read
#       key_content = File.open(ssl_key).read

#       server_options = {
#         :BindAddress => 'https://my-metrics-exporter.default.svc.cluster.local',
#         :Port => port,
#         :SSLEnable => true,
#         :SSLCertificate => OpenSSL::X509::Certificate.new(certificate_content),
#         # 123456 is the Private Key Password
#         :SSLPrivateKey => OpenSSL::PKey::RSA.new(key_content)
#       }
#       Rack::Handler::WEBrick.run self, server_options do |server|
#         [:INT, :TERM].each { |sig| trap(sig) { server.stop } }
#         server.threaded = settings.threaded if server.respond_to? :threaded=
#         set :running, true
#       end
#     end
#   end
# end

# 380
num_of_jobs = 30
pods = 2
runs_pending_jobs = []
runs_num_jobs = []
1.times do 
  metric_threshold = 1
  num_pods = pods 
  # pods += 1
  metric = ((num_of_jobs - num_pods).to_f/num_pods)
  # p "metric: " + metric.to_s + "/" + metric_threshold.to_s 
  # p "num_pods: " + num_pods.to_s
  # p "num_of_jobs: " + num_of_jobs.to_s
  # p "pending: #{ num_of_jobs - num_pods }"
  # p "=========="
  num_of_new_pods = 1
  until ( num_pods == (num_pods + num_of_new_pods)) do
    num_of_new_pods = num_pods == metric_threshold < metric ? 1 : 0
    num_pods += num_of_new_pods
    metric = ((num_of_jobs - num_pods).to_f/num_pods)
    # p "metric: " + metric.to_s + "/" + metric_threshold.to_s 
    # p "num_pods: " + num_pods.to_s
    # p "num_of_jobs: " + num_of_jobs.to_s
    # p "pending: #{ num_of_jobs - num_pods }"
    # p "=========="
    runs_pending_jobs << [num_of_jobs - num_pods, num_of_jobs]
  end
  
  num_of_jobs += 1
  # p '*********************************************'
end

p runs_pending_jobs
# runs_pending_jobs.each_with_index do |val, index| 
#   break if index+1 > (runs_pending_jobs.length - 1)
  
#   p (runs_pending_jobs[index+1][0] - val[0]).to_s + " " + "-" * (runs_pending_jobs[index+1][0] - val[0])   
# end
# p '******************'
runs_pending_jobs.each_with_index do |val, index| 
  p val[0].to_s + " " + (val[1] - val[0]).to_s
end

runs_pending_jobs.each_with_index do |val, index| 
  p (val[0].to_f/val[1]).round(2).to_s + " " + "-"*((val[0].to_f/val[1]).round(2)*100)
end
 
p 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaa'


num_of_jobs = 30
pods = 2
runs_pending_jobs = []
runs_num_jobs = []
1.times do 
  metric_threshold = 1
  num_pods = pods 
  # pods += 1
  metric = (num_of_jobs - num_pods)
  # p "metric: " + metric.to_s + "/" + metric_threshold.to_s 
  # p "num_pods: " + num_pods.to_s
  # p "num_of_jobs: " + num_of_jobs.to_s
  # p "pending: #{ num_of_jobs - num_pods }"
  # p "=========="
  num_of_new_pods = 1
  until ( num_pods == (num_pods + num_of_new_pods)) do
    num_of_new_pods = metric > metric_threshold ? 1 : 0
    num_pods += num_of_new_pods
    metric = num_of_jobs - num_pods
    # p "metric: " + metric.to_s + "/" + metric_threshold.to_s 
    # p "num_pods: " + num_pods.to_s
    # p "num_of_jobs: " + num_of_jobs.to_s
    # p "pending: #{ num_of_jobs - num_pods }"
    # p "=========="
    runs_pending_jobs << [num_of_jobs - num_pods, num_of_jobs]
  end
  
  num_of_jobs += 1
  # p '*********************************************'
end

p runs_pending_jobs
# runs_pending_jobs.each_with_index do |val, index| 
#   break if index+1 > (runs_pending_jobs.length - 1)
  
#   p (runs_pending_jobs[index+1][0] - val[0]).to_s + " " + "-" * (runs_pending_jobs[index+1][0] - val[0])   
# end
# p '******************'
runs_pending_jobs.each_with_index do |val, index| 
  p val[0].to_s + " " + (val[1] - val[0]).to_s
end

runs_pending_jobs.each_with_index do |val, index| 
  p (val[0].to_f/val[1]).round(2).to_s + " " + "-"*((val[0].to_f/val[1]).round(2)*100)
end
 