FactoryBot.define do
  factory :goal do
  
    title { "read #{Faker::Book.unique.title}"}
    text { "Read the book from start to finish."}
    
    factory :private_goal do
      private { true }
    end

  end
end
