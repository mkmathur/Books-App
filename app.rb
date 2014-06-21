require 'rubygems'
require 'sinatra'
require 'Haml'
require './goodreads'

def oauth_consumer
	OAuth::Consumer.new(KEY, SECRET, :site =>  "http://www.goodreads.com")
end

configure do
	enable :sessions
	KEY = "Yf6QamFRu4dL3dhbz237Sw"
	SECRET = "RrkCTmZIS8zuNsjuNf412vaZmlHHJ17W6pRRVsr4"
end

before do
	if session[:access_token]
		gr_oauth = Goodreads::Oauth.new(KEY, SECRET)
		gr_oauth.authorize_from_access(session[:access_token], session[:access_token_secret])
		@goodreads = Goodreads::Base.new(gr_oauth)
	else
		@goodreads = nil
	end
end

get '/' do
	request_token = oauth_consumer.get_request_token
	session[:request_token] = request_token.token 
	session[:request_token_secret] = request_token.secret 
	@url = request_token.authorize_url
	haml :index
end

get '/books' do
	redirect '/' unless @goodreads
	haml :books
end