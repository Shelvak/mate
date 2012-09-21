class Place < ActiveRecord::Base
  has_paper_trail on: [:update, :destroy]

  attr_accessible :name

  validates :name, presence: true
  validates :name, uniqueness: true

  def to_s
    self.name
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
