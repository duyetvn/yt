FactoryBot.define do
  factory :vote do
    association :user
    association :movie
    state { %w(voted_up voted_down).sample }

    trait :voted_up do
      state  { 'voted_up' }
    end

    trait :voted_down do
      state  { 'voted_down' }
    end
  end
end
