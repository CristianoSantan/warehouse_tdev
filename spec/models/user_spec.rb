require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#description" do
    it "exibe o nome e o email" do
      user = User.new(name: 'Julia Almeida', email: 'julia@yahoo.com')

      result = user.description()
    
      expect(result).to eq 'Julia Almeida - julia@yahoo.com'
    end
  end
end