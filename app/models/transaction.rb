class Transaction < ActiveRecord::Base
  has_paper_trail on: [:update, :destroy]

  belongs_to :card

  attr_accessible :amount, :batch, :card_id, :charged_at, :expiration, :place_id

  validates :amount, :card_id, :charged_at, :expiration, :place_id, presence: true
end
