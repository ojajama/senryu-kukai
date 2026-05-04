class Post < ApplicationRecord
  belongs_to :user
  belongs_to :kukai
  belongs_to :keyword
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :verse, presence: true
end
