require 'rails_helper'

describe "Usuário remove um galpão" do
  it "com sucesso" do
    warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', area: 10000, 
    address: 'Avenida dos Jacarés, 1000', cep: '56000-000', 
    description: 'Galpão no centro do país')

    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso' 
    expect(page).not_to have_content 'Cuiaba' 
    expect(page).not_to have_content 'CWB'
  end

  it "e não apaga outros galpões" do
    first_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', area: 10000, 
                                        address: 'Avenida dos Jacarés, 1000', cep: '56000-000', 
                                        description: 'Galpão no centro do país')
    second_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', area: 10000, 
                                        address: 'Avenida dos Jacarés, 1000', cep: '56000-000', 
                                        description: 'Galpão no centro do país')

    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso' 
    expect(page).to have_content 'Belo Horizonte' 
    expect(page).not_to have_content 'Cuiaba'
  end
end
