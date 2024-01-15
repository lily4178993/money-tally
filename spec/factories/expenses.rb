FactoryBot.define do
  factory :expense do
    name { 'MyString' }
    amount { 1.5 }
    association :author, factory: :user
  end
end
