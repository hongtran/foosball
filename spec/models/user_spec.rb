require 'rails_helper'

RSpec.describe User, type: :model do
  describe "check validate user" do
    let(:user){user = User.new(first_name: "", last_name: "")}
    it "check for presence of first name, last name" do
      user.save
      expect(user.errors).to_not be_empty
      expect(user.errors[:first_name]).to include "can't be blank"
      expect(user.errors[:last_name]).to include "can't be blank"
    end  
  end  
end
