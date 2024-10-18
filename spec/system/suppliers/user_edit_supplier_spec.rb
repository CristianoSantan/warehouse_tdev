require 'rails_helper'

describe "Usuário edita um fornecedor" do
  it "a partir da página de detalhes" do
    Supplier.create!(corporate_name: 'LG Corporation', brand_name: 'LG', city: 'Manaus', 
                    registration_number: '100', full_address: "Rua Amazonia, 180", 
                    state: "AM", email: "contato@lg.com.br")
    
    visit suppliers_path
    click_on 'Fornecedores'
    click_on 'LG'
    click_on 'Editar'

    expect(page).to have_content('Editar Fornecedor')
    expect(page).to have_field('Nome Corporativo')
    expect(page).to have_field('Marca')
    expect(page).to have_field('Número de Registro')
    expect(page).to have_field('Endereço Completo')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('E-mail')
  end

  it "com sucesso" do
    Supplier.create!(corporate_name: 'LG Corporation', brand_name: 'LG', city: 'Manaus', 
    registration_number: '100', full_address: "Rua Amazonia, 180", 
    state: "AM", email: "contato@lg.com.br")

    visit suppliers_path
    click_on 'LG'
    click_on 'Editar'
    fill_in "Nome Corporativo",	with: "Apple Computer Brasil" 
    fill_in "Marca",	with: "Apple"
    fill_in "E-mail",	with: "contato@apple.com.br" 
    fill_in "Cidade",	with: "Porto Alegre" 
    fill_in 'Estado', with: 'RS' 
    fill_in "Número de Registro",	with: "500" 
    fill_in "Endereço Completo",	with: "Rua Rio Grande, 450"
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor atualizado com sucesso.'
    expect(page).to have_content 'Apple Computer Brasil'
    expect(page).to have_content 'Documento: 500'
    expect(page).to have_content 'Endereço: Rua Rio Grande, 450 - Porto Alegre - RS'
    expect(page).to have_content 'E-mail: contato@apple.com.br'
  end
  
  it "e mantém os campos obrigatórios" do
    Supplier.create!(corporate_name: 'LG Corporation', brand_name: 'LG', city: 'Manaus', 
    registration_number: '100', full_address: "Rua Amazonia, 180", 
    state: "AM", email: "contato@lg.com.br")

    visit suppliers_path
    click_on 'LG'
    click_on 'Editar'
    fill_in "Nome Corporativo",	with: "" 
    fill_in "Marca",	with: "" 
    fill_in "Cidade",	with: "" 
    fill_in "Número de Registro",	with: "" 
    fill_in "Endereço Completo",	with: "" 
    fill_in "Estado",	with: "" 
    fill_in "E-mail",	with: "" 
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o fornecedor.'
  end
  
end

