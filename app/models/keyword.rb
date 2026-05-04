class Keyword < ApplicationRecord
  has_many :posts, dependent: :destroy
end
