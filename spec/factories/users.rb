FactoryBot.define do
  factory :user do
    username { Faker::Name.unique.last_name}
    password {'haliho123'}
  end

end
