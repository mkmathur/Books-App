module Session
	class Base
		attr_reader :access_token

		def initialize(site, dev_key, dev_secret)
			@site = site
			@key = dev_key
			@secret = dev_secret
			@access_token = nil
		end

		def consumer
			consumer = OAuth::Consumer.new(@key, @secret, :site => @site)
		end

		def authorize_from_access(access_token, access_token_secret)
			@access_token = OAuth::AccessToken.new(consumer, access_token, access_token_secret)
		end
	end
end