require_relative 'lib/ovost.rb'

database = OVOST::Database.new
terminal = OVOST::Terminal.new(database)
terminal.menu
