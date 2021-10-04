require 'sinatra'
require 'json'

class Rutter < Sinatra::Base
  before do
    content_type :json
  end

  get '/products' do
    products = Product.new.all
    puts products

    { products: products }.to_json
  end
end
