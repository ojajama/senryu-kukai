class Selection < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :kukai

  validates :user_id, uniqueness: { scope: :post_id }
  validate :cannot_select_own_post
  validate :kukai_must_be_selecting
  validate :within_selection_limit

  private

  def cannot_select_own_post
    errors.add(:base, "自分の句は選べません") if post&.user_id == user_id
  end

  def kukai_must_be_selecting
    errors.add(:base, "選句期間ではありません") unless kukai&.selecting?
  end

  def within_selection_limit
    return unless user && kukai
    count = Selection.where(user: user, kukai: kukai).where.not(id: id).count
    errors.add(:base, "選句は3句までです") if count >= 3
  end
end
