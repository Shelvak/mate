class Code < ActiveRecord::Base
  has_paper_trail

  has_many :movements

  attr_accessible :detail, :number

  validates :detail, :number, presence: true

  validates :number, uniqueness: true
end
