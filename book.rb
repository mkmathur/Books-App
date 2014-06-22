module Book

	class Book
		attr_reader :title, :isbn, :isbn13, :author

		def initialize(title, isbn=nil, isbn13=nil, author=nil)
			@title = title
			@isbn = isbn
			@isbn13 = isbn13
			@author = author
		end

		def to_s
			"Title: #{title}, ISBN: #{isbn}, ISBN13: #{isbn13}"
		end
	end

end