require 'spec_helper'

describe "Link" do
  it "can be created with a specified (http://) url" do
    link = OVOST::Link.new('123', 'http://www.google.com')
    expect(link).to be_a(OVOST::Link)
  end

  it "links back to ovo.st if link of input is very short" do
    link = OVOST::Link.new('1',"asdf")
    expect(link.destination_url).to eq("http://ovo.st")
  end

  before do
    @link = OVOST::Link.new('1',"twitter.com")
  end

  it "prepends an http:// on links with no protocol" do
    expect(@link.destination_url).to eq("http://twitter.com")
  end
end
