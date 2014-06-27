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
			books = shelf('to-read')
			books.collect! { |book|
				puts book.class.name
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

		def shelf(name, debug=false)
			response = @access_token.post('/review/list?format=xml&v=2', { 'shelf' => name,})
			doc = Document.new response.body
			if debug
				File.open("XML_doc.xml", "w") do |file|
					file.puts doc 
				end
			end
			XPath.match( doc, "//book" )
		end				

	end

	class BookInfo
		# data should be a REXML::Element 
		def initialize(data)
			@data = data
		end

		def text(key)
			data.elements[key].text unless book.elements[key].nil?
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
			puts authors 
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