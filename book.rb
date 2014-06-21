module Book

	class Book
		attr_reader :title, :isbn, :isbn13

		def initialize(title, isbn=nil, isbn13=nil)
			@title = title
			@isbn = isbn
			@isbn13 = isbn13
		end

		def to_s
			"Title: #{title}, ISBN: #{isbn}, ISBN13: #{isbn13}"
		end
	end

end