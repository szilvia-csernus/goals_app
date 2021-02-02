FactoryBot.define do
  factory :comment do
  
    text { Faker::Quote.famous_last_words }
    
  end
end