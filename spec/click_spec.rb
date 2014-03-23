require 'spec_helper'

describe "Click" do
  it "Takes in a link_id and stores it along with the time of click" do
    click = OVOST::Click.new(1,'1234')
    expect(click.click_id).to eq(1)
    expect(click.link_id).to eq('1234')
    expect(click.time).to be_a(Time)
  end
end
