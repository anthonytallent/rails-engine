require 'rails_helper'

RSpec.describe "merchants items API" do
  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }
  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }

  it 'can send a list of a merchants items' do
    get api_v1_merchant_items_path(merchant1)
  
    expect(response).to be_successful

    merchants_items_hash = JSON.parse(response.body, symbolize_names: true)

    expect(merchants_items_hash).to have_key(:data)
    expect(merchants_items_hash[:data]).to be_a(Array)

    merchants_items_data = merchants_items_hash[:data]

    merchants_items_data.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)
      
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'sad path: should return 404 if the merchant id is bad' do # how do I test sad path
    get "/api/v1/merchants/#{547928523925372}/items"
  
    expect(response.status).to eq(404)
  end
end

