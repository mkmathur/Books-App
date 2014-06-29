require './goodreads'

module View
	class Table
		HEADERS =  ["title", "author", "average rating", "num ratings"]

		# Takes a Goodreads::Shelf
		def initialize(shelf)
			@grid = []
			shelf.each do |book|
				@grid << row(book)
			end
		end

		# Takes a Goodreads::Book and returns an array containing its info
		def row(book)
			[book.title, book.author, book.avg_rating, book.ratings_count]
		end

		def each(&block)
			@grid.each(&block)
		end
	end
end