require 'rails_helper'

describe "Usuário vê modelos de produtos" do
  it "se estiver autenticado" do
    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq new_user_session_path
  end
  
  it "a partir do menu" do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    login_as(user)
    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq product_models_path
  end

  it "com sucesso" do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', 
    registration_number: '100', full_address: "Av Nações Unidas, 1000", 
    state: "SP", email: "contato@samsung.com.br")
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
    sku: 'TV32-SAMSU-XPT090', supplier: supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, 
    sku: 'SOU71-SAMSU-NOIZ77', supplier: supplier)
    
    login_as(user)
    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPT090'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SOU71-SAMSU-NOIZ77'
    expect(page).to have_content 'Samsung'
  end

  it "e não existem produtos cadastrados" do
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')

    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'

    expect(page).to have_content 'Nenhum modelo de produto cadastrado.'
  end
  
end
