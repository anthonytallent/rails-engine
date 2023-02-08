require 'rails_helper'

RSpec.describe "items API" do
  let!(:merchant1) { create(:merchant) }
  let!(:merchant2) { create(:merchant) }
  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }
  it "sends a list of all the items" do
    create_list(:item, 3, merchant: merchant1)

    get '/api/v1/items/'

    expect(response).to be_successful

    items_hash = JSON.parse(response.body, symbolize_names: true)
    expect(items_hash).to have_key(:data)
    expect(items_hash[:data]).to be_a(Array)

    item_data = items_hash[:data]

    expect(item_data.count).to eq(5)

    item_data.each do |item|
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

  it "sends a single item's info" do
    get api_v1_item_path(item1)

    expect(response).to be_successful

    item_hash = JSON.parse(response.body, symbolize_names: true)
    expect(item_hash).to have_key(:data)
    expect(item_hash[:data]).to be_a(Hash)

    item_data = item_hash[:data]

    expect(item_data).to have_key(:id)
    expect(item_data[:id]).to be_a(String)
    
    expect(item_data).to have_key(:type)
    expect(item_data[:type]).to be_a(String)

    expect(item_data).to have_key(:attributes)
    expect(item_data[:attributes]).to be_a(Hash)

    expect(item_data[:attributes]).to have_key(:name)
    expect(item_data[:attributes][:name]).to be_a(String)

    expect(item_data[:attributes]).to have_key(:description)
    expect(item_data[:attributes][:description]).to be_a(String)

    expect(item_data[:attributes]).to have_key(:unit_price)
    expect(item_data[:attributes][:unit_price]).to be_a(Float)

    expect(item_data[:attributes]).to have_key(:merchant_id)
    expect(item_data[:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'can create a new item' do
    item_params = ({
      name: 'Juicy Juice',
      description: 'Quenchy',
      unit_price: 5.99,
      merchant_id: "#{merchant1.id}",
    })
headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq('Juicy Juice')
    expect(created_item.description).to eq('Quenchy')
    expect(created_item.unit_price).to eq(5.99)
    expect(created_item.merchant_id).to eq(merchant1.id)
  end

  it 'can update an existing item' do
    id = create(:item).id
    previous_name = Item.last.name
    previous_description = Item.last.description
    previous_unit_price = Item.last.unit_price
    item_params = {
                      name: "Jam and Toast",
                      description: "Tastes like jam and toast",
                      unit_price: 1000.99,
                      merchant_id: merchant1.id
                  }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Jam and Toast")

    expect(item.description).to_not eq(previous_description)
    expect(item.description).to eq("Tastes like jam and toast")

    expect(item.unit_price).to_not eq(previous_unit_price)
    expect(item.unit_price).to eq(1000.99)
  end
end