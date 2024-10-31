require 'rails_helper'

describe "usuário adiciona itens ao pedido" do
  it "com sucesso" do
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', 
      registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    order = Order.create!(user:joao, warehouse:warehouse, supplier:supplier, estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, height: 20, depth:30, supplier: supplier, sku: 'Product-A')
    product_b = ProductModel.create!(name: 'Produto B', weight: 1, width: 10, height: 20, depth:30, supplier: supplier, sku: 'Product-B')
    product_c = ProductModel.create!(name: 'Produto C', weight: 1, width: 10, height: 20, depth:30, supplier: supplier, sku: 'Product-C')

    login_as joao
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in "Quantidade",	with: 8 
    click_on 'Gravar'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end

  it "e não vê produtos de outro fornecedor" do
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier_a = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', 
      registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    supplier_b = Supplier.create!(corporate_name: 'LG Corporation', brand_name: 'LG', city: 'Manaus', 
      registration_number: '200', full_address: "Rua Amazonia, 180", state: "AM", email: "contato@lg.com.br")
    order = Order.create!(user:joao, warehouse:warehouse, supplier:supplier_a, estimated_delivery_date: 1.day.from_now)
    product_a = ProductModel.create!(name: 'Produto A', weight: 1, width: 10, height: 20, depth:30, supplier: supplier_a, sku: 'Product-A')
    product_b = ProductModel.create!(name: 'Produto B', weight: 1, width: 10, height: 20, depth:30, supplier: supplier_b, sku: 'Product-B')

    login_as joao
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
  
end