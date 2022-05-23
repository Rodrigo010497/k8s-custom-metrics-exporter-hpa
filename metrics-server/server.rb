require 'sinatra'
require_relative 'sinatra_ssl'
set :ssl_certificate, "server.cert"
set :ssl_key, "server.key"
set :port, 6443

get '/try' do
    "helloworld"
end