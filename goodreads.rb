require 'rubygems'
require 'bundler/setup'  
require 'oauth'
require 'rexml/document'
include REXML

module Goodreads

	SITE = 'http://www.goodreads.com'

	class Base
		def initialize(session)
			@access_token = session.access_token
		end

		def books_to_read
			shelf('to-read')
		end	

		def shelf(name, debug=false)
			response = @access_token.post('/review/list?format=xml&v=2', { 'shelf' => name,})
			doc = Document.new response.body
			if debug
				File.open("XML_doc.xml", "w") do |file|
					file.puts doc 
				end
			end
			Shelf.new(doc)
		end				

	end

	class Shelf
		# data is a REXML::Document
		def initialize(doc)
			@books = XPath.match(doc, "//book").collect! { |elem|
					Book.new(elem)
				}
		end

		def each(&block)
			@books.each(&block)
		end

		def [](index)
			@books[index]
		end
	end

	class Book
		attr_reader :title, :isbn, :isbn13, :author, :avg_rating, :img_url, :link, :ratings_count

		# data is the REXML::Element for a single book
		def initialize(data)
			@data = data
			@title = text('title')
			@isbn = text('isbn')
			@isbn13 = text('isbn13')
			@author = text('authors/author/name')
			@avg_rating = text('average_rating')
			@img_url = text('small_image_url')
			@link = text('link')
			@ratings_count = text('ratings_count')
		end

		def text(key)
			@data.elements[key].text unless @data.elements[key].nil?
		end
	end
end