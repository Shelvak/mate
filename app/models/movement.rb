class Movement < ActiveRecord::Base
  has_paper_trail  

  belongs_to :bank

  attr_accessible :amount, :bank_id, :charged_at, :client_id, :code_id, :comment, :deposited_in, 
    :devoted, :devoted_at, :mov_number, :total_amount

  validates :amount, :bank_id, :charged_at, :client_id, :code_id, :mov_number,
    presence: true

  validates :mov_number, uniqueness: true
end
