FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyText" }
    user
    
    trait :invalid do
      title { nil }
    end

    trait :question_files do
      after :create do |question|
        question.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"), filename: 'rails_helper.rb')
      end
    end
  end
end
