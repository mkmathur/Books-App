require 'rubygems'
require 'sinatra'
require 'Haml'
require './goodreads_module'
include Goodreads

def oauth_consumer
	OAuth::Consumer.new(KEY, SECRET, :site =>  "http://www.goodreads.com")
end

configure do
	enable :sessions
	# developer key
	KEY = "Yf6QamFRu4dL3dhbz237Sw"
	SECRET = "RrkCTmZIS8zuNsjuNf412vaZmlHHJ17W6pRRVsr4"
end

get '/' do
	request_token = oauth_consumer.get_request_token
	session[:request_token] = request_token.token 
	session[:request_token_secret] = request_token.secret 
	@url = request_token.authorize_url
	haml :index
end