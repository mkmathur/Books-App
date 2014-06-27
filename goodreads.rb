require 'rubygems'
require 'bundler/setup'  
require 'oauth'
require 'rexml/document'
require './book'
include REXML

module Goodreads

	SITE = 'http://www.goodreads.com'

	class Base
		def initialize(oauth)
			@access_token = oauth.access_token
		end

		def books_to_read
			shelf('to-read').books
		end	

		def shelf(name, debug=false)
			response = @access_token.post('/review/list?format=xml&v=2', { 'shelf' => name,})
			doc = Document.new response.body
			if debug
				File.open("XML_doc.xml", "w") do |file|
					file.puts doc 
				end
			end
			ShelfInfo.new(doc)
		end				

	end

	class ShelfInfo
		attr_reader :books

		# data is a REXML::Document
		def initialize(doc)
			@books = XPath.match(doc, "//book").collect! { |elem|
					BookInfo.new(elem)
				}
		end
	end

	class BookInfo
		# data is the REXML::Element for a single book
		def initialize(data)
			@data = data
		end

		def text(key)
			@data.elements[key].text unless @data.elements[key].nil?
		end

		def title
			text('title')
		end

		def isbn
			text('isbn')
		end

		def isbn13
			text('isbn13')
		end

		def author
			authors = XPath.match(xml, "authors/author/name")
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