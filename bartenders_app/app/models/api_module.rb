require 'dotenv'
Dotenv.load

response = HTTParty.get('http://api.yelp.com/v2/')
headers.inspect

# Or wrap things up in your own class

class Yelp
  include HTTParty
  base_uri 'api.yelp.com/v2'

  def initialize(, page)
    @key = ENV['KEY']
    @secret = ENV['SECRET']
    @token = ENV['TOKEN']
    @token_secret = ENV['SECRET_TOKEN']
  end
end

yelp = Yelp.new("yelp", 1)

