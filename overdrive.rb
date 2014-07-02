module Overdrive

	SITE = "http://mock.api.overdrive.com/v1/patrons/me"

	class Base
		def initialize(session)
			#todo
		end

		def find(isbn)
			#todo - return availability 
		end
	end

	class Availability
		attr_reader :editions, :borrow, :hold

		def initialize
			#todo
		end
	end
end