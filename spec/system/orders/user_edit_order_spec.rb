require 'rails_helper'

describe "usuário edita pedido" do
  it "e deve estar autenticado" do
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    order = Order.create!(user:joao, warehouse:warehouse, supplier:supplier, estimated_delivery_date: 1.day.from_now)

    visit edit_order_path order.id

    expect(current_path).to eq new_user_session_path
  end

  it "com sucesso" do
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    Supplier.create!(corporate_name: 'LG Corporation', brand_name: 'LG', city: 'Manaus', 
    registration_number: '100', full_address: "Rua Amazonia, 180", state: "AM", email: "contato@lg.com.br")
 
    order = Order.create!(user:joao, warehouse:warehouse, supplier:supplier, estimated_delivery_date: 1.day.from_now)

    login_as joao
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    select 'LG Corporation', from: 'Fornecedor'
    fill_in "Data Prevista de Entrega",	with: "12/12/2024" 
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: LG Corporation'
    expect(page).to have_content 'Data Prevista de Entrega: 12/12/2024'
  end

  it "caso seja o responsável" do
    andre = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    order = Order.create!(user:joao, warehouse:warehouse, supplier:supplier, estimated_delivery_date: 1.day.from_now)

    login_as andre
    visit edit_order_path order.id

    expect(current_path).to eq root_path
  end
end