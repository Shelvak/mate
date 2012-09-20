class Workplace < ActiveRecord::Base
  has_paper_trail

  has_magick_columns address: :string

  default_scope order('address ASC')

  attr_accessible :address, :city, :client_id, :country, :state

  validates :address, :client_id, :country, :state, presence: true
  validates :address, uniqueness: true

  def to_s
    [self.address, self.state].join(' - ')
  end
end
