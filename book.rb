module Book

	ATTR = ["title", "author", "average rating", "shelves", "date added"]

	class Book
		attr_reader :info

		def initialize(info, isbn, isbn13)
			@info = info
			@isbn = isbn
			@isbn13 = isbn13
		end

		def to_s
			@info["title"]
		end

		def array
			arr = []
			ATTR.each do |a|
				arr << info[a]
			end
			arr
		end
	end
end