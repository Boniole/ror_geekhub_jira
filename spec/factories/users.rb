FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Travolta' }
    email { Random.hex(5)+'@gmail.com'}
    password { 'Hh'+Random.hex(7) }
  end
end