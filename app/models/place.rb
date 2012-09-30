class Place < ActiveRecord::Base
  has_magick_columns name: :string

  attr_accessible :name

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :transactions

  def to_s
    self.name
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
