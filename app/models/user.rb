class User < ApplicationRecord
  has_secure_password
  has_many :ideas, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :idea
  
  # The has_many `through` argument takes the name of another
  # has_many association creating with `has_many :association_name`.
   # If you were to use `has_many :questions` then you will have
   # two `has_many :questions` so one will override the other.
   # To fix this, we can give the association a different name
   # and specify the `source` option so that Rails can figure out
   # the other end of the association.
  # Note: the `source` option has to match a `belongs_to` association 
  # in the join model (Like in this case)


  def full_name
    "#{first_name} #{last_name}".strip
  end
end
