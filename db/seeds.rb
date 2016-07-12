require 'pp'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pp CreateAdminService.new.call

case Rails.env
when 'development'
  100.times { |index| pp User.create_with(password: "password").find_or_create_by(email: "user#{index}@mail.com") }
end
