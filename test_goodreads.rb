require './goodreads'
require './book'
require "test/unit"
include Book

# developer key
KEY = "Yf6QamFRu4dL3dhbz237Sw"
SECRET = "RrkCTmZIS8zuNsjuNf412vaZmlHHJ17W6pRRVsr4"

# these are my access token and secret
MY_ACCESS_TOKEN = "OXjo19O4gThQMIsywElUvw"
MY_ACCESS_TOKEN_SECRET = "7lJhrwVad6Txy3yC1ws2y0J5tphC9MPaCJ9jaGFro"

oauth = Goodreads::Oauth.new(KEY, SECRET)
oauth.authorize_from_access(MY_ACCESS_TOKEN, MY_ACCESS_TOKEN_SECRET)

gr = Goodreads::Base.new(oauth)
data = Goodreads::BookInfo.new(gr.shelf('test', true))

class TestBookInfo < Test::Unit::TestCase
	def test_title
		#todo
	end

	def test_authors
		#todo
	end

	def test_isbn
		#todo
	end

	def test_isbn13
		#todo
	end

	def test_average_rating
		#todo
	end

	def test_shelves
		#todo
	end

	def test_date_added
		#todo
	end
end
