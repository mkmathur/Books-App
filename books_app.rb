require 'rubygems'
require 'sinatra'
require 'Haml'
require './goodreads_module'
include Goodreads

get '/' do
	@url = Goodreads.url
	haml :index
end