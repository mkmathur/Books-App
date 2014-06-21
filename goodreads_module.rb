require 'rubygems'
require 'bundler/setup'  
require 'oauth'
require 'rexml/document'
include REXML

module Goodreads

	SITE = 'http://www.goodreads.com'

	class Base
		def initialize(oauth)
			@oauth = o
		end

		def books_to_read
			# todo
		end
	end

	class Oauth
		def initialize(dev_key, dev_secret)
			@key = dev_key
			@secret = dev_secret
			@access_token = nil
		end

		def consumer
			consumer = OAuth::Consumer.new(@key, @secret, :site => SITE )
		end

		def authorize_from_access(access_token, access_token_secret)
			@access_token = OAuth::AccessToken.new(consumer, access_token, access_token_secret)
		end
	end
end