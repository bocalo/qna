FactoryBot.define do
  factory :vote do
    value { 0 }
    user { nil }
    votable { nil }
  end
end
