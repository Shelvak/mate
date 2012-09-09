class Bank < ActiveRecord::Base
  has_paper_trail

  has_magick_columns name: :string

  attr_accessible :amount, :name, :website

  default_scope order('name ASC')

  validates :name, presence: true
  validates :name, uniqueness: true

  scope :with_name, ->(name) { where("#{table_name}.name like ?", "#{name}%") }

  def to_s
    self.name
  end
  
  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
