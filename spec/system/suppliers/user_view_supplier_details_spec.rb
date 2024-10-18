require 'rails_helper'

describe "Usuário vê detalhes de um fornecedor" do
  it "e vê informações adicionais" do
    Supplier.create!(corporate_name: 'LG Corporation', brand_name: 'LG', city: 'Manaus', 
                    registration_number: '100', full_address: "Rua Amazonia, 180", 
                    state: "AM", email: "contato@lg.com.br")
    
    visit root_path
    click_on 'Fornecedores'
    click_on 'LG'

    expect(page).to have_content 'LG Corporation'
    expect(page).to have_content 'Documento: 100'
    expect(page).to have_content 'Endereço: Rua Amazonia, 180 - Manaus - AM'
    expect(page).to have_content 'E-mail: contato@lg.com.br'
  end

  it 'e volta para a tela inicial' do 
    Supplier.create!(corporate_name: 'LG Corporation', brand_name: 'LG', city: 'Manaus', 
                    registration_number: '100', full_address: "Rua Amazonia, 180", 
                    state: "AM", email: "contato@lg.com.br")
    visit root_path
    click_on 'Fornecedores'
    click_on 'LG'
    click_on 'Voltar'
    
    expect(current_path).to eq root_path
  end
end