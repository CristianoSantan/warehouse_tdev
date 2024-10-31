require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe "gera um número de série" do
    it "ao criar um StockProduct" do
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
        city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
        estimated_delivery_date:  1.day.from_now)
      product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70, width: 80, sku: 'CGMER-XPTO-888', supplier: supplier)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.serial_number.length).to eq 20 
    end
    it "e não pe modificado" do
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
      other_warehouse = Warehouse.create!(name: 'Guarulhos', code: 'GRU', city: 'Guarulhos', area: 1_000,
        address: 'Av Ipiranga, 2000', cep: '30000-000', description: 'Galpão do São Paulo')
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
        city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
        estimated_delivery_date:  1.day.from_now)
      product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70, width: 80, sku: 'CGMER-XPTO-888', supplier: supplier)
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial_number = stock_product.serial_number

      stock_product.update(warehouse: other_warehouse)

      expect(stock_product.serial_number).to eq original_serial_number
    end
  end

  describe "#available?" do
    it "true se não tiver destino" do
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
        city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
        estimated_delivery_date:  1.day.from_now)
      product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70, width: 80, sku: 'CGMER-XPTO-888', supplier: supplier)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)

      expect(stock_product.available?).to eq true
    end
    
    it "false se não tiver destino" do
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
        city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
        estimated_delivery_date:  1.day.from_now)
      product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70, width: 80, sku: 'CGMER-XPTO-888', supplier: supplier)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      stock_product.create_stock_product_destination!(recipient: 'João', address: "Rua do Joao")

      expect(stock_product.available?).to eq false
    end
  end
end
