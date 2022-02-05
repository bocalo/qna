FactoryBot.define do
  factory :link do
    name { "MyString" }
    url { "https://google.ru" }
  end

  trait :linkable do
    association :linkable, factory: :answer
  end

  trait :valid_gist do
    url { 'https://gist.github.com/bocalo/d0cf3e6b1b07ccd02100d04dd32e9e52' }
  end

  trait :invalid_gist do
    url { 'https://gist.github.com/bocalo/' }
  end
end
