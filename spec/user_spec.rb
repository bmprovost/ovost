require 'spec_helper'
describe "User" do
  it "can initialize user" do
    newUser = OVOST::User.new('fake@email.com','134567890')
    expect(newUser).to be_a(OVOST::User)
  end
end
