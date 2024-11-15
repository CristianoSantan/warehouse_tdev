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

    it "and raise internal error" do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/warehouses'

      expect(response).to have_http_status 500
    end
    
  end

  context "POST /api/v1/warehouses" do
    it "success" do
      warehouse_params = { 
        warehouse: {
          name: 'Belo Horizonte', 
          code: 'BHZ', 
          area: 20000, 
          cep: '64000-000', 
          city: 'Belo Horizonte', 
          description: 'Galpão mineiro', 
          address: 'Av Tiradentes, 20'
          }
        }

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status :created
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Belo Horizonte')
      expect(json_response["code"]).to eq('BHZ')
      expect(json_response["area"]).to eq(20000)
      expect(json_response["cep"]).to eq('64000-000')
      expect(json_response["city"]).to eq('Belo Horizonte')
      expect(json_response["description"]).to eq('Galpão mineiro')
      expect(json_response["address"]).to eq('Av Tiradentes, 20')
    end

    it "fail if paramenters are not complete" do
      warehouse_params = { warehouse: { name: "Aeroporto Curitiba", code: "CWB" } }

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status 412
      expect(response.body).not_to include "Nome não pode ficar em branco"
      expect(response.body).not_to include "Código não pode ficar em branco"
      expect(response.body).to include "Cidade não pode ficar em branco"
      expect(response.body).to include "Endereço não pode ficar em branco"
    end

    it "fail if there an internal error" do
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)

      warehouse_params = { 
        warehouse: {
          name: 'Belo Horizonte', 
          code: 'BHZ', 
          area: 20000, 
          cep: '64000-000', 
          city: 'Belo Horizonte', 
          description: 'Galpão mineiro', 
          address: 'Av Tiradentes, 20'
          }
        }

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status 500
    end
  end
end