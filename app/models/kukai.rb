class Kukai < ApplicationRecord
  has_many :kukai_keywords, dependent: :destroy
  has_many :keywords, through: :kukai_keywords
  has_many :posts, dependent: :destroy

  validates :title, presence: true
  validates :year, presence: true, numericality: { only_integer: true }
  validates :month, presence: true, numericality: { only_integer: true, in: 1..12 }

  def assign_random_keywords!(count)
    count = count.to_i
    return if count <= 0

    selected_keywords = Keyword.order(Arel.sql("RANDOM()")).limit(count)

    transaction do
      selected_keywords.each do |keyword|
        kukai_keywords.find_or_create_by!(keyword: keyword)
      end
    end
  end
end
