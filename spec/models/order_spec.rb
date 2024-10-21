require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#valid?" do
    it "deve ter um código" do
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
        city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
        estimated_delivery_date: '2022-10-01')

      result = order.valid?

      expect(result).to be true 
    end
  end
  
  describe "Gera um código aleatório" do
    it "ao criar um novo pedido" do
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
        city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
        estimated_delivery_date: '2022-10-01')
      
      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it "e o código é único" do
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
        city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
        estimated_delivery_date: '2022-10-01')
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, 
        estimated_delivery_date: '2022-11-15')
      
      second_order.save!

      expect(second_order.code).not_to eq first_order.code
    end
  end
end