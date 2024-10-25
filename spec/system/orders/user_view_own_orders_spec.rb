require 'rails_helper'

describe "Usuário vê seus próprios pedidos" do
  it "e deve estar autenticado" do
    
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end
  it "e não vê outros pedidos" do
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    carla = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    first_order = Order.create!(user:joao, warehouse:warehouse, supplier:supplier, estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user:carla, warehouse:warehouse, supplier:supplier, estimated_delivery_date: 1.day.from_now)
    third_order = Order.create!(user:joao, warehouse:warehouse, supplier:supplier, estimated_delivery_date: 1.week.from_now)

    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
  end
  
end