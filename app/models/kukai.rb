class Kukai < ApplicationRecord
  has_many :kukai_keywords, dependent: :destroy
  has_many :keywords, through: :kukai_keywords
  has_many :posts, dependent: :destroy
  has_many :selections, dependent: :destroy

  attribute :status, :integer, default: 0
  enum :status, { posting: 0, selecting: 1, revealed: 2 }

  validates :title, presence: true
  validates :year, presence: true, numericality: { only_integer: true }
  validates :month, presence: true, numericality: { only_integer: true, in: 1..12 }

  scope :visible, -> { where(visible: true) }

  def assign_random_keywords!(count)
    count = count.to_i
    return if count <= 0

    selected_keywords = random_keyword_candidates.limit(count)

    transaction do
      selected_keywords.each do |keyword|
        kukai_keywords.find_or_create_by!(keyword: keyword)
      end
    end
  end

  def assign_one_random_keyword!
    assign_random_keywords!(1)
  end

  private

  def random_keyword_candidates
    Keyword.where.not(id: keyword_ids).order(Arel.sql("RANDOM()"))
  end
end
