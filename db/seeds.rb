# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Flag.create(:key => :known, :style => :hunter, :desc => "ah, i know this one")
Flag.create(:key => :hit, :style => :hunter, :desc => "this sounds good!")
Flag.create(:key => :shit, :style => :hunter, :desc => "please, no!")
Flag.create(:key => :maybe, :style => :hunter, :desc => "hmm, maybe")
Flag.create(:key => :maybe, :style => :hunter, :desc => "not my type of music")

Flag.create(:key => :shit, :style => :hipster, :desc => "too average for me")
Flag.create(:key => :maybe, :style => :hipster, :desc => "everybody knows this one")
Flag.create(:key => :maybe, :style => :hipster, :desc => "my mym would like this")
Flag.create(:key => :maybe, :style => :hipster, :desc => "so sad it's cool'")
Flag.create(:key => :maybe, :style => :hipster, :desc => "nobody listens to this kind of shit anymore")



