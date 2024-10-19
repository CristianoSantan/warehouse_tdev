require 'rails_helper'

describe "Usuário se autentica" do
  it "com sucesso" do
    User.create!(email: 'joao@email.com', password: 'password')

    visit root_path
    click_on 'Entrar'
    within 'form' do
      fill_in "E-mail",	with: "joao@email.com" 
      fill_in "Senha",	with: "password" 
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_link 'Sair'
    within 'nav' do
      expect(page).to have_content 'joao@email.com'
    end
  end
end
