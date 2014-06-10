require 'rubygems'
require 'bundler/setup'
require 'haml'
require 'sinatra'
require 'redis'

redis = Redis.new(:url => ENV["REDIS_URL"])

configure do
  set :views, File.join(File.dirname(__FILE__), "views")
end

get '/' do
  haml :root
end
post '/' do
  if redis.sismember("emails", params[:email])
    haml :bad
  else
    haml :good
  end
end
