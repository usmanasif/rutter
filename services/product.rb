class Product
  SHOPIFY_STORE = ENV['SHOPIFY_STORE']

  attr_accessor :url

  def initialize
    @url = "#{SHOPIFY_STORE}/admin/api/#{ENV['API_VERSION']}/products.json"
  end

  def all
    products = []
    since_id = 0

    loop do
      response = HTTParty.get(@url += "?fields=id,title&limit=20&since_id=#{since_id}", headers: headers)
      products << JSON.parse(response.body)['products']

      break if products.last.empty?

      since_id = products.flatten.last['id']
    end

    prettify_response(products.flatten)
  end

  private

  def prettify_response(products)
    products.map do |product|
      {
        platform_id: product['id'],
        name: product['title']
      }
    end
  end

  def headers
    { "X-Shopify-Access-Token": ENV['SHOPIFY_TOKEN'] }
  end
end
