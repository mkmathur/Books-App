require 'rubygems'
require 'bundler/setup'  
require 'oauth'
require 'rexml/document'
include REXML
require './book'

module Goodreads

	SITE = 'http://www.goodreads.com'

	class Base
		def initialize(oauth)
			@oauth = oauth
			@access_token = @oauth.access_token
		end

		def books_to_read
			response = @access_token.post('/review/list?format=xml&v=2', { 'shelf' => 'to-read',})
			doc = Document.new response.body
			books = XPath.match( doc, "//book" )
			books.collect! { |book|
				info = {}
				Book::ATTR.each do |a|
					info[a] = book.elements[a]
					if info[a]
						info[a] = info[a].text
					else
						info[a] = ""
					end
				end

				isbn = book.elements["isbn"]
				isbn = isbn.text unless isbn.nil?

				isbn13 = book.elements["isbn13"]
				isbn13 = isbn13.text unless isbn.nil?

				Book::Book.new(info, isbn, isbn13)
			}
		end
	end

	class Oauth
		attr_reader :access_token

		def initialize(dev_key, dev_secret)
			@key = dev_key
			@secret = dev_secret
			@access_token = nil
		end

		def consumer
			consumer = OAuth::Consumer.new(@key, @secret, :site => SITE )
		end

		def authorize_from_access(access_token, access_token_secret)
			@access_token = OAuth::AccessToken.new(consumer, access_token, access_token_secret)
		end
	end
end