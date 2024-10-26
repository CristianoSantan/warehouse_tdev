require 'rails_helper'

describe "Usuário edita um pedido" do
  it "e não é o dono" do
    andre = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    order = Order.create!(user:joao, warehouse:warehouse, supplier:supplier, estimated_delivery_date: 1.day.from_now)

    login_as(andre)
    patch(order_path(order.id), params: { order: { supplier_id: 3 }})

    expect(response).to redirect_to(root_path)
  end
end