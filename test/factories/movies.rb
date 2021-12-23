FactoryBot.define do
  factory :movie do
    association :user
    youtube_id {}
    sequence(:title) { |n| "video title #{n}" }
    sequence(:description) { |n| "video description #{n}" }
  end
end
