class Invitation < ApplicationRecord
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :initial_password, presence: true, length: { minimum: 4 }

  before_create :generate_token

  def used?
    used_at.present?
  end

  def use!
    update!(used_at: Time.current)
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(32)
  end
end
