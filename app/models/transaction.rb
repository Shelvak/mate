class Transaction < ActiveRecord::Base
  has_paper_trail on: [:update, :destroy]

  has_magick_columns batch: :string

  belongs_to :card

  attr_accessible :amount, :batch, :card_id, :charged_at, :expiration, :place_id

  validates :amount, :card_id, :charged_at, :expiration, :place_id, presence: true

  def to_s
    [self.card, self.batch].join(' - ')
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
