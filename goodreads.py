import requests
from flask import g
from flask_oauth import OAuth

KEY = "Yf6QamFRu4dL3dhbz237Sw"
SECRET = "RrkCTmZIS8zuNsjuNf412vaZmlHHJ17W6pRRVsr4"

oauth = OAuth()
goodreads = oauth.remote_app('goodreads',
    base_url='http://www.goodreads.com/oauth/request_token',
    request_token_url='http://www.goodreads.com/oauth/request_token',
    access_token_url='http://www.goodreads.com/oauth/access_token',
    authorize_url='http://www.goodreads.com/oauth/authorize',
    consumer_key=KEY,
    consumer_secret=SECRET
)

request_token, request_token_secret = goodreads.get_request_token(header_auth=True)

authorize_url = goodreads.get_authorize_url(request_token)
print('Visit this URL in your browser: ' + authorize_url)
accepted = 'n'
while accepted.lower() == 'n':
    # you need to access the authorize_link via a browser,
    # and proceed to manually authorize the consumer
    accepted = raw_input('Have you authorized me? (y/n) ')

session = goodreads.get_auth_session(request_token, request_token_secret)

response = requests.get("https://www.goodreads.com/review/list?format=xml&v=2&shelf=to-read&key=" + KEY)
print(response.text)