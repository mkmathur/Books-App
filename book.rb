module Book

	ATTR = ["position", "cover", "title", "author", "avg_rating", "shelves", "date_added"]

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
		end
	end
end