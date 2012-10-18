class Cash < ActiveRecord::Base
  has_paper_trail

  KINDS = {
    money: 'm',
    dollar: 'd',
    third_checks: 't',
    own_checks: 'o'
  }

  attr_accessible :amount, :detail, :flow_id

  validates :amount, presence: true
  validates :amount, numericality: true, allow_nil: true, allow_blank: true
  
  def to_s
    self.amount
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
