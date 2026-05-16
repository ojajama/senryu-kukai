class AiGuideline < ApplicationRecord
  enum :kind, { principle: "principle", example: "example" }

  validates :body, presence: true
  validates :before_verse, :after_verse, presence: true, if: :example?

  scope :active, -> { where(active: true).order(created_at: :asc) }
  scope :active_principles, -> { active.principle }
  scope :active_examples,   -> { active.example }
end
