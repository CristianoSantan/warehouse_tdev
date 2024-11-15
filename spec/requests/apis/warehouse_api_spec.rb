require 'rails_helper'

describe "Warehouse API" do
  context "GET /api/v1/warehouse/1" do
    it "sucesso" do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq 200 
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to include('Aeroporto SP')
      expect(json_response["code"]).to include('GRU')
      expect(json_response.keys).not_to include('updated_at')
      expect(json_response.keys).not_to include('created_at')
    end
    
    it "fail if warehouse not found" do
      get "/api/v1/warehouses/99999999"

      expect(response.status).to eq 404
    end
  end

  context "GET /api/v1/warehouses" do
    it "list all warehouses ordered by name" do
      first_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', area: 10_000, 
                                        address: 'Avenida dos Jacarés, 1000', cep: '56000-000', 
                                        description: 'Galpão no centro do país')
      second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', area: 20000, 
                                        cep: '64000-000', city: 'Belo Horizonte', 
                                        description: 'Galpão mineiro', address: 'Av Tiradentes, 20')

      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq "Belo Horizonte"
      expect(json_response[1]["name"]).to eq "Cuiaba"
    end

    it "return empty if there is no warehouse" do
      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response =JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
end