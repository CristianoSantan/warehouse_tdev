require 'rails_helper'

describe "Usuário vê o estoque" do
  it "na tela do galpão" do
    warehouse = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
            address: 'Avenida do Aeroporto, 1000', cep: '15000-000', 
            description: 'Galpão destinado para cargas internacionais')
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', 
      registration_number: '100', full_address: "Av Nações Unidas, 1000", state: "SP", email: "contato@samsung.com.br")
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 1.day.from_now)
    product_tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
      sku: 'TV32-SAMSU-XPT090', supplier: supplier)
    product_soundbar = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, 
      sku: 'SOU71-SAMSU-NOIZ77', supplier: supplier)
    product_notebook = ProductModel.create!(name: 'Notebook i5 16GB RAM', weight: 2000, width: 40, height: 9, depth: 20, 
      sku: 'NOTEI5-SAMSU-TLI99', supplier: supplier)

    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv)}
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_notebook)}

    login_as user
    visit root_path
    click_on 'Aeroporto SP'

    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content '3 x TV32-SAMSU-XPT090'
    expect(page).to have_content '2 x NOTEI5-SAMSU-TLI99'
    expect(page).not_to have_content 'SOU71-SAMSU-NOIZ77'
  end
end