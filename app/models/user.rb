class User < ApplicationRecord
  attr_writer :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :selections, dependent: :destroy

  validates :nickname, presence: true,
                       length: { maximum: 30 },
                       uniqueness: { case_sensitive: false }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login).to_s.downcase

    where(conditions).where(
      "lower(email) = :login OR lower(nickname) = :login",
      login: login
    ).first
  end

  def login
    @login || nickname || email
  end

  def display_name
    nickname.presence || email
  end
end
