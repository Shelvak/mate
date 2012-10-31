class BankAccount < ActiveRecord::Base
  has_paper_trail

  attr_accessible :number, :office_number, :kind, :currency, :amount, :bank_id
  
  validates :number, :office_number, :kind, :currency, :bank_id, presence: true
  validates :number, uniqueness: true
  
  belongs_to :bank
  
  def to_s
    self.number
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
