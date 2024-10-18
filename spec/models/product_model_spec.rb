require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe "#valid?" do
    it "name is mandatory" do
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', 
      registration_number: '100', full_address: "Av Nações Unidas, 1000", 
      state: "SP", email: "contato@samsung.com.br")
      pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, 
      sku: 'TV32-SAMSU-XPT090', supplier: supplier)

      expect(pm).not_to be_valid
    end
    
    it "sku is mandatory" do
      supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', city: 'São Paulo', 
      registration_number: '100', full_address: "Av Nações Unidas, 1000", 
      state: "SP", email: "contato@samsung.com.br")
      pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, 
      sku: '', supplier: supplier)

      expect(pm).not_to be_valid
    end
  end
end
