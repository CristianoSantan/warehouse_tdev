require 'rails_helper'

describe "Usuário informa novo status de pedido" do
  it "e pedido foi entregue" do
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    order = Order.create!(user:joao, warehouse:warehouse, supplier:supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    login_as joao
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Entregue'
    expect(page).not_to have_content 'Marcar como CANCELADO'
  end
  it "e pedido foi cancelado" do
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    order = Order.create!(user:joao, warehouse:warehouse, supplier:supplier, estimated_delivery_date: 1.day.from_now, status: :pending)

    login_as joao
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'
    
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
  end
end