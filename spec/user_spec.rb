require 'spec_helper'
describe "User" do
  it "can initialize user" do
    new_user = OVOST::User.new('fake@email.com','134567890', 3)
    expect(new_user).to be_a(OVOST::User)
  end
end
