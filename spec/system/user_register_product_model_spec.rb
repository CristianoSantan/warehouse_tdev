require 'rails_helper'

describe "Usuário cadastra um modelo do produto" do
  it "com sucesso" do
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', 
    registration_number: '100', full_address: "Av Nações Unidas, 1000", 
    state: "SP", email: "contato@samsung.com.br")

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in "Nome",	with: "TV 32" 
    fill_in "Peso",	with: 8_000
    fill_in "Altura",	with: 45
    fill_in "Largura",	with: 70
    fill_in "Profundidade",	with: 10
    fill_in "SKU",	with: "TV32-SAMSU-XPT090"
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'

    expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPT090'
    expect(page).to have_content 'Dimensão: 70cm x 45cm x 10cm'
    expect(page).to have_content 'Peso: 8000g'
  end
  
end
