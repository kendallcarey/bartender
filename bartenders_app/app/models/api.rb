
# response = HTTParty.get('http://api.yelp.com/v2/')
# headers.inspect

# # Or wrap things up in your own class

# class Yelp
#   include HTTParty
#   base_uri 'api.yelp.com/v2'

#   def initialize(, page)
#     @key =
#     @secret = ENV['SECRET']
#     @token = ENV['TOKEN']
#     @token_secret = ENV['SECRET_TOKEN']
#   end
# end

# yelp = Yelp.new("yelp", 1)

client = Yelp::Client.new({ consumer_key: ENV['YELP_CONSUMER_KEY'],
                            consumer_secret: ENV['YELP_CONSUMER_SECRET'],
                            token: ENV['YELP_TOKEN'],
                            token_secret: ENV['YELP_TOKEN_SECRET']
                          })
