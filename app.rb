require 'rubygems'
require 'sinatra'
require 'Haml'
require './goodreads'
require './view'
require './session'
include Session

configure do
	enable :sessions
end

before do
	@gr_session = Session::Base.new(Goodreads::SITE, Goodreads::KEY, Goodreads::SECRET)
	if session[:access_token]
		@gr_session.authorize_from_access(session[:access_token], session[:access_token_secret])
		@goodreads = Goodreads::Base.new @gr_session
	else
		@goodreads = nil
	end
end

get '/' do
	haml :index
end

get '/login/goodreads' do
	request_token = @gr_session.consumer.get_request_token
	session[:request_token] = request_token.token 
	session[:request_token_secret] = request_token.secret 
	redirect request_token.authorize_url
end

get '/goodreads/access' do
	request_token = OAuth::RequestToken.new(@gr_session.consumer, 
		session[:request_token], session[:request_token_secret])
	@access_token = request_token.get_access_token
	session[:access_token] = @access_token.token
	session[:access_token_secret] = @access_token.secret
	redirect '/books?shelf=to-read'
end

get '/books' do
	redirect '/' unless @goodreads
	@js = ["//cdn.datatables.net/1.10.0/js/jquery.dataTables.js", "scripts/table.js"]
	@css = ["//cdn.datatables.net/1.10.0/css/jquery.dataTables.css"]
	shelf = @goodreads.shelf(params[:shelf])
	@headers = View::Base::HEADERS 
	@view = View::Base.new(shelf)
	haml :books
end