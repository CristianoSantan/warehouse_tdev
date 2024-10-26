require 'rails_helper'

describe "Usuário cadastra um pedido" do
  it "e deve estar autenticado" do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end
  
  it "com sucesso" do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', area: 20000, cep: '64000-000', city: 'Belo Horizonte', 
      description: 'Galpão mineiro', address: 'Av Tiradentes, 20')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    Supplier.create!(corporate_name: 'LG Corporation', brand_name: 'LG', city: 'Manaus', 
      registration_number: '100', full_address: "Rua Amazonia, 180", state: "AM", email: "contato@lg.com.br")
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in "Data Prevista de Entrega",	with: 1.day.from_now
    click_on 'Gravar'

    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung Eletronicos LTDA'
    expect(page).to have_content 'Usuário Responsável: João - joao@email.com'
    date = Order.last.estimated_delivery_date
    expect(page).to have_content "Data Prevista de Entrega: #{I18n.localize(date)}"
    expect(page).to have_content 'Situação do Pedido: Pendente'
    expect(page).not_to have_content 'Galpão Manaus'
    expect(page).not_to have_content 'LG Corporation'
  end

  it "e data estimada de entrega não deve ser passada" do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', area: 20000, cep: '64000-000', city: 'Belo Horizonte', 
      description: 'Galpão mineiro', address: 'Av Tiradentes, 20')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    Supplier.create!(corporate_name: 'LG Corporation', brand_name: 'LG', city: 'Manaus', 
      registration_number: '100', full_address: "Rua Amazonia, 180", state: "AM", email: "contato@lg.com.br")
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in "Data Prevista de Entrega",	with: 1.day.ago
    click_on 'Gravar'

    expect(page).to have_content 'Pedido não cadastrado.'
    expect(page).to have_content 'Data Prevista de Entrega deve ser futura.'
  end
end