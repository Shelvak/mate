class Card < ActiveRecord::Base
  has_paper_trail

  has_magick_columns name: :string

  default_scope order('name ASC')
  
  attr_accessible :address, :name, :website

  validates :name, presence: true
  validates :name, uniqueness: true

  def to_s
    self.name
  end
end
