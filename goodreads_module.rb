require 'rubygems'
require 'bundler/setup'  
require 'oauth'
require 'rexml/document'
include REXML

module Goodreads
	# developer key
	KEY = "Yf6QamFRu4dL3dhbz237Sw"
	SECRET = "RrkCTmZIS8zuNsjuNf412vaZmlHHJ17W6pRRVsr4"

	def url
		@consumer = OAuth::Consumer.new(KEY, SECRET, :site => "http://www.goodreads.com")
		@request_token = @consumer.get_request_token
		@request_token.authorize_url
	end
end