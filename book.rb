module Book

	HEADERS = ["Title", "Author"]

	class Book
		attr_reader :info

		def initialize(info)
			@info = info
		end

		def to_s
			@info["title"]
		end

		def array 
			[@info["title"], @info["author"]]
		end
	end

end