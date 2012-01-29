# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Flag.delete_all

Flag.create(:key => :known, :style => :hunter, :desc => "ah, i know this one")
Flag.create(:key => :hit, :style => :hunter, :desc => "this sounds good!")
Flag.create(:key => :shit, :style => :hunter, :desc => "please, no!")
Flag.create(:key => :maybe, :style => :hunter, :desc => "hmm, maybe")
Flag.create(:key => :maybe, :style => :hunter, :desc => "not my type of music")

Flag.create(:key => :hit, :style => :hipster, :desc => "great stuff")
Flag.create(:key => :maybe, :style => :hipster, :desc => "not that bad")
Flag.create(:key => :known, :style => :hipster, :desc => "i knew about this one ages ago")
Flag.create(:key => :nevermind, :style => :hipster, :desc => "this music style is bellow my par")
Flag.create(:key => :shit, :style => :hipster, :desc => "piece of crap")
Flag.create(:key => :joke, :style => :hipster, :desc => "so uncool it's cool'")



