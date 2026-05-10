class Keyword < ApplicationRecord
  has_many :kukai_keywords, dependent: :destroy
  has_many :kukais, through: :kukai_keywords
  has_many :posts, dependent: :destroy

  validates :word, presence: true, uniqueness: true
  validates :len, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
end
