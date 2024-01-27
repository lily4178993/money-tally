FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    sequence(:icon) { |n| "g/gi#{n}.svg" }
    user
  end
end
