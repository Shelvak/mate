class Client < ActiveRecord::Base
  has_paper_trail on: [:update, :destroy]

  has_magick_columns name: :string, ident: :string

  attr_accessible :email, :ident, :name, :phone, :website

  validates :name, :email, :ident, presence: true 
  validates :name, :email, :ident, uniqueness: true 

  def to_s
    [self.name, self.ident].join(' - ')
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
