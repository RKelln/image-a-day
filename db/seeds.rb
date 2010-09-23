# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create :email => 'admin@mailinator.com', :password => 'password', :name => 'admin', :nickname => "admin", :admin => true
User.create :email => 'inactive@mailinator.com', :password => 'password', :name => "In Active", :nickname => "Inactive", :active => false
User.create :email => 'iad@mailinator.com', :password => 'password', :name => 'IaDname', :nickname => "IaDnick"
User.create :email => 'stu@mailinator.com', :password => 'dnib729', :name => "Stu Zilm", :nickname => "Stu"
