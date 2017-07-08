class Deposit < ApplicationRecord
  validates :user_id,       presence: true
  validates :amount,        presence: true

  belongs_to :user
end
