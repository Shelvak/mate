class Card < ActiveRecord::Base
  has_paper_trail

  has_magick_columns name: :string, number: :string

  has_many :transactions
  belongs_to :bank

  default_scope order('name ASC')

  attr_accessible :name, :expire_at, :number, :bank_id, :auto_bank_name

  attr_accessor :auto_bank_name

  validates :name, :number, :expire_at, presence: true
  validates :number, uniqueness: true

  def to_s
    [self.name, self.number].join(' - ')
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
