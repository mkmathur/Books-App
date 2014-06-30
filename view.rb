require './goodreads'

module View
	class Base
		HEADERS =  ["title", "author", "average rating", "num ratings"]

		# Takes a Goodreads::Shelf
		def initialize(shelf)
			@grid = []
			shelf.each do |book|
				@grid << Row.new(book)
			end
		end

		def each(&block)
			@grid.each(&block)
		end
	end

	class Row
		attr_reader :img_url, :gr_url, :title, :data

		def initialize(book)
			@img_url = book.img_url
			@gr_url = book.link
			@title = book.title
			@data = [book.author, book.avg_rating, book.ratings_count]
		end
	end
end