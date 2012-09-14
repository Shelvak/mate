class Advance < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :amount, :charged_at, :detail, :state

  validates :amount, :charged_at, :detail, presence: true

  validates :state, inclusion: { in: [true, false]}
end
