class Workplace < ActiveRecord::Base
  has_paper_trail

  has_magick_columns address: :string

  has_many :clients

  attr_accessible :address, :city, :country, :state

  validates :address, :country, :state, presence: true
  validates :address, uniqueness: true

  def to_s
    [self.address, self.state].join(' - ')
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
