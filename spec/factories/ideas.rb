FactoryBot.define do
  factory :idea do
    title { Faker::Job.title }
    description { Faker::Lorem.paragraph }
    # The line below will create a user (using its factory)
    # before creating a job post. Then it will associate that
    # user to the job post. This is necessary to pass the validation
    # added by `belongs_to :user`
    association(:user, factory: :user)
    # association(:user, factory: :user)
    # If the factory has the same name as the association
    # You can shorten this to:
    # user
  end
end



