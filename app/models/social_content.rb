class SocialContent < ApplicationRecord
  has_many :social_posts, dependent: :destroy
end
