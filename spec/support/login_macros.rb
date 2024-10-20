def login(user)
  click_on 'Entrar'
    within 'form' do
      fill_in "E-mail",	with: user.email
      fill_in "Senha",	with: user.password
      click_on 'Entrar'
    end 
end