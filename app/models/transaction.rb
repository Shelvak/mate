class Transaction < ActiveRecord::Base
  has_paper_trail on: [:update, :destroy]

  has_magick_columns batch: :string

  belongs_to :card

  attr_accessible :amount, :batch, :card_id, :charged_at, :expiration, 
    :place_id, :auto_card_name

  attr_accessor :auto_card_name

  validates :amount, :card_id, :charged_at, :expiration, :place_id, 
    presence: true

  def to_s
    [self.card, self.batch].join(' - ')
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end

  def auto_attr_accessor_names
    attrs = []

    Transaction.attr_accessible[:default].each do |a|
      matcher = a.match(/auto_(\w+)_\w+/)
      attrs << matcher[1] if matcher
    end

    attrs
  end
end
