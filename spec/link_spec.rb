require 'spec_helper'

describe "Link" do
  it "can be created with a specified (http://) url" do
    link = OVOST::Link.new('http://www.google.com')
    expect(link).to be_a(OVOST::Link)
  end

  it "links back to ovo.st if link of input is very short" do
    link = OVOST::Link.new("asdf")
    expect(link.destination_url).to eq("http://ovo.st")
  end

  before do
    @link = OVOST::Link.new("twitter.com")
  end

  it "prepends an http:// on links with no protocol" do
    # link = OVOST::Link.new("twitter.com")
    expect(@link.destination_url).to eq("http://twitter.com")
  end

  it "increments counter when clicked" do
    # link = OVOST::Link.new("twitter.com")
    expect(@link.click_count).to eq(0)
    @link.click
    expect(@link.click_count).to eq(1)
    @link.click
    expect(@link.click_count).to eq(2)
  end

  it "returns destination_url when clicked" do
    expect(@link.click).to eq("http://twitter.com")
  end
end
