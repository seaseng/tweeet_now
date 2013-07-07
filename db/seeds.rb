require 'faker'


20.times do
  User.create(name: Faker::Name.first_name,
              email:  Faker::Internet.email,
              password: 'password',
              password_confirmation:  'password')
end


