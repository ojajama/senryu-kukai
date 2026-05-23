class Post < ApplicationRecord
  belongs_to :user
  belongs_to :kukai
  belongs_to :keyword
  has_many :likes, dependent: :destroy
  has_many :selections, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_revisions, dependent: :destroy

  before_validation :combine_verse_parts

  validates :verse, presence: { message: "上の句・中の句・下の句のいずれかを入力してください" }

  private

  def combine_verse_parts
    parts = [verse_upper, verse_middle, verse_lower].map { |p| p&.strip.presence }.compact
    self.verse = parts.join if parts.any?
  end
end
