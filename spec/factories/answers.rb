FactoryBot.define do
  factory :answer do
    body { "MyText" }
    question { nil }

    trait :invalid_answer do
      body { nil }
    end
  end
end






