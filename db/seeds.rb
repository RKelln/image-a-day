# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create :email => 'iad@mailinator.com', :password => 'iad', :name => 'IaDname', :nickname => "IaDnick"
User.create :email => 'stu@mailinator.com', :password => 'dnib729', :name => "Stu Zilm", :nickname => "Stu"
