KEY = "Yf6QamFRu4dL3dhbz237Sw"
SECRET = "RrkCTmZIS8zuNsjuNf412vaZmlHHJ17W6pRRVsr4"

MY_ACCESS_TOKEN = "OXjo19O4gThQMIsywElUvw"
MY_ACCESS_TOKEN_SECRET = "7lJhrwVad6Txy3yC1ws2y0J5tphC9MPaCJ9jaGFro"

def setupTestShelf
	oauth = Goodreads::Oauth.new(KEY, SECRET)
	oauth.authorize_from_access(MY_ACCESS_TOKEN, MY_ACCESS_TOKEN_SECRET)

	gr = Goodreads::Base.new(oauth)
	gr.shelf('test', true)
end