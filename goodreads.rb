require 'rubygems'
require 'bundler/setup'  
require 'oauth'

KEY = "Yf6QamFRu4dL3dhbz237Sw"
SECRET = "RrkCTmZIS8zuNsjuNf412vaZmlHHJ17W6pRRVsr4"

consumer = OAuth::Consumer.new(KEY,
                              SECRET,
                               :site => 'http://www.goodreads.com')
request_token = consumer.get_request_token
puts "Visit this URL: " + request_token.authorize_url
accepted = 'n'
while accepted == 'n' do
	print "Have you authorized me? (y/n) "
	accepted = gets.chomp()
end
access_token = request_token.get_access_token

