require './lib/ovost.rb'

RSpec.configure do |config|
  # Reset singleton instance before every test
  config.before(:each) do
    Singleton.__init__(OVOST::Database)
  end
end
