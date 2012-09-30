class Card < ActiveRecord::Base
  has_paper_trail

  has_magick_columns name: :string

  has_many :transactions

  default_scope order('name ASC')

  attr_accessible :address, :name, :website

  validates :name, presence: true
  validates :name, uniqueness: true

  def to_s
    self.name
  end

  alias_method :label, :to_s

  def as_json(options = nil)
    default_options = {
      only: [:id],
      methods: [:label]
    }

    super(default_options.merge(options || {}))
  end

  def self.filtered_list(query)
    query.present? ? magick_search(query) : scoped
  end
end
