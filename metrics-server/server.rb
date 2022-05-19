require 'sinatra/base'
require 'webrick'
require 'webrick/https'
require 'openssl'

require 'sinatra'
require './sinatra_ssl'

set :ssl_certificate, "server.crt"
set :ssl_key, "server.key"
set :port, 9494

get '/try' do
    "helloworld"
end