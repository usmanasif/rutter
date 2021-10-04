require 'spec_helper'

describe 'App' do
  subject(:product) { Product.new }

  before do
    stub_request(:get,
                 'https://rutterinterview.myshopify.com/admin/api/2021-07/products.json?fields=id,title&limit=20&since_id=0').
      to_return(status: 200, body: dummy_response)

    stub_request(:get,
                 'https://rutterinterview.myshopify.com/admin/api/2021-07/products.json?fields=id,title&limit=20&since_id=2').
      to_return(status: 200, body: empty_response)

    product.all
  end

  it 'returns all products' do
    get '/products'

    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)['products'].count).to eq(2)
  end

  private

  def dummy_response
    {
      products: [
        {
          id: 1,
          title: 'A great product',
        },
        {
          id: '2',
          title: 'Another great product'
        }
      ]
    }.to_json
  end

  def empty_response
    {
      products: []
    }.to_json
  end
end
