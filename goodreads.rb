require 'rubygems'
require 'bundler/setup'  
require 'oauth'

KEY = "Yf6QamFRu4dL3dhbz237Sw"
SECRET = "RrkCTmZIS8zuNsjuNf412vaZmlHHJ17W6pRRVsr4"

# for multiple sessions, need these
MY_ACCESS_TOKEN = "OXjo19O4gThQMIsywElUvw"
MY_ACCESS_TOKEN_SECRET = "7lJhrwVad6Txy3yC1ws2y0J5tphC9MPaCJ9jaGFro"

=begin
# for a single session. todo: save the access token and secret somewhere
consumer = OAuth::Consumer.new(KEY,
                              SECRET,
                               :site => "http://www.goodreads.com")
request_token = consumer.get_request_token
puts "Visit this URL: " + request_token.authorize_url
accepted = "n"
while accepted == 'n' do
	print "Have you authorized me? (y/n) "
	accepted = gets.chomp()
end
access_token = request_token.get_access_token

ACCESS_TOKEN_SECRET = access_token.secret
ACCESS_TOKEN = access_token.token

puts ACCESS_TOKEN
puts ACCESS_TOKEN_SECRET
=end


# in subsequent sessions, we'll rebuild the access token
consumer = OAuth::Consumer.new(KEY,
                               SECRET,
                               :site => 'http://www.goodreads.com')
access_token = OAuth::AccessToken.new(consumer, MY_ACCESS_TOKEN, MY_ACCESS_TOKEN_SECRET)

response = access_token.post('/review/list?format=xml&v=2', {
             'shelf' => 'to-read',
           })

shelf = response.body