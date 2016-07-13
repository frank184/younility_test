require 'pp'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pp CreateAdminService.new.call

# case Rails.env
# when 'development'
  labels = [
    {name: 'Back-end Developer', colour: '#ff0000'},
    {name: 'Front-end Developer', colour: '#00ff00'},
    {name: 'Database Administrator', colour: '#cc0099'},
    {name: 'Project Manager', colour: '#ffff00'},
    {name: 'Project Manager', colour: '#ffff00'}
  ].each { |label| Label.find_or_create_by(label) }
  100.times { |index| pp User.create_with(password: "password").find_or_create_by(email: "user#{index}@mail.com") }
  User.find_each do |user|
    label = Label.all.sample
    user.labels << label
    puts user.save ? "Added #{label.name} label to #{user.email}" : "#{user.email} already had #{label.name}"
  end
# end
