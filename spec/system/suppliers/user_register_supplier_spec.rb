require 'rails_helper'

describe "Usuário cadastra um fornecedor" do
  it "a partir da tela inicial" do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'

    expect(page).to have_field 'Nome Corporativo'
    expect(page).to have_field 'Marca'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Número de Registro'
    expect(page).to have_field 'Endereço Completo'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'E-mail'
  end

  it "com sucesso" do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in "Nome Corporativo",	with: "LG Corporation" 
    fill_in "Marca",	with: "LG" 
    fill_in "Cidade",	with: "Manaus" 
    fill_in "Número de Registro",	with: "100" 
    fill_in "Endereço Completo",	with: "Rua Amazonia, 180" 
    fill_in "Estado",	with: "AM" 
    fill_in "E-mail",	with: "contato@lg.com.br" 
    click_on 'Enviar'

    # expect(current_path).to eq root_path
    expect(page).to have_content 'Fornecedor cadastrado com sucesso.'
    expect(page).to have_content 'LG Corporation'
    expect(page).to have_content 'Documento: 100'
    expect(page).to have_content 'Endereço: Rua Amazonia, 180 - Manaus - AM'
    expect(page).to have_content 'E-mail: contato@lg.com.br'
  end
  
  it "com dados incompletos" do
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in "Nome Corporativo",	with: "" 
    fill_in "Marca",	with: "" 
    fill_in "Cidade",	with: "" 
    fill_in "Número de Registro",	with: "" 
    fill_in "Endereço Completo",	with: "" 
    fill_in "Estado",	with: "" 
    fill_in "E-mail",	with: "" 
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor não cadastrado.'
    expect(page).to have_content 'Nome Corporativo não pode ficar em branco'
    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Número de Registro não pode ficar em branco'
    expect(page).to have_content 'Endereço Completo não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end
