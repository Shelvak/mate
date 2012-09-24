class Code < ActiveRecord::Base
  has_paper_trail

  has_magick_columns number: :integer, detail: :string

  has_many :movements

  attr_accessible :detail, :number

  validates :detail, :number, presence: true

  validates :number, uniqueness: true

  def to_s
    self.number.to_s
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
