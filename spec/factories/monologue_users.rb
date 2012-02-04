# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, class: Monologue::User do
    name "John Doe"
    email "jdoe@example.com"
    password "secret"
  end
end