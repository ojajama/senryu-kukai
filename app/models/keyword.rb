class Keyword < ApplicationRecord
  has_many :kukai_keywords, dependent: :destroy
  has_many :kukais, through: :kukai_keywords
  has_many :posts, dependent: :destroy
end
