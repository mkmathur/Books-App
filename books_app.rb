require 'rubygems'
require 'sinatra'
require 'Haml'

get '/' do
	@url = "http://www.goodreads.com"
	haml :index
end