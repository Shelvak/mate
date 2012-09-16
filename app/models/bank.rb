class Bank < ActiveRecord::Base
  has_paper_trail

  has_magick_columns name: :string

  has_many :movements

  scope :with_name, ->(name) { where("#{table_name}.name like ?", "#{name}%") }

  default_scope order('name ASC')

  attr_accessible :amount, :name, :website

  validates :name, presence: true
  validates :name, uniqueness: true

  def to_s
    self.name
  end
  
  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
