require 'rails_helper'

RSpec.describe "Merchants API" do
  let!(:merchant1) { create(:merchant) }

  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants_hash = JSON.parse(response.body, symbolize_names: true)
    expect(merchants_hash).to have_key(:data)
    expect(merchants_hash[:data]).to be_a(Array)

    merchant_data = merchants_hash[:data]
    expect(merchant_data.count).to eq(4)

    merchant_data.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "sends the info on a single merchant" do
    get api_v1_merchant_path(merchant1)

    expect(response).to be_successful

    merchant_hash = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_hash).to have_key(:data)
    expect(merchant_hash[:data]).to be_a(Hash)

    merchant_data = merchant_hash[:data]

    expect(merchant_data).to have_key(:id)
    expect(merchant_data[:id]).to be_a(String)
    
    expect(merchant_data).to have_key(:type)
    expect(merchant_data[:type]).to be_a(String)

    expect(merchant_data).to have_key(:attributes)
    expect(merchant_data[:attributes]).to be_a(Hash)

    expect(merchant_data[:attributes]).to have_key(:name)
    expect(merchant_data[:attributes][:name]).to be_a(String)
  end

  it "finds a merchant based on a name search (even a partial name searchs)" do
    merchant = Merchant.create(name: "Sandy B")
    get "/api/v1/merchants/find?name=san"

    merchant_hash = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_hash).to have_key(:data)
    expect(merchant_hash[:data]).to be_a(Hash)

    merchant_data = merchant_hash[:data]

    expect(merchant_data).to have_key(:id)
    expect(merchant_data[:id]).to be_a(String)
    
    expect(merchant_data).to have_key(:type)
    expect(merchant_data[:type]).to be_a(String)

    expect(merchant_data).to have_key(:attributes)
    expect(merchant_data[:attributes]).to be_a(Hash)

    expect(merchant_data[:attributes]).to have_key(:name)
    expect(merchant_data[:attributes][:name]).to be_a(String)
  end

  it "will not work without the query param name" do
    get "/api/v1/merchants/find"

    expect(response.status).to eq(400)
  end

  it "will not work if the name query param is empty" do
    get "/api/v1/merchants/find?name="

    expect(response.status).to eq(400)
  end

  it "will not return an error code if no name matches" do
    get "/api/v1/merchants/find?name=zzzzzz"

    expect(response.status).to eq(400)
  end
end