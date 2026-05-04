class Kukai < ApplicationRecord
  has_many :kukai_keywords, dependent: :destroy
  has_many :keywords, through: :kukai_keywords
  has_many :posts, dependent: :destroy
end
