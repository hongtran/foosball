class User < ApplicationRecord
  has_one :team
  validates :first_name, presence: true
  validates :last_name, presence: true
end
