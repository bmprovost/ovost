require 'spec_helper'

describe "Database" do
  before do
    @db = OVOST::Database.new
  end

  it "can generate a short_id" do
    @db.instance_variable_set("@links_created", 1234567890)
    expect(@db.gen_id).to eq("kf12oi")
  end

  xit "can create a new Link with no user" do

  end

  xit "stores created links in hash indexed by short_id" do

  end

  xit "can create a new User" do

  end

  xit "can create a new link with user" do

  end

end
