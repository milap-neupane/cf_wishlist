# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin user
admin = {
  email: 'admin@cloudfactory.com',
  admin: true,
  contact_number: '999999999'
}
admin_user = User.find_or_create_by(admin).tap do |user|
  user.password = ENV['ADMIN_PASSWORD'] || 'password'
  user.save!
end