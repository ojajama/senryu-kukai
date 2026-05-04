class Post < ApplicationRecord
  belongs_to :user
  belongs_to :kukai
  belongs_to :keyword

  validates :verse, presence: true
end
