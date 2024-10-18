require 'rails_helper'

describe "Usuário vê fornecedores" do
  it "a partir do menu na index" do
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedores'
  end

  it "com sucesso" do
    Supplier.create!(corporate_name: 'LG Corporation', brand_name: 'LG', city: 'Manaus', 
                    registration_number: '100', full_address: "Rua Amazonia, 180", 
                    state: "AM", email: "contato@lg.com.br")
    Supplier.create!(corporate_name: 'Apple Computer Brasil', brand_name: 'Apple', city: 'São Paulo', 
                    registration_number: '200', full_address: "Rua Leopoldo, 700", 
                    state: "SP", email: "contato@apple.com.br")

    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('LG')
    expect(page).to have_content('Manaus - AM')
    expect(page).to have_content('Apple')
    expect(page).to have_content('São Paulo - SP')
  end

  it "e não existem fornecedores cadastrados" do
    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'Não existem fornecedores cadastrados.'
  end
  
end
